
# Get Budget

## Endpoint
GET /api/budget/:id

## Description
Retrieve budget information for a specific user by their ID.

## Request
### Headers
None

### Parameters
- `id` (integer): The ID of the user.

### Example Request

GET /api/budget/1


## Response
### Status Codes
#### 200 OK
```json
{
  "id": 1,
  "user_id": 1,
  "category_id": 2,
  "amount": 500,
  "start_date": "2024-01-01",
  "end_date": "2024-01-31"
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
  "category_id": 2,
  "amount": 500,
  "start_date": "2024-01-01",
  "end_date": "2024-01-31"
}
```

### Error
```json
{
  "error": "Internal server error"
}
```
---
This content includes the description of the endpoint, request details, response status codes, and example responses.