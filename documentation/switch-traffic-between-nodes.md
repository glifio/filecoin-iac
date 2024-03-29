## Steps to switch traffic from one node to another


## Summary
Let’s assume we want to switch traffic from node **A** to node **B**. To do that, we must do the following:
1. [Edit the ingress rule]() of node A so the traffic flows to the service of node B.
2. [Edit the plugins]() enabled for the node A ingress so they apply the JWT authorization token of the node B for the incoming requests. That’s needed so the node B will not throw 401 Unauthorized status code on your requests signed with the node A authorization token because of the token mismatch.
So, let’s do that step by step based on the following example.



## Inputs
All the operations will be performed on the resources of the node A, so you only need to know the following about node B:
- **bar-service** – that’s the service name of the node B.
- **bar-token** – that’s the read-write authorization token. You can find it in the AWS Secrets Manager.

So, let’s describe the resources of node A that we’ll be working with

### Ingress
The ingress will look something like the following. Take note of the following thing:
- **foo-ingress** – that’s the name of the ingress.
- **request-transformer-header-foo** – that’s the KongPlugin resource that’s responsible for authorization.
- **foo-service** – that’s the service that the ingress is pointing to.

<img src="png/ingress.png" width="700px" />

### KongPlugin

<img src="png/kongplugin.png" width="475px" />

## Switch the traffic
To actually switch the traffic, do the following steps:
1. **Change the service field** of the node A ingress so it **points to the bar-service**, like the following:

````shell
    kubectl -n network edit ingress foo-ingress
````

````yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    konghq.com/plugins: cors, request-transformer-header-foo
    konghq.com/protocols: https, http
  name: foo-ingress
  namespace: network
spec:
  ingressClassName: kong-external-lb
  rules:
  - host: node.glif.io
    http:
      paths:
      - backend:
          service:
            name: bar-service
            port:
              number: 1234
        path: /foo/lotus/(.*)
        pathType: Exact
````

2. Edit the **request-transformer-header-foo** KongPlugin so it adds and replaces the Authorization header of incoming requests to the **Bearer bar-token**, like the following:

````shell

    kubectl -n network edit kongplugin request-transformer-header-foo
````

````yaml
apiVersion: configuration.konghq.com/v1
config:
  add:
    headers:
    - 'Authorization: Bearer bar-token’
  replace:
    uri: /$(uri_captures[1])
    headers:
    - 'Authorization: Bearer bar-token’
kind: KongPlugin
metadata:
  name: request-transformer-header-foo
  namespace: network
plugin: request-transformer

````

3. And that’s it! If everything has been done correctly, the requests you send to node A will actually flow to node B and will be signed by the correct authorization token.

The requests example:

````shell
curl -X POST 'https://node.glif.io/${NODE A}/lotus/rpc/v0' -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "Filecoin.Version", "params": [], "id": 1}` -H "Authorization: Bearer bar-token"
````

![connect-ingress-postman](png/connect-ingress-postman.png)

