
# Delete Budget

## Endpoint
DELETE /api/budget/:id

## Description
Delete an existing budget entry.

## Request
### Headers
None

### Example Request

DELETE /api/budget/1


## Response
### Status Codes
#### 200 OK
```json
{
  "id": 1,
  "user_id": 1,
  "amount": 500,
  "month": "June",
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
  "amount": 500,
  "month": "June",
  "year": 2024
}
```

### Error
```json
{
  "error": "Internal server error"
}
```
---

This content provides the necessary details for the delete_budget endpoint, including the endpoint URL, description, request headers, example request, response status codes, and example responses.