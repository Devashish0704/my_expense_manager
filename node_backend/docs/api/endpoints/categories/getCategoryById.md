# Get Categories by User ID

This endpoint retrieves a list of categories for a specific user. It includes both common categories (visible to all users) and user-specific categories.

## Endpoint

**URL**: `/categories/:id`

**Method**: `GET`

**Description**: Fetches all common categories and user-specific categories for the given user ID.

## Request Parameters

- `id` (path parameter): The user ID for which categories are to be fetched.

## Response

- **Status Code**: `200 OK`
- **Content**:
  ```json
  {
    "incomeCategories": {
      "1": "Salary",
      "2": "Freelance"
    },
    "expenseCategories": {
      "3": "Food",
      "4": "Transport"
    }
  }
  ```

## Example Request

```bash
curl -X GET http://localhost:3000/categories/1
```

## Example Response

```json
{
  "incomeCategories": {
    "1": "Salary",
    "2": "Freelance"
  },
  "expenseCategories": {
    "3": "Food",
    "4": "Transport"
  }
}
```

## Notes

- **Common Categories**: These categories are predefined and visible to all users. They cannot be deleted but can be hidden by users.
- **User-Defined Categories**: These categories are created by individual users. Users can edit or delete these categories.

## Controller Code

```javascript
const getCategoryById = async (req, res) => {
  const { id } = req.params; // Assuming id is passed as a route parameter (user_id)
  
  try {
    // Execute the SQL query to fetch categories by user_id
    const { rows } = await pool.query(queries.getCategoryById, [id]);

    let incomeCategories = {};
    let expenseCategories = {};

    // Iterate through fetched categories and map them based on type
    rows.forEach(category => {
      if (category.type === 'income') {
        incomeCategories[category.id] = category.name;
      } else if (category.type === 'expense') {
        expenseCategories[category.id] = category.name;
      }
    });

    // Respond with the fetched categories
    res.status(200).json({ incomeCategories, expenseCategories });
  } catch (error) {
    console.error('Error fetching categories by user_id:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
};
```
---
This documentation includes the necessary information for the `Get Categories by User ID` endpoint, including request parameters, response structure, example request and response, and the controller code. It also explains the difference between common categories and user-defined categories.