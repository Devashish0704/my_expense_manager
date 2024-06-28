
# Get Income by ID

## Endpoint
plaintext
GET /income/:id


## Description
Retrieves income records associated with a specific user ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): User ID whose income records are to be retrieved.

### Body
None

## Response
### Status Codes
**200 OK**
```json
[
  {
    "id": 1,
    "description": "Income description",
    "amount": 1000.00,
    "date": "2024-06-28"
  },
  {
    "id": 2,
    "description": "Another income",
    "amount": 1500.00,
    "date": "2024-06-28"
  }
]
```

**500 Internal Server Error**
```json
{
  "error": "Internal Server Error"
}
```

---

This get_income.md file now provides structured documentation for the GET /income/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the URL parameter (id) for retrieving income records.
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response with details of the retrieved income records.
