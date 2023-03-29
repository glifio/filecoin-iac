local access = require "kong.plugins.http-mirror.access"
local log = require "kong.plugins.http-mirror.log"

local HttpMirrorHandler = {
    VERSION = "0.0.1",
    PRIORITY = 1500
}

function HttpMirrorHandler:access(conf)
    access.execute(conf)
end

function HttpMirrorHandler:log(conf)
    log.execute(conf)
end

return HttpMirrorHandler