import jwt
import json
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
    key = token_urlsafe(64)
    privateKey = json.dumps({
        "Type": "jwt-hmac-secret",
        "PrivateKey": key
    })

    tokenFull = generate_token(get_full_payload(), key)

    tokenRw = generate_token(get_rw_payload(), key)

    secret = json.dumps({
        "private_key": privateKey,
        "jwt_token": tokenFull,
        "jwt_token_kong_rw": tokenRw
    })

    print(secret)

if __name__ == "__main__":
    main()