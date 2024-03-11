local typedefs = require "kong.db.schema.typedefs"

return {
    name = "http-mirror",
    fields = {{
        consumer = typedefs.no_consumer
    }, {
        config = {
            type = "record",
            fields = {{
                mirror_to = {
                    type = "array",
                    required = true,
                    elements = {
                        type = "string"
                    }
                }
            }}
        }
    }}
}
