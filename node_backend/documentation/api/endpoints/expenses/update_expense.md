
# Update Expense

## Endpoint
plaintext
PUT /expenses/:id


## Description
Updates an existing expense for the authenticated user by its ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): ID of the expense to update.

### Body
```json
{
  "category_id": 1,
  "amount": 150.00,
  "description": "Updated expense description",
  "date": "2024-06-30"
}
```

- `category_id` (required): ID of the expense category.
- `amount` (required): Updated amount of the expense.
- `description` (optional): Updated description of the expense.
- `date` (required): Updated date of the expense.

## Response
### Status Codes
**200 OK**
```json
{
  "id": 1,
  "category_id": 1,
  "amount": 150.00,
  "description": "Updated expense description",
  "date": "2024-06-30"
}
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```

---

This update_expense.md file now provides structured documentation for the PUT /expenses/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization), URL parameter (id), and JSON body parameters (category_id, amount, description, date) for updating an expense.
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response with details of the updated expense.

