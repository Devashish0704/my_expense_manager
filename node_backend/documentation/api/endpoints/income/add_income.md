
# Add Income

## Endpoint

POST /income


## Description
Creates a new income record for the authenticated user.

## Request
### Headers
- Authorization: Bearer JWT-token-here

### Body
```json
{
  "categoryid": 1,
  "amount": 1500.00,
  "description": "New income description",
  "date": "2024-06-28"
}
```

- `categoryid` (required): ID of the income category.
- `amount` (required): Amount of the income.
- `description` (optional): Description of the income.
- `date` (required): Date of the income.

## Response
### Status Codes
**201 Created**
```json
{
  "id": 1,
  "categoryid": 1,
  "amount": 1500.00,
  "description": "New income description",
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

This add_income.md file now provides structured documentation for the POST /income endpoint:

- *Endpoint*: Specifies the HTTP method and endpoint path.
- *Description*: Briefly explains the purpose of the endpoint.
- *Request*: Details the headers required (Authorization) and the JSON body parameters (categoryid, amount, description, date) for creating a new income record.
- *Response*: Describes the possible status codes (201 Created and 500 Internal Server Error) and provides an example JSON response with details of the newly created income record.

