import base64

def lambda_handler(event, context):
    # Credenciais esperadas (substitua por valores seguros)
    expected_username = "admin"
    expected_password = "password123"

    print("event", event)

    # Obtém o header Authorization
    auth_header = event.get("headers", {}).get("Authorization", "")
    
    if not auth_header.startswith("Basic "):
        return {"statusCode": 401, "body": "Unauthorized"}
    
    # Decodifica as credenciais
    encoded_creds = auth_header.split("Basic ")[1]
    decoded_creds = base64.b64decode(encoded_creds).decode("utf-8")
    
    username, password = decoded_creds.split(":")

    # Valida as credenciais
    if username == expected_username and password == expected_password:
        return {
            "principalId": username,
            "policyDocument": {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Action": "execute-api:Invoke",
                        "Effect": "Allow",
                        "Resource": event["methodArn"]
                    }
                ]
            }
        }
    
    return {"statusCode": 401, "body": "Unauthorized"}
