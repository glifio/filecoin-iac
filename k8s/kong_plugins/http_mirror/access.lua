local socket = require "socket"

local http = require "socket.http"
local ltn12 = require "ltn12"

local get_path = kong.request.get_path
local get_raw_body = kong.request.get_raw_body

local _M = {}

local function mirror(conf)
    local path = get_path()
    local body = get_raw_body()

    kong.log(body)

    if conf.mirror_to and string.len(body) > 0 then
        for _, value in ipairs(conf.mirror_to) do
            local r, c, h, s = http.request{
                method = "POST",
                url = value .. path,
                source = ltn12.source.string(body),
                headers = {
                    ["Content-Type"] = "application/json",
                    ["Content-Length"] = string.len(body)
                },
                sink = nil,
                create = function ()
                    local req_sock = socket.tcp()
                    req_sock:settimeout(0.05, 't')
                    return req_sock
                end
            }
        end
    end
end

function _M.execute(conf)
    mirror(conf)
end

return _M