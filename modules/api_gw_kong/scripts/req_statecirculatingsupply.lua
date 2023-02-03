local request_body = '{"jsonrpc":"2.0","method":"Filecoin.StateCirculatingSupply","id":42,"params":[[]]}'
kong.service.request.set_raw_body(request_body)
