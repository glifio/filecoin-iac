local http = require "socket.http"

local _M = {}

local function mirror(conf)
    local real_path = kong.ctx.shared.mirror_path
    local body = kong.ctx.shared.mirror_body

    if conf.mirror_to and string.len(body) > 0 then
        for _, value in ipairs(conf.mirror_to) do
            http.request(value .. real_path, body)
            collectgarbage("collect")
        end
    end
end

function _M.execute(conf)
    mirror(conf)
end

return _M
