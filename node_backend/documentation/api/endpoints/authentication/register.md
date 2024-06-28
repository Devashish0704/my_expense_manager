
# Register Endpoint

## Endpoint
plaintext
POST /api/register


## Description
Registers a new user with the provided name, email, and password.

## Request
### Headers
None

### Body
```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "password123"
}
```

## Response
### Status Codes
**201 Created**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john.doe@example.com"
}
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```


This Markdown file now includes the request format, response status codes with JSON payloads, and a concise description of the registration endpoint.