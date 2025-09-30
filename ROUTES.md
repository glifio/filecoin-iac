# Ingresses

This document describes the ingresses in the system and how they work.

<!-- vscode-markdown-toc -->
* [api.node.glif.io](#api.node.glif.io)
	* [POST /](#POST)
	* [OPTIONS /](#OPTIONS)
	* [GET /*proxyPath](#GETproxyPath)
	* [ANY /api/*proxyPath](#ANYapiproxyPath)
	* [ANY /subgraph/*proxyPath](#ANYsubgraphproxyPath)
	* [GET /dilutedsupply](#GETdilutedsupply)
	* [GET /rpc/v0](#GETrpcv0)
	* [OPTIONS /rpc/v0](#OPTIONSrpcv0)
	* [POST /rpc/v0](#POSTrpcv0)
	* [GET /rpc/v1](#GETrpcv1)
	* [OPTIONS /rpc/v1](#OPTIONSrpcv1)
	* [POST /rpc/v1](#POSTrpcv1)
	* [GET /statecirculatingsupply](#GETstatecirculatingsupply)
	* [GET /statecirculatingsupply/fil](#GETstatecirculatingsupplyfil)
	* [GET /statecirculatingsupply/fil/v2](#GETstatecirculatingsupplyfilv2)
	* [GET /vmcirculatingsupply](#GETvmcirculatingsupply)
* [api.calibration.node.glif.io](#api.calibration.node.glif.io)
	* [POST /](#POST-1)
	* [OPTIONS /](#OPTIONS-1)
	* [GET /*proxyPath](#GETproxyPath-1)
	* [ANY /api/*proxyPath](#ANYapiproxyPath-1)
	* [ANY /subgraph/*proxyPath](#ANYsubgraphproxyPath-1)
	* [GET /dilutedsupply](#GETdilutedsupply-1)
	* [GET /rpc/v0](#GETrpcv0-1)
	* [OPTIONS /rpc/v0](#OPTIONSrpcv0-1)
	* [POST /rpc/v0](#POSTrpcv0-1)
	* [GET /rpc/v1](#GETrpcv1-1)
	* [OPTIONS /rpc/v1](#OPTIONSrpcv1-1)
	* [POST /rpc/v1](#POSTrpcv1-1)
	* [GET /statecirculatingsupply](#GETstatecirculatingsupply-1)
	* [GET /statecirculatingsupply/fil](#GETstatecirculatingsupplyfil-1)
	* [GET /statecirculatingsupply/fil/v2](#GETstatecirculatingsupplyfilv2-1)
	* [GET /vmcirculatingsupply](#GETvmcirculatingsupply-1)
* [filecoin.tools, cid.filecoin.tools](#filecoin.toolscid.filecoin.tools)
	* [ANY /](#ANY)
	* [ANY /api/*proxyPath](#ANYapiproxyPath-1)
	* [ANY /docs/*proxyPath](#ANYdocsproxyPath)
* [calibration.filecoin.tools, cid.calibration.filecoin.tools](#calibration.filecoin.toolscid.calibration.filecoin.tools)
	* [ANY /](#ANY-1)
	* [ANY /api/*proxyPath](#ANYapiproxyPath-1)
	* [ANY /docs/*proxyPath](#ANYdocsproxyPath-1)
* [node.glif.io](#node.glif.io)
	* [ANY /space06/lotus/*proxyPath](#ANYspace06lotusproxyPath)
	* [ANY /fvm-archive/lotus/*proxyPath](#ANYfvm-archivelotusproxyPath)
	* [ANY /thegraph/lotus/*proxyPath](#ANYthegraphlotusproxyPath)
	* [ANY /coinfirm/lotus/*proxyPath](#ANYcoinfirmlotusproxyPath)
	* [ANY /space07/lotus/*proxyPath](#ANYspace07lotusproxyPath)
* [wss.node.glif.io](#wss.node.glif.io)
	* [ANY /apigw/lotus/*proxyPath](#ANYapigwlotusproxyPath)
* [wss.calibration.node.glif.io](#wss.calibration.node.glif.io)
	* [ANY /apigw/lotus/*proxyPath](#ANYapigwlotusproxyPath-1)
* [monitoring.node.glif.io](#monitoring.node.glif.io)
	* [ANY /*proxyPath](#ANYproxyPath)
* [calibration.node.glif.io](#calibration.node.glif.io)
	* [ANY /archive/lotus/*proxyPath](#ANYarchivelotusproxyPath)
* [auth.node.glif.io](#auth.node.glif.io)
	* [ANY /*proxyPath](#ANYproxyPath-1)

<!-- vscode-markdown-toc-config
	numbering=false
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


## <a name='api.node.glif.io'></a>api.node.glif.io

### <a name='POST'></a>POST /

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Set request path to `/rpc/v1`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public mainnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v1 cache port of public mainnet service.

### <a name='OPTIONS'></a>OPTIONS /

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='GETproxyPath'></a>GET /*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='ANYapiproxyPath'></a>ANY /api/*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='ANYsubgraphproxyPath'></a>ANY /subgraph/*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='GETdilutedsupply'></a>GET /dilutedsupply

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-prod.s3.amazonaws.com/diluted_supply.html](http://circulatingsupply-prod.s3.amazonaws.com/diluted_supply.html)

### <a name='GETrpcv0'></a>GET /rpc/v0

Plugins:

- Apply CORS policies.
- Set request path to `/`.

Route request to auth app frontend service.

### <a name='OPTIONSrpcv0'></a>OPTIONS /rpc/v0

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='POSTrpcv0'></a>POST /rpc/v0

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public mainnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v0 cache port of public mainnet service.

### <a name='GETrpcv1'></a>GET /rpc/v1

Plugins:

- Apply CORS policies.
- Set request path to `/`.

Route request to auth app frontend service.

### <a name='OPTIONSrpcv1'></a>OPTIONS /rpc/v1

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='POSTrpcv1'></a>POST /rpc/v1

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public mainnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v1 cache port of public mainnet service.

### <a name='GETstatecirculatingsupply'></a>GET /statecirculatingsupply

Plugins:

- Apply CORS policies.
- Set request method to `POST`.
- Set request path to `/rpc/v0`.
- Set request body to `{"jsonrpc":"2.0","method":"Filecoin.StateCirculatingSupply","id":42,"params":[[]]}`
- If response code is 200, return the value of the `result` field of the response JSON.
- Clear response header `Content-Length`.

Route request to lotus daemon port of the public mainnet service.

### <a name='GETstatecirculatingsupplyfil'></a>GET /statecirculatingsupply/fil

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-prod.s3.amazonaws.com/index.html](http://circulatingsupply-prod.s3.amazonaws.com/index.html).

### <a name='GETstatecirculatingsupplyfilv2'></a>GET /statecirculatingsupply/fil/v2

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-staging.s3.amazonaws.com/index.html](http://circulatingsupply-staging.s3.amazonaws.com/index.html).

### <a name='GETvmcirculatingsupply'></a>GET /vmcirculatingsupply

Plugins:

- Apply CORS policies.
- Set request method to `POST`.
- Set request path to `/rpc/v0`.
- Set request body to `{"jsonrpc":"2.0","method":"Filecoin.StateVMCirculatingSupplyInternal","id":42,"params":[[]]}`
- If response code is 200, set response body to the value of the `FilCirculating` field of the response JSON.
- Clear response header `Content-Length`.

Route request to lotus daemon port of the public mainnet service.

## <a name='api.calibration.node.glif.io'></a>api.calibration.node.glif.io

### <a name='POST-1'></a>POST /

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Set request path to `/rpc/v1`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public calibnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v1 cache port of public calibnet service.

### <a name='OPTIONS-1'></a>OPTIONS /

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='GETproxyPath-1'></a>GET /*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='ANYapiproxyPath-1'></a>ANY /api/*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='ANYsubgraphproxyPath-1'></a>ANY /subgraph/*proxyPath

Plugins:

- Apply CORS policies.

Route request to auth app frontend service.

### <a name='GETdilutedsupply-1'></a>GET /dilutedsupply

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-prod.s3.amazonaws.com/diluted_supply.html](http://circulatingsupply-prod.s3.amazonaws.com/diluted_supply.html)

### <a name='GETrpcv0-1'></a>GET /rpc/v0

Plugins:

- Apply CORS policies.
- Set request path to `/`.

Route request to auth app frontend service.

### <a name='OPTIONSrpcv0-1'></a>OPTIONS /rpc/v0

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='POSTrpcv0-1'></a>POST /rpc/v0

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public calibnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v0 cache port of public calibnet service.

### <a name='GETrpcv1-1'></a>GET /rpc/v1

Plugins:

- Apply CORS policies.
- Set request path to `/`.

Route request to auth app frontend service.

### <a name='OPTIONSrpcv1-1'></a>OPTIONS /rpc/v1

Plugins:

- Apply CORS policies.
- Set response header `Content-Type` to `application/json`.
- Set response body to `{"statusCode": 200}`.

Return custom response immediately.

### <a name='POSTrpcv1-1'></a>POST /rpc/v1

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- If `Authorization` header is absent in the request, apply rate-limit of 100 requests a minute.
- If `Authorization` header is present in the request, authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public calibnet fleet API token.
- Set response header `Content-Type` to `application/json`.

Route request to dedicated RPC v1 cache port of public calibnet service.

### <a name='GETstatecirculatingsupply-1'></a>GET /statecirculatingsupply

Plugins:

- Apply CORS policies.
- Set request method to `POST`.
- Set request path to `/rpc/v0`.
- Set request body to `{"jsonrpc":"2.0","method":"Filecoin.StateCirculatingSupply","id":42,"params":[[]]}`
- If response code is 200, return the value of the `result` field of the response JSON.
- Clear response header `Content-Length`.

Route request to lotus daemon port of the public calibnet service.

### <a name='GETstatecirculatingsupplyfil-1'></a>GET /statecirculatingsupply/fil

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-prod.s3.amazonaws.com/index.html](http://circulatingsupply-prod.s3.amazonaws.com/index.html).

### <a name='GETstatecirculatingsupplyfilv2-1'></a>GET /statecirculatingsupply/fil/v2

Plugins:

- Apply CORS policies.

Route request to [http://circulatingsupply-staging.s3.amazonaws.com/index.html](http://circulatingsupply-staging.s3.amazonaws.com/index.html).

### <a name='GETvmcirculatingsupply-1'></a>GET /vmcirculatingsupply

Plugins:

- Apply CORS policies.
- Set request method to `POST`.
- Set request path to `/rpc/v0`.
- Set request body to `{"jsonrpc":"2.0","method":"Filecoin.StateVMCirculatingSupplyInternal","id":42,"params":[[]]}`
- If response code is 200, set response body to the value of the `FilCirculating` field of the response JSON.
- Clear response header `Content-Length`.
- Set response header to 

Route request to lotus daemon port of the public calibnet service.

## <a name='filecoin.toolscid.filecoin.tools'></a>filecoin.tools, cid.filecoin.tools

### <a name='ANY'></a>ANY /

Plugins:

- Apply CORS policies.

Route request to mainnet CID checker frontend service.

### <a name='ANYapiproxyPath-1'></a>ANY /api/*proxyPath

Plugins:

- Apply CORS policies.

Route request to mainnet CID checker backend service.

### <a name='ANYdocsproxyPath'></a>ANY /docs/*proxyPath

Plugins:

- Apply CORS policies.

Route request to mainnet CID checker backend service.

## <a name='calibration.filecoin.toolscid.calibration.filecoin.tools'></a>calibration.filecoin.tools, cid.calibration.filecoin.tools

### <a name='ANY-1'></a>ANY /

Plugins:

- Apply CORS policies.

Route request to calibnet CID checker frontend service.

### <a name='ANYapiproxyPath-1'></a>ANY /api/*proxyPath

Plugins:

- Apply CORS policies.

Route request to calibnet CID checker backend service.

### <a name='ANYdocsproxyPath-1'></a>ANY /docs/*proxyPath

Plugins:

- Apply CORS policies.

Route request to calibnet CID checker backend service.

## <a name='node.glif.io'></a>node.glif.io

### <a name='ANYspace06lotusproxyPath'></a>ANY /space06/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to public mainnet fleet API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the public mainnet service.

### <a name='ANYfvm-archivelotusproxyPath'></a>ANY /fvm-archive/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to FVM archive API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the FVM archive service.

### <a name='ANYthegraphlotusproxyPath'></a>ANY /thegraph/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to TheGraph API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the TheGraph service.

### <a name='ANYcoinfirmlotusproxyPath'></a>ANY /coinfirm/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to FVM archive API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the FVM archive service.

### <a name='ANYspace07lotusproxyPath'></a>ANY /space07/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to Space07 API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the Space07 service.

## <a name='wss.node.glif.io'></a>wss.node.glif.io

### <a name='ANYapigwlotusproxyPath'></a>ANY /apigw/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Set request header `Authorization` to public mainnet fleet API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus gateway port of the public mainnet service.

## <a name='wss.calibration.node.glif.io'></a>wss.calibration.node.glif.io

### <a name='ANYapigwlotusproxyPath-1'></a>ANY /apigw/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Set request header `Authorization` to public calibnet fleet API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus gateway port of the public calibnet service.

## <a name='monitoring.node.glif.io'></a>monitoring.node.glif.io

### <a name='ANYproxyPath'></a>ANY /*proxyPath

Plugins:

- Apply CORS policies.

Route request to production Grafana.

## <a name='calibration.node.glif.io'></a>calibration.node.glif.io

### <a name='ANYarchivelotusproxyPath'></a>ANY /archive/lotus/*proxyPath

Plugins:

- Apply CORS policies.
- Set request header `Content-Type` to `application/json`.
- Authorize the request against the auth app. Return 401 on failure.
- Set request header `Authorization` to Calibration Archive API token.
- Set request path to `/*proxyPath`.
- Set response header `Content-Type` to `application/json`.

Route request to lotus daemon port of the Calibration Archive service.

## <a name='auth.node.glif.io'></a>auth.node.glif.io

### <a name='ANYproxyPath-1'></a>ANY /*proxyPath

Plugins:

- Apply CORS policies.

Redirect request to https://api.node.glif.io/ with 301 status code.