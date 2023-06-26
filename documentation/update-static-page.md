
## Update the static page

### General information

- Source code: `https://github.com/glifio/node`
- Language: ReactJS
- Hosted on: `s3://glif-static-website/`


For the better navigation through the repository, here’s a quick overview of the most edited files:

- components/Landing.tsx – the header of the main page.
- components/Documentation.tsx – the body of the main page.
- components/FilecoinRPC.tsx – the page lists available Filecoin methods.
- components/EthRPC.tsx – the page lists available Ethereum methods.


## The update process
Let’s go through the update process step by step based on the following example:

1. Fork the source code repository and open it in your file editor of choice.
2. Install the required NodeJS modules using the following command: 
```shell
npm i
```
3. Make the necessary changes to the source code.
4. Generate the resulting static files using the following command:
````shell
npm run export
````
5. (Optional) Preview the resulting static page using the following command:
````shell
npm run serve
````
6. Go to the directory with the generated static files: `cd out`
7. Sync the static files to the S3 bucket:
````shell
aws s3 sync ./ s3://glif-static-website/ --profile filecoin
````
