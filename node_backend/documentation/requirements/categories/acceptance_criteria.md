

# Acceptance Criteria

## Create Category
- **Given**: A user is authenticated.
- **When**: They submit a valid category creation request including `name`, `description`, `type`, and `user_id`.
- **Then**:
  - A new category is created in the system.
  - The API returns a `201 Created` response with the newly created category details.

## Retrieve Categories
- **Given**: A user is authenticated.
- **When**: They request to retrieve all categories associated with their `user_id`.
- **Then**:
  - The API returns a `200 OK` response with categorized data, separating income and expense categories.

## Update Category
- **Given**: A user is authenticated and owns the category.
- **When**: They submit a valid category update request, including `name`, `description`, and `type`.
- **Then**:
  - The category record in the database is updated with the new details.
  - The API returns a `200 OK` response with the updated category details.

## Delete Category
- **Given**: A user is authenticated and owns the category.
- **When**: They request to delete a category with a valid `category_id`.
- **Then**:
  - The category record is deleted from the database.
  - The API returns a `200 OK` response confirming the category deletion.

## Manage Common Categories
- **Given**: A user is authenticated.
- **When**: They manage common categories (categories that cannot be deleted but can be hidden).
- **Then**:
  - Changes to common categories are applied universally across all users.
  - The API manages visibility settings according to user preferences.

## Hide/Show Categories
- **Given**: A user is authenticated.
- **When**: They toggle the visibility of categories based on their preferences.
- **Then**:
  - Visibility settings for categories are updated accordingly.
  - The API returns a `200 OK` response confirming the visibility update.

