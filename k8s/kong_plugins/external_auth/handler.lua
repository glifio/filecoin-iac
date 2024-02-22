local access = require "kong.plugins.external-auth.access"

local ExternalAuthHandler = {
    VERSION = "0.0.1",
    PRIORITY = 1000001
}

function ExternalAuthHandler:access(conf)
    access.execute(conf)
end

return ExternalAuthHandler
