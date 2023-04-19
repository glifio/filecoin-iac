## Steps to switch traffic from  unavailable nodes to another node

For example switch traffic from space06 to api-read-master

1. Needs to change service in ingress object

make sure that your context is correct 

```` kubectl config use-context arn:aws:eks:ap-northeast-1:499623857295:cluster/filecoin-mainnet-apn1-glif-eks````

 - ````kubectl -n network get ingress````

 - ```kubectl -n network edit ingress kong-space06-lotus-1234-6mosn```

 - change service from *space06-lotus-service* to *api-read-master-lotus-service*

   ![Screenshot 2023-04-19 at 12.54.05.png](doc%2FScreenshot%202023-04-19%20at%2012.54.05.png)

2.  Needs to copy *request-transformer-header* from the konghq.com/plugins:annotations
    this plugin replaces the token and allows to use token for space06
![Screenshot 2023-04-19 at 12.54.23.png](doc%2FScreenshot%202023-04-19%20at%2012.54.23.png)

3. Add token to kong plugin

```` kubectl -n network edit kongplugin request-transformer-header-6mosn ````

![Screenshot 2023-04-19 at 13.10.39.png](doc%2FScreenshot%202023-04-19%20at%2013.10.39.png)

4. Where take a token for kong plugin 

- Go to AWS account  --> Secret Manager 
- Select secret *api-read-master* / or any node where traffic is switched
- copy jwt_token_kong_rw               // if you don't know how create jwt_token_kong_rw please check the file add-new-nodes [Create custom JWT token](#sreate-custom-jwt-token)
![Screenshot 2023-04-19 at 13.17.09.png](doc%2FScreenshot%202023-04-19%20at%2013.17.09.png)

5. make sure that your node is available
```
curl --request POST 'https://node.glif.io/space06/lotus/rpc/v0' --header 'Content-Type: application/json' --data '{"jsonrpc": "2.0,"method": "Filecoin.Version","id": 1,"params": []}' 
 ```
or postman 

![Screenshot 2023-04-19 at 13.40.17.png](doc%2FScreenshot%202023-04-19%20at%2013.40.17.png)