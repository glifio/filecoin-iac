
## Update the static page

### General information

Source code: https://github.com/glifio/node
Language: ReactJS

For the better navigation through the repository, here’s a quick overview of the most edited files:
- components/Landing.tsx – the header of the main page.
- components/Documentation.tsx – the body of the main page.
- components/FilecoinRPC.tsx – the page lists available Filecoin methods.
- components/EthRPC.tsx – the page lists available Ethereum methods.

Let’s do that step by step based on the following example:

1. Should create a fork repo glifio/node general glif repo
2. For updates use folder `components`
3. For apply changes use command:
````shell
npm i
````
````shell
npm run export
````
After export command new files have put to `${HOME}/node/out`
4. You can check pre-review your new static page, with command:
````shell
npm run serve
````
5. Go to directory with updated files `${HOME}/node/out`
6. Data from this directory have to upload to the s3 bucket there hosts our static page:
 - find s3 bucket glif-static-website
```shell
 ls -la
```
```shell
aws s3 ls --profile filecoin
```
7. Run the command for upload new files:

```shell
aws s3 sync ./ s3://glif-static-website/ --profile filecoin
```