local typedefs = require "kong.db.schema.typedefs"

return {
    name = "external_auth",
    fields = {
        {
            consumer = typedefs.no_consumer
        },
        {
            config = {
                type = "record",
                fields = {
                    {
                        auth_endpoint = {
                            type = "string",
                            required = true
                        }
                    }
                }
            }
        }
    }
}
