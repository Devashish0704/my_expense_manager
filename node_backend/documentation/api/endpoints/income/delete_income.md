
# Delete Income

## Endpoint

DELETE /income/:id


## Description
Deletes an existing income record for the authenticated user by its ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): ID of the income record to delete.

### Body
```json
{
  "income_id": 1
}
```

- `income_id` (required): ID of the income record to delete.

## Response
### Status Codes
**200 OK**
```json
{
  "id": 1,
  "categoryid": 1,
  "amount": 2000.00,
  "description": "Deleted income description",
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

This delete_income.md file now provides structured documentation for the DELETE /income/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the URL parameter (id) along with the JSON body parameter (income_id) for deleting an income record.
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response with details of the deleted income record.
.