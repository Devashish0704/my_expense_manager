
# Get Recurring Transaction by ID

Retrieve details of a recurring transaction based on the provided user ID.

## Endpoint

```
GET /api/recurring-txns/:user_id
```

## Parameters

- `user_id`: Integer - ID of the user whose recurring transaction details are to be retrieved.

## Response

### Success Response

- **Code**: 200 OK
- **Content**: JSON object containing details of the recurring transaction.

Example:

```json
{
    "id": 1,
    "user_id": 123,
    "amount": 100.0,
    "start_date": "2024-07-10",
    "frequency": "monthly",
    "category_id": 2,
    "description": "Monthly rent payment",
    "remaining_payments": 10,
    "max_payments": null,
    "type": "expense"
}
```

### Error Responses

- **Code**: 404 Not Found
  - **Content**: `{ "error": "Recurring transaction not found" }`

- **Code**: 500 Internal Server Error
  - **Content**: `{ "error": "Internal server error" }`

## Error Handling

If the recurring transaction is not found for the provided `user_id`, a `404 Not Found` error is returned. For any server-side errors during the retrieval process, a `500 Internal Server Error` response is sent with an appropriate error message.

## Example

### Request

```http
GET /api/recurring-txns/123
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
```
```json
{
    "id": 1,
    "user_id": 123,
    "amount": 100.0,
    "start_date": "2024-07-10",
    "frequency": "monthly",
    "category_id": 2,
    "description": "Monthly rent payment",
    "remaining_payments": 10,
    "max_payments": null,
    "type": "expense"
}
```
---
This documentation file outlines how to retrieve details of a recurring transaction by its user ID, specifying the endpoint, parameters, successful response structure, and error handling scenarios.