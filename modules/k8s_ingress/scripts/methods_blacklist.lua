local body = kong.request.get_raw_body()
local methods = {${methods}}

for i, v in ipairs(methods) do
    if string.find(body, '"' .. v .. '"') ~= nil then
        kong.response.exit(403, '{"error":{"message":"method \'' .. v .. '\' not allowed"}}')
        break
    end
end
