## Steps to update Static page  

'https://api.node.glif.io/'


### General information

- [glifio/node](https://github.com/glifio/node)  general glif repo
### 

1. Should create a `fork` repo
2. For updates use folder `components`
3. For apply changes
    - ````npm i ````
   - ```npm run export```
4. ````npm run serve````   click on the right button on `network`
5. cd /Users/maria/works/node/out
 - ``ls -la``
 - ``aws s3 ls --profile filecoin``
 - ``aws s3 sync ./ s3://glif-static-website/ --profile filecoin``