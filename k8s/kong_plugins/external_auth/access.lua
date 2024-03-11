local http = require "socket.http"

local _M = {}

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

local function authorize(conf)
    local url = kong.request.get_host() .. kong.request.get_path()
    local token = kong.request.get_header('authorization')
    token = token:gsub("Bearer ", "")

    local req_url = conf.auth_endpoint .. '?url=' .. urlencode(url) .. '&token=' .. urlencode(token)
    local b, c, h = http.request(req_url)
    if c == 401 then
        kong.response.exit(401)
    end
end

function _M.execute(conf)
    authorize(conf)
end

return _M
