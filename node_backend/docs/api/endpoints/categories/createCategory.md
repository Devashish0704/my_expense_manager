### Create Category

Creates a new category in the expense management system.

#### Endpoint

```
POST /categories
```

#### Request Body
```json
curl -X POST http://localhost:3000/categories -H "Content-Type: application/json" -d '
{
  "name": "Groceries",
  "description": "Expenses related to groceries",
  "type": "expense",
  "user_id": 123
}
```

| Field       | Type     | Description                              |
|-------------|----------|------------------------------------------|
| `name`      | String   | **Required**. Name of the category.       |
| `description` | String | Description of the category.              |
| `type`      | String   | **Required**. Type of the category (`income` or `expense`). |
| `user_id`   | Integer  | **Required**. User ID associated with the category. |

#### Response

- **201 Created** - Successful creation of the category. Returns the created category object.
  
  Example Response Body:
  ```json
  {
    "id": 1,
    "name": "Groceries",
    "description": "Expenses related to groceries",
    "type": "expense",
    "user_id": 123
  }
  ```

- **500 Internal Server Error** - Failed to create the category.

#### Example

**Request:**
```json
POST /categories
Content-Type: application/json

{
  "name": "Groceries",
  "description": "Expenses related to groceries",
  "type": "expense",
  "user_id": 123
}
```

**Response (201 Created):**
```json
{
  "id": 1,
  "name": "Groceries",
  "description": "Expenses related to groceries",
  "type": "expense",
  "user_id": 123
}
```

**Response (500 Internal Server Error):**
```json
{
  "error": "Failed to create category"
}
```
---
#### Notes

- Use `type` field to specify whether the category is an expense or income category.
- Ensure `user_id` corresponds to an existing user in the system.
  
This endpoint allows users to create new categories for organizing their expenses or income.