local http = require "socket.http"
local lrucache = require "resty.lrucache"

local ExternalAuthHandler = {
    VERSION = "0.0.1",
    PRIORITY = 1000001
}

local function char_to_hex(c)
    return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

local metacache = setmetatable({}, { __mode = "k" })
local metacache_size = 10 ^ 4

local REQ_DENY = 1
local REQ_ALLOW = 0

local function authorize(conf, url, token)
    local req_url = conf.auth_endpoint .. '?url=' .. urlencode(url) .. '&token=' .. urlencode(token)
    local b, c, h = http.request(req_url)
    if c == 401 then
        return REQ_DENY
    end

    return REQ_ALLOW
end

local function auth(conf)
    -- get auth token from header
    local token = kong.request.get_header('authorization')
    token = token:gsub("Bearer ", "")

    -- deny request if token is empty
    if string.len(token) == 0 then
        kong.response.exit(401)
    end

    -- get url by combining host and path
    local url = kong.request.get_host() .. kong.request.get_path()

    -- initialize cache
    local cache = metacache[conf]
    if not cache then
        cache = lrucache.new(metacache_size)
        metacache[conf] = cache
    end

    -- create cache key
    local cache_key = url .. token
    local match = cache:get(cache_key)

    -- deny request if matches unauthorized request
    if match == REQ_DENY then
        kong.response.exit(401)
    end

    -- perform actual authorization if match not found
    if not match then
        local is_authorized = authorize(conf, url, token)
        if is_authorized == REQ_DENY then
            cache:set(cache_key, REQ_DENY, 60 * 10)
            kong.response.exit(401)
        else
            cache:set(cache_key, REQ_ALLOW, 60 * 60)
        end
    end

    -- log authorized token
    kong.log.notice("token: ", token)
end

function ExternalAuthHandler:access(conf)
    auth(conf)
end

return ExternalAuthHandler
