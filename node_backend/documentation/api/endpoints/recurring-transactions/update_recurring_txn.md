
# Update Recurring Transaction

Update an existing recurring transaction with the provided details.

## Endpoint

```
PUT /api/recurring-txns/:id
```

## Parameters

- `id`: Integer - Unique identifier of the recurring transaction to update.

## Request Body

The request body must contain the following parameters:

- `amount`: Numeric - Updated amount of the transaction.
- `start_date`: Date - Updated start date of the recurring transaction.
- `frequency`: String - Updated frequency of the transaction (`daily`, `weekly`, `monthly`, etc.).
- `category_id`: Integer - Updated ID of the category associated with the transaction.
- `description`: String - Updated description of the recurring transaction.
- `remaining_payments`: Integer - Updated number of remaining payments.
- `max_payments`: Integer (nullable) - Updated maximum number of payments (optional, can be `null`).
- `type`: String - Updated type of the transaction (`income` or `expense`).

## Response

### Success Response

- **Code**: 200 OK
- **Content**: JSON object containing details of the updated recurring transaction.

Example:

```json
{
    "id": 1,
    "amount": 120.0,
    "start_date": "2024-07-15",
    "frequency": "monthly",
    "category_id": 3,
    "description": "Updated monthly rent payment",
    "remaining_payments": 8,
    "max_payments": null,
    "type": "expense"
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
PUT /api/recurring-txns/1
Content-Type: application/json
```
```json
{
    "amount": 120.0,
    "start_date": "2024-07-15",
    "frequency": "monthly",
    "category_id": 3,
    "description": "Updated monthly rent payment",
    "remaining_payments": 8,
    "max_payments": null,
    "type": "expense"
}
```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
```
```json
{
    "id": 1,
    "amount": 120.0,
    "start_date": "2024-07-15",
    "frequency": "monthly",
    "category_id": 3,
    "description": "Updated monthly rent payment",
    "remaining_payments": 8,
    "max_payments": null,
    "type": "expense"
}
```
---
This documentation file explains how to update an existing recurring transaction, specifying the endpoint, URL parameter, request body parameters, successful response structure, and error handling scenarios.