local http = require "socket.http"

local _M = {}

local function mirror(conf)
    local path = kong.request.get_path()
    local body = kong.request.get_raw_body()

    local real_path = path
    if path == "/" then
        real_path = "/rpc/v1"
    end

    kong.ctx.shared.mirror_path = real_path
    kong.ctx.shared.mirror_body = body
end

function _M.execute(conf)
    mirror(conf)
end

return _M
