# Create Expense

## Endpoint
plaintext
POST /expenses


## Description
Creates a new expense for the authenticated user.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Body
```json
{
  "category_id": 1,
  "amount": 100.00,
  "description": "Expense description",
  "date": "2024-06-28"
}
```

- `category_id` (required): ID of the expense category.
- `amount` (required): Amount of the expense.
- `description` (optional): Description of the expense.
- `date` (required): Date of the expense.

## Response
### Status Codes
**201 Created**
```json
{
  "id": 1,
  "category_id": 1,
  "amount": 100.00,
  "description": "Expense description",
  "date": "2024-06-28"
}
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```

---

This create_expense.md file now provides structured documentation for the POST /expenses endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the JSON body parameters (category_id, amount, description, date).
- *Response*: Describes the possible status codes (201 Created and 500 Internal Server Error) and provides an example JSON response with details of the created expense.

