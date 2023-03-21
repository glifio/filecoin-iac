local http = require "socket.http"

local _M = {}

local function mirror(conf)
    local path = kong.request.get_path()
    local body = kong.request.get_raw_body()

    local real_path = path
    if path == "/" then
        real_path = "/rpc/v1"
    end

    if conf.mirror_to and string.len(body) > 0 then
        for _, value in ipairs(conf.mirror_to) do
            http.request(value .. real_path, body)
        end
    end
end

function _M.execute(conf)
    mirror(conf)
end

return _M