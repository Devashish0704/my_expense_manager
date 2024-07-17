
### Update Category

Updates an existing category in the expense management system.

#### Endpoint

```
PUT /categories/:id
```

- `:id` - Category ID to be updated.

#### Request Body

The request body should contain the updated information for the category.

- `name` (required): New name of the category.
- `description`: New description of the category.
- `type` (required): New type of the category (`income` or `expense`).

#### Response

- **200 OK** - Category updated successfully.
  
  Example Response Body:
  ```json
  {
    "id": 1,
    "name": "Updated Category Name",
    "description": "Updated category description.",
    "type": "expense",
    "user_id": 123,
    "is_common": false
  }
  ```

- **400 Bad Request** - Invalid request body format.
  
  Example Response Body:
  ```json
  {
    "error": "Invalid request body format"
  }
  ```

- **404 Not Found** - Category not found or cannot be updated.
  
  Example Response Body:
  ```json
  {
    "error": "Category not found or cannot be updated"
  }
  ```

- **500 Internal Server Error** - Failed to update the category.
  
  Example Response Body:
  ```json
  {
    "error": "Failed to update category"
  }
  ```

#### Example

**Request:**
```
PUT /categories/1
Content-Type: application/json

{
  "name": "Updated Category Name",
  "description": "Updated category description.",
  "type": "expense"
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "name": "Updated Category Name",
  "description": "Updated category description.",
  "type": "expense",
  "user_id": 123,
  "is_common": false
}
```

**Response (400 Bad Request):**
```json
{
  "error": "Invalid request body format"
}
```

**Response (404 Not Found):**
```json
{
  "error": "Category not found or cannot be updated"
}
```

**Response (500 Internal Server Error):**
```json
{
  "error": "Failed to update category"
}
```

#### Notes

- Users can only update user-defined categories, not common categories.
- Ensure the `id` corresponds to an existing user-defined category in the system.
- The request body must contain valid JSON with at least the `name` and `type` fields specified for successful updates.

This endpoint allows users to modify the details of their existing categories to better manage their expense or income classification.