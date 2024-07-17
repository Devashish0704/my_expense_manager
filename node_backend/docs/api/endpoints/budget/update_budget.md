
# Update Budget

## Endpoint
PUT /api/budget/:id

## Description
Update an existing budget entry.

## Request
### Headers
None

### Body
```json
{
  "user_id": 1,
  "amount": 600,
  "month": "July",
  "year": 2024
}
```

### Example Request

PUT /api/budget/1
Content-Type: application/json

```json
{
  "user_id": 1,
  "amount": 600,
  "month": "July",
  "year": 2024
}
```

## Response
### Status Codes
#### 200 OK
```json
{
  "id": 1,
  "user_id": 1,
  "amount": 600,
  "month": "July",
  "year": 2024
}
```

#### 500 Internal Server Error
```json
{
  "error": "Internal server error"
}
```

## Example Response
### Success
```json
{
  "id": 1,
  "user_id": 1,
  "amount": 600,
  "month": "July",
  "year": 2024
}
```

### Error
```json
{
  "error": "Internal server error"
}
```

This content provides the necessary details for the update_budget endpoint, including the endpoint URL, description, request headers, body, example request, response status codes, and example responses.