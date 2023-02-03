local extractStringJsonValue

function extractStringJsonValue (json, key)
  local pattern = [["]] .. key .. [["%s*:%s*"([^"]*)"]]
  local startIndex, endIndex, valueStr = string.find(json, pattern)
  return valueStr, startIndex, endIndex
end

if kong.response.get_status() == 200 then
    local body = kong.response.get_raw_body()

    kong.response.set_raw_body(parsed["result"])
end

