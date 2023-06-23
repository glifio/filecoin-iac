## Steps to update Static page  

'https://api.node.glif.io/'


### General information

- [glifio/node](https://github.com/glifio/node)  general glif repo
### 

1. Should create a `fork` repo
2. For updates use folder `components`
3. For apply changes use command:\
    - ````npm i ````
   - ```npm run export```\
   After export command new files have put to `${HOME}/node/out`
4. You can check pre-review your new static page, with command:\
-  ````npm run serve````
- click on the right button on `network`
5. Go to directory with updated files `${HOME}/node/out`\
   Data from this directory have to upload to the s3 bucket there hosts our static page:

 - ``ls -la``
 - ``aws s3 ls --profile filecoin``
 - find s3 bucket `glif-static-website`

 - Run the command for upload new files:\
 ``aws s3 sync ./ s3://glif-static-website/ --profile filecoin``