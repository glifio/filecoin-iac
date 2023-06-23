## Steps to add  new methods to Lotus


### General information

- [filecoin-project/lotus](https://github.com/filecoin-project/lotus)  general lotus's repo
- [protofire/lotus](https://github.com/protofire/lotus) fork for our team


## Algorithm

````mermaid
flowchart TD
    A((\nStart\n\n)) --> B[/Get the method name/]
    B --> C[Go to api/api_full.go\nand find the method there]
    C --> D{Is it\n read method ?}
    D --Yes -----> F[ \n Copy the method\n from api/api_full.go\n to api/api_gateway.go\n\n]
    D -----No  --------> E(((End)))
    F --> G{Add to rpc v0 ?}
    G --> H[ \nCopy the method\n from api/v0api/full.go\n to api/v0api/gateway.go\n\n]
    H --> I[ \nCopy the method\n from api/api_full.go\n to gateway/node.go\n\n]
    G --No --> I
    I --> J{Is it\n Filecoin method ?}
    J --> K[ \nGo to\n gateway/proxy_fill.go\n\n]
    J --No --> L{Is it eth method ?}
    L ---> M[ \nGo to\n gateway/proxy_eth.go\n\n]
    M ---> N[ \nCopy the method\n from gateway/node.go\n\n]
    K ---> N
    N ---> O[ \nAdd limit handler\n\n]
    O --> P{ \nHas TipSetKey\n arg ?\n\n}
    P ----> Q[ \nAdd check TipSetKey\n handler\n\n]
    Q --> E

````

1. Get the method name, for example: `ChainGetTipSet`
2. Go to [protofire/lotus](https://github.com/protofire/lotus) choose the `./api` directory\
   ##### Adding method to v1 (unstable) version:
 - Go to the file `api_full.go` find method and make a copy, it'll look like: ```ChainGetTipSet(context.Context, types.TipSetKey) (*types.TipSet, error) //perm:read```\
 We have to add methods have a read permissions only  by a smart-contract. 
 - Copy the method from `api_full.go` to the file `api_gateway.go` to  the section `type Gateway interface`.\
for example: ```ChainGetTipSet(ctx context.Context, tsk types.TipSetKey) (*types.TipSet, error)```
   #### Adding method to v0 (stable) version:
 - Go to the file `v0api/full.go` find method and make a copy.
 - Copy the method from `full.go` to the file `gateway.go` to  the section`type Gateway interface`.
3. Choose the `./gateway` directory\
 - Go to the file `node.go` copy the method from `api/api_full.go` to the section `type TargetAPI interface`.
   #### If it filecoin method:
 - Go to the file `proxy_fil.go`
 - Add the new method, smth like this schema:
```
func (gw *Node) ${COPIED_METHOD} {
	if err := gw.limit(ctx, chainRateLimitTokens); err != nil {
		return ${RETURN_TYPE}
	}
	return gw.target.${JUST METHOD NAME} (Method Argument Abbreviations)
}
```
more details about ${RETURN_TYPE} arguments.\
You could check it in the last argument of the copied method.\
Copied method: ```ChainGetTipSet(ctx context.Context, tsk types.TipSetKey) (*types.TipSet, error)```\
TipSetKey handler: ```(*types.TipSet, error)```

| Return type   | Example                                                | Return statement                      |
|---------------|--------------------------------------------------------|---------------------------------------|
| uint64        | -                                                      | `return 0, err`                       |
| Pointer       | `*types.Message`, `[]byte`, `<-chan []*api.HeadChange` | `return nil, err`                     |
| bool          | -                                                      | `return false, err`                   |
| map           | `map[string]cid.Cid`                                   | `return *new(map[string]cid.Cid), err` |
| Custom        | `abi.ChainEpoch`                                       | `return *new(abi.ChainEpoch), err`    |
| types.BigInt  | `types.BigInt`                                          |  `return types.BigInt{}, err`         |

 Please check that your new method matches the schema, by example:

````
func (gw *Node) ChainGetTipSet(ctx context.Context, tsk types.TipSetKey) (*types.TipSet, error) {
	if err := gw.limit(ctx, chainRateLimitTokens); err != nil {
		return nil, err
	}
	return gw.target.ChainGetTipSet(ctx, tsk)
}
````

   #### If it Eth method:

 - Go to the file `proxy_eth.go`
 - Add new method the same way as for the filecoin.

4. install dependencies on your local machine to compile code with new methods
  #### Dependencies
- ca-certificates
- build-essential 
- clang
- ocl-icd-opencl-dev
- ocl-icd-libopencl1
- jq
- libhwloc-dev

5. Run the command to compilition, use Makefile

````shell
make deps
````


