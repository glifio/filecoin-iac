var qs = require("querystring");
var http = require("https");
const crypt = require('crypto');
const AWS = require('aws-sdk');

function doRequest(apiKey) {
  return new Promise(function(resolve,reject) {
    var options = {
      "method": "POST",
      "hostname": "api.uptimerobot.com",
      "port": null,
      "path": "/v2/getMonitors",
      "headers": {
        "content-type": "application/x-www-form-urlencoded",
        "cache-control": "no-cache"
      }
    };

    var req = http.request(options, function (res) {
      var chunks = [];

      res.on("data", function (chunk) {
        chunks.push(chunk);
      });

      res.on("end", function () {
        var body = Buffer.concat(chunks);
        console.log(body.toString());
        return resolve(body.toString())
      });

      res.on("error", function (error) {
        return reject(error)
      });
    });

    req.write(qs.stringify({ api_key: `${apiKey}`, format: 'json', logs: '1' }));
    req.end();
  })
}

function getMD5HashFromFile(data) {
  // https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#putObject-property
  // The base64-encoded 128-bit MD5 digest of the data.
  // You must use this header as a message integrity check to verify that the request
  // body was not corrupted in transit. For more information, see RFC 1864.
  const hash = crypt
    .createHash('md5')
    .update(data)
    .digest('base64');
  return hash;
}

async function putObjectToS3(data, file, type, bucket, credentials = {}, fileType = 'text/html') {
  return new Promise((resolve, reject) => {
    const md5Hash = getMD5HashFromFile(data);
    // credentials: {
    //  region: config.aws.s3.region,
    //  accessKeyId: config.aws.s3.accessKey,
    //  secretAccessKey: config.aws.s3.secretKey
    // }
    const s3 = new AWS.S3(credentials);

    const params = {
      ContentType: fileType,
      ACL: type,
      Bucket: bucket,
      Key: file,
      ContentMD5: md5Hash,
      Body: data,
    };

    s3.putObject(params, (err) => {
      if (err) {
        return reject(err);
      }
      return resolve();
    });
  });
}

exports.handler = async function(event, context) {
  const apiKey = process.env[`API_KEY_${event.network.toUpperCase()}`]
  const response = await doRequest(apiKey)
  await putObjectToS3(
    response,
    `${event.network}.json`,
    'public-read',
    'cloudfront-cache-s3',
    {},
    'application/json'
  )
};
