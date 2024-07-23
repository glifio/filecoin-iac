local http = require "socket.http"
local ltn12 = require "ltn12"

local _M = {}

local function mirror(conf)
    local path = kong.request.get_path()
    local body = kong.request.get_raw_body()

    local real_path = path
    if path == "/" then
        real_path = "/rpc/v1"
    end

    kong.log.notice("real_path: ", real_path, ", body: ", body)
    if conf.mirror_to and string.len(body) > 0 and body ~= nil then
        for _, value in ipairs(conf.mirror_to) do
            http.request { method = "POST", url = value .. real_path, source = ltn12.source.string(body), headers = { ["Content-Type"] = "application/json", ["Content-Length"] = string.len(body) } }
            collectgarbage("collect")
        end
    end
end

function _M.execute(conf)
    mirror(conf)
end

return _M
