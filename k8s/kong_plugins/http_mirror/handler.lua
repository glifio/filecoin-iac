local access = require "kong.plugins.http-mirror.access"

local HttpMirrorHandler = {
    VERSION = "0.0.1",
    PRIORITY = 1500
}

function HttpMirrorHandler:access(conf)
    access.execute(conf)
end

return HttpMirrorHandler