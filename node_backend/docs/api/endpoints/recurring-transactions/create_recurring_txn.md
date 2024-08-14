
# Create Recurring Transaction

Create a new recurring transaction with the provided details.

## Endpoint

```
POST /api/recurring-txns
```

## Request Body

The request body must contain the following parameters:

- `id`: Integer - Unique identifier for the recurring transaction.
- `amount`: Numeric - Amount of the transaction.
- `start_date`: Date - Start date of the recurring transaction.
- `frequency`: String - Frequency of the transaction (`daily`, `weekly`, `monthly`, etc.).
- `category_id`: Integer - ID of the category associated with the transaction.
- `description`: String - Description of the recurring transaction.
- `remaining_payments`: Integer - Number of remaining payments.
- `max_payments`: Integer (nullable) - Maximum number of payments (optional, can be `null`).
- `type`: String - Type of the transaction (`income` or `expense`).

## Response

### Success Response

- **Code**: 201 Created
- **Content**: JSON object containing details of the created recurring transaction.

Example:

```json
{
    "id": 1,
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

- **Code**: 500 Internal Server Error
  - **Content**: `{ "error": "Internal server error" }`

## Additional Information

- If `max_payments` is provided as `null`, it indicates there is no limit to the number of payments.

## Example

### Request

```http
POST /api/recurring-txns
Content-Type: application/json

{
    "id": 1,
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

### Response

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "id": 1,
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
This documentation file outlines how to create a new recurring transaction, specifying the endpoint, request body parameters, successful response structure, error handling scenarios, and additional information about `max_payments`. Adjustments can be made based on your specific API implementation and error handling requirements.