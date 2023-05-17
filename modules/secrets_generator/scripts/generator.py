import jwt
import json
import base64
from secrets import token_urlsafe

def generate_token(payload, key):
    return jwt.encode(payload, key)

def get_full_payload():
    return {
        "Allow": [
            "read",
            "write",
            "sign",
            "admin"
        ]
    }

def get_rw_payload():
    return {
        "Allow": [
            "read",
            "write"
        ]
    }

def main():
    keyDecoded = token_urlsafe(64)
    privateKey = json.dumps({
        "Type": "jwt-hmac-secret",
        "PrivateKey": base64.b64encode(keyDecoded.encode("ascii")).decode("ascii")
    })

    tokenFull = generate_token(get_full_payload(), keyDecoded)

    tokenRw = generate_token(get_rw_payload(), keyDecoded)

    secret = json.dumps({
        "key_decoded": keyDecoded,
        "private_key": privateKey,
        "jwt_token": tokenFull,
        "jwt_token_kong_rw": tokenRw
    })

    print(secret)

if __name__ == "__main__":
    main()
