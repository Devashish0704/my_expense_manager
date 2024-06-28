
# Login

## Endpoint
plaintext
POST /api/login


## Description
Logs in a user and returns a JWT token.

## Request
### Headers
None

### Body
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

## Response
### Status Codes
**200 OK**
```json
{
  "token": "jwt-token-here",
  "id": 1
}
```

**400 Bad Request**
```json
{
  "error": "Password incorrect"
}
```

**404 Not Found**
```json
{
  "error": "User not found"
}
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```

---

This Markdown file now includes the complete structure for the login endpoint documentation:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers (none in this case) and JSON body required for the request.
- *Response*: Describes the possible status codes (200 OK, 400 Bad Request, 404 Not Found, 500 Internal Server Error) and their corresponding JSON payloads.
