
# Get Expenses by ID

## Endpoint
plaintext
GET /expenses/:id


## Description
Retrieves expenses associated with a specific user ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): User ID whose expenses are to be retrieved.

### Body
None

## Response
### Status Codes
**200 OK**
```json
[
  {
    "id": 1,
    "description": "Expense description",
    "amount": 100.00,
    "date": "2024-06-28"
  },
  {
    "id": 2,
    "description": "Another expense",
    "amount": 50.00,
    "date": "2024-06-28"
  }
]
```

**500 Internal Server Error**
```json
{
  "error": "Internal server error"
}
```

---

This get_expenses.md file now provides structured documentation for the GET /expenses/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the URL parameter (id).
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response with details of expenses retrieved for the specified user ID.

