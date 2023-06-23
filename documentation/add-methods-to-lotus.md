## Steps to add  new methods to Lotus


### General information

- [filecoin-project/lotus](https://github.com/filecoin-project/lotus) - the official Lotus repository
- [protofire/lotus](https://github.com/protofire/lotus) - our fork of that repository


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

1. Let's assume you want to add the `Filecoin.ChainGetTipSet` method to Lotus Gateway.
2. Clone the [protofire/lotus](https://github.com/protofire/lotus) repository and go to the `api` directory.
   ##### Add the method to the v1 (unstable) version of Lotus Gateway API:
 - Open the `api_full.go` file, find the method there (will look like this: ```ChainGetTipSet(context.Context, types.TipSetKey) (*types.TipSet, error) //perm:read```) and copy it to the clipboard.\
 Make sure that this is a read method (marked as ```//perm:read```). 
 - Paste the method you've copied in the previous step to the `type Gateway interface` section of the`api_gateway.go` file.
   #### Add the method to the v0 (stable) version of Lotus Gateway API:
 - Open the `v0api/full.go` file, find the method there and copy it to the clipboard.
 - Paste the method you've copied in the previous step to the `type Gateway interface` section of the`gateway.go` file.
3. Open the `./gateway` directory.
 - Open the `node.go` file and copy the method from `api/api_full.go` to the `type TargetAPI interface` section.
   #### If it's a filecoin method:
 - Open the file `proxy_fil.go`
 - Add the method implementation that looks something like this:
```
func (gw *Node) ${METHOD_DEFINITION} {
	if err := gw.limit(ctx, chainRateLimitTokens); err != nil {
		return ${RETURN_VALUES}
	}
	return gw.target.${METHOD_NAME} (Method Argument Abbreviations)
}
```
The acceptable ${RETURN_VALUES} can vary depending on the returning type so check with the table below for better results.\

| Return type   | Example                                                | Return statement                      |
|---------------|--------------------------------------------------------|---------------------------------------|
| uint64        | -                                                      | `return 0, err`                       |
| Pointer       | `*types.Message`, `[]byte`, `<-chan []*api.HeadChange` | `return nil, err`                     |
| bool          | -                                                      | `return false, err`                   |
| map           | `map[string]cid.Cid`                                   | `return *new(map[string]cid.Cid), err` |
| Custom        | `abi.ChainEpoch`                                       | `return *new(abi.ChainEpoch), err`    |
| types.BigInt  | `types.BigInt`                                          |  `return types.BigInt{}, err`         |

In case of the ChainGetTipSet method the implementation will look like this:

````
func (gw *Node) ChainGetTipSet(ctx context.Context, tsk types.TipSetKey) (*types.TipSet, error) {
	if err := gw.limit(ctx, chainRateLimitTokens); err != nil {
		return nil, err
	}
	return gw.target.ChainGetTipSet(ctx, tsk)
}
````

   #### If it's an Eth method:

 - Open the `proxy_eth.go` file.
 - Add new method the same way as you add a Filecoin method.

4. Install the software dependencies so you can regenerate dependent files in the next steps.
```shell
sudo apt-get install -y ca-certificates build-essential clang ocl-icd-opencl-dev ocl-icd-libopencl1 jq libhwloc-dev
```

5. Install the FFI dependencies.

````shell
make deps
````

6. Regenerate the dependent files.
```shell
make gen
```

7. That's it! Push the changed source code to Git and recompile the Lotus Gateway.
