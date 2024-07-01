# Add Budget

## Endpoint

POST /api/budget

## Description

Create a new budget entry for a specific user.

## Request

### Headers

None

### Body

```json
{
  "user_id": 16,
  "category_id": 2,
  "amount": 500,
  "start_date": "2024-07-01",
  "end_date": "2024-07-31"
}
```

### Example Request

POST /api/budget
Content-Type: application/json

```json
{
  "user_id": 16,
  "category_id": 2,
  "amount": 500,
  "start_date": "2024-07-01",
  "end_date": "2024-07-31"
}
```

## Response

### Status Codes

#### 201 Created

```json
{
  "id": 11,
  "user_id": 16,
  "category_id": 2,
  "amount": "500.00",
  "start_date": "2024-06-30T18:30:00.000Z",
  "end_date": "2024-07-30T18:30:00.000Z"
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
  "id": 11,
  "user_id": 16,
  "category_id": 2,
  "amount": "500.00",
  "start_date": "2024-06-30T18:30:00.000Z",
  "end_date": "2024-07-30T18:30:00.000Z"
}
```

### Error

```json
{
  "error": "Internal server error"
}
```

---

This content provides the necessary details for the add_budget endpoint, including the endpoint URL, description, request headers, body, example request, response status codes, and example responses.
