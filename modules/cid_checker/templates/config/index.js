'use strict';

exports.handler = (event, context, callback) => {
    console.log('LogS3DataEvents');
    console.log('Received event:', JSON.stringify("FILE UPDATED"));
    callback(null, 'FILE UPDATED');
};