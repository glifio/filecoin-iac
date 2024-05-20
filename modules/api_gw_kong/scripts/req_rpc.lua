kong.log.set_serialize_value('request.body', kong.request.get_raw_body())

local token = kong.request.get_header('authorization')
token = token:gsub("Bearer ", "")
kong.log.set_serialize_value('request.token', token)
