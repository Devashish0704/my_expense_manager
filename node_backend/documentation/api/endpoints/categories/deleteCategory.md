
### Delete Category

Deletes a category from the expense management system.

#### Endpoint

```
DELETE /categories/:id
```

- `:id` - Category ID to be deleted.

#### Response

- **200 OK** - Category deleted successfully.
  
  Example Response Body:
  ```json
  {
    "message": "Category deleted successfully"
  }
  ```

- **404 Not Found** - Category not found or cannot be deleted.

  Example Response Body:
  ```json
  {
    "error": "Category not found or cannot be deleted"
  }
  ```

- **500 Internal Server Error** - Failed to delete the category.

#### Example

**Request:**
```
DELETE /categories/1
```

**Response (200 OK):**
```json
{
  "message": "Category deleted successfully"
}
```

**Response (404 Not Found):**
```json
{
  "error": "Category not found or cannot be deleted"
}
```

**Response (500 Internal Server Error):**
```json
{
  "error": "Failed to delete category"
}
```

#### Notes

- Users can only delete user-defined categories, not common categories.
- Ensure the `id` corresponds to an existing user-defined category in the system.

This endpoint allows users to delete categories that they have created in the system, helping them manage their expense or income categories effectively.