
# Delete Recurring Transaction

Delete an existing recurring transaction identified by its unique ID.

## Endpoint

```
DELETE /api/recurring-txns/:id
```

## Parameters

- `id`: Integer - Unique identifier of the recurring transaction to delete.

## Response

### Success Response

- **Code**: 200 OK
- **Content**: JSON object containing a success message and details of the deleted recurring transaction.

Example:

```json
{
    "message": "Recurring transaction deleted successfully",
    "deleted": {
        "id": 1,
        "user_id": 5,
        "amount": 100.0,
        "start_date": "2024-07-10",
        "frequency": "weekly",
        "category_id": 2,
        "description": "Weekly grocery expense",
        "remaining_payments": 0,
        "max_payments": 10,
        "type": "expense"
    }
}
```

### Error Responses

- **Code**: 404 Not Found
  - **Content**: `{ "error": "Recurring transaction not found" }`

- **Code**: 500 Internal Server Error
  - **Content**: `{ "error": "Internal server error" }`

## Example

### Request

```http
DELETE /api/recurring-txns/1
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
```
```json
{
    "message": "Recurring transaction deleted successfully",
    "deleted": {
        "id": 1,
        "user_id": 5,
        "amount": 100.0,
        "start_date": "2024-07-10",
        "frequency": "weekly",
        "category_id": 2,
        "description": "Weekly grocery expense",
        "remaining_payments": 0,
        "max_payments": 10,
        "type": "expense"
    }
}
```
---
This documentation file provides instructions on how to delete an existing recurring transaction, detailing the endpoint, URL parameter, successful response structure with deleted transaction details, and error handling scenarios. Adjust the examples and content as per your specific API implementation and requirements.