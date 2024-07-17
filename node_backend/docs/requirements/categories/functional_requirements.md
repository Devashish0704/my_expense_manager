
# Functional Requirements

## Create Category
- **Description**: Allow users to create a new category.
- **Endpoint**: `POST /api/categories`
- **Request Body**: `{ "name": string, "description": string, "type": "income" | "expense", "user_id": int }`
- **Response**: `201 Created`, `{ "id": int, "name": string, "description": string, "type": "income" | "expense", "user_id": int, "is_common": boolean }`

## Retrieve Categories
- **Description**: Allow users to retrieve all categories visible to them, including both common and user-specific categories.
- **Endpoint**: `GET /api/categories/:user_id`
- **Response**: `200 OK`, `{ "categories": [ { "id": int, "name": string, "description": string, "type": "income" | "expense", "user_id": int, "is_common": boolean } ] }`

## Update Category
- **Description**: Allow users to update an existing category.
- **Endpoint**: `PUT /api/categories/:id`
- **Request Body**: `{ "name": string, "description": string, "type": "income" | "expense" }`
- **Response**: `200 OK`, `{ "id": int, "name": string, "description": string, "type": "income" | "expense", "user_id": int, "is_common": boolean }`

## Delete Category
- **Description**: Allow users to delete a user-specific category.
- **Endpoint**: `DELETE /api/categories/:id`
- **Response**: `200 OK`, `{ "message": "Category deleted successfully" }`

## Manage Category Visibility
- **Description**: Allow users to manage the visibility of user-specific categories.
- **Endpoint**: `PUT /api/categories/:id/visibility`
- **Request Body**: `{ "is_visible": boolean }`
- **Response**: `200 OK`, `{ "id": int, "name": string, "description": string, "type": "income" | "expense", "user_id": int, "is_common": boolean, "is_visible": boolean }`

