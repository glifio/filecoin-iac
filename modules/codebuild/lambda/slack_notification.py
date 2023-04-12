import json
import logging
import os

from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError

def handler(event, context):
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    
    logger.info("Event: " + json.dumps(event))
    
    sns_message = json.loads(event['Records'][0]['Sns']['Message'])
    logger.info("Message: " + json.dumps(sns_message))

    message = '''\
    CodeBuild state has changed!
    
    Project Name: {projectName}
    Initiator: {initiator}
    State: {state}\
    '''.format(
        projectName = sns_message['detail']['project-name'],
        state = sns_message['detail']['build-status'],
        initiator = sns_message['detail']['additional-information']['initiator']
    )
    
    WEBHOOK_URL = os.environ['WEBHOOK_URL']
    CHANNEL_NAME = os.environ['CHANNEL_NAME']
    
    payload = {
        "channel": CHANNEL_NAME,
        "text": message
    }
    
    req = Request(WEBHOOK_URL, json.dumps(payload).encode('utf-8'))
    try:
        res = urlopen(req)
        res.read()
        logger.info("Message posted to %s", CHANNEL_NAME)
    except HTTPError as e:
        logger.error("Request failed: %d %s", e.code, e.reason)
    except URLError as e:
        logger.error("Server connection failed: %s", e.reason)