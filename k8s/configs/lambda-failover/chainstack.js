const https = require('https');

   function postRequest(body) {
     const options = {
       host: 'strictly.node.glif.io',
       path: '/rpc/v0',
       method: 'POST',
       followAllRedirects: true,
       port: 443, // 👈️ replace with 80 for HTTP requests
     };

     return new Promise((resolve, reject) => {
       const req = https.request(options, (res) => {
         resolve(JSON.stringify(res.statusCode));
       });

       req.on('error', (e) => {
         reject(e.message);
       });

       req.write(JSON.stringify(body));
       req.end();
     });
   }

   exports.handler = async event => {
       const result = await postRequest({
         "jsonrpc": "2.0",
         "method": "Filecoin.Version",
         "params": [],
         "id": 1
       })
       .then(result => console.log(JSON.stringify({ "statusCode": result })))
       .catch(error => console.log(JSON.stringify({  "statusCode": result })));
   };