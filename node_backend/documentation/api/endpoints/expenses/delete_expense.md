# Delete Expense

## Endpoint
DELETE /expenses/:id


## Description
Deletes an existing expense for the authenticated user by its ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): ID of the expense to delete.

### Body
```json
{
  "expense_id": 1
}
```

- `expense_id` (required): ID of the expense to delete.

## Response
### Status Codes
**200 OK**
```json
{
  "message": "Expense deleted successfully."
}
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```

---

This delete_expense.md file now provides structured documentation for the DELETE /expenses/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization), URL parameter (id), and JSON body parameter (expense_id) for deleting an expense.
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response confirming the successful deletion of the expense.

