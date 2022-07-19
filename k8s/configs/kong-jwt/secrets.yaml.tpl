apiVersion: v1
kind: Secret
metadata:
  name: goldskyio-read-user
  namespace: calibrationnet
type: Opaque
stringData:
  kongCredType: jwt
  key: goldskyio-read-user
  algorithm: RS256
  rsa_public_key: |-
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5DL6FwpZE9Gy+sF/cX0r
    VxehAek02UniSNLMeSpEBABmfa/WB6oT043R7z0ZkxVmfYtz+XvhndgdbO4d29n1
    wnKUltHga7NBnJiHQG6zCnhcjHuqsXi0leAMCTCnzIUb+v+Pr9VXzxExcf8KcfcX
    odklOW6HHhPC0t7Oso7IQ95gEz/bpA+ltWxJ4+ykFtnRsqLNXuADd+ap4Ydui3tW
    FxSQjBIEyz2dxIw8xbUZqHMK2DrT9USSF5sSVZvV5jlABqfZShUsVUQjN+C+EQCi
    R3wTazLdYTq+7ez7lbTCjS9IRzloXFNQXCidHwFKVcdAhDvP7NcSRJwcbZTOS7YW
    hQIDAQAB
    -----END PUBLIC KEY-----
