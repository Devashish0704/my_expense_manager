
# Update Income

## Endpoint

PUT /income/:id


## Description
Updates an existing income record for the authenticated user by its ID.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Parameters
- `id` (URL parameter): ID of the income record to update.

### Body
```json
{
  "categoryid": 1,
  "amount": 2000.00,
  "description": "Updated income description",
  "date": "2024-06-28"
}
```

- `categoryid` (required): ID of the income category.
- `amount` (required): Updated amount of the income.
- `description` (optional): Updated description of the income.
- `date` (required): Updated date of the income.

## Response
### Status Codes
**200 OK**
```json
{
  "id": 1,
  "categoryid": 1,
  "amount": 2000.00,
  "description": "Updated income description",
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

This update_income.md file now provides structured documentation for the PUT /income/:id endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the URL parameter (id) along with the JSON body parameters (categoryid, amount, description, date) for updating an income record.
- *Response*: Describes the possible status codes (200 OK and 500 Internal Server Error) and provides an example JSON response with details of the updated income record.

