
# Check Budget

## Description
Check the current status of a budget by calculating the total expenses within the specified date range for a particular category and user.

## Endpoint
POST /api/budget/check

## Request
### Headers
None

### Body
```json
{
  "user_id": 1,
  "category_id": 2,
  "amount": 5000,
  "start_date": "2024-01-01",
  "end_date": "2024-01-31"
}
```

## Response
### Status Codes
### 200
```json
{
  "budget": {
    "user_id": 1,
    "category_id": 2,
    "amount": 5000,
    "start_date": "2024-01-01",
    "end_date": "2024-01-31"
  },
  "totalExpenses": 4000,
  "status": "within"
}
```

### 500
```json
{
  "error": "Internal server error"
}
```

## Implementation
```javascript
const checkBudget = async (budget) => {
  const { user_id, category_id, amount, start_date, end_date } = budget;
  try {
    const result = await pool.query(
      'SELECT SUM(amount) AS total_expenses FROM expenses WHERE user_id = $1 AND category_id = $2 AND date BETWEEN $3 AND $4',
      [user_id, category_id, start_date, end_date]
    );

    const totalExpenses = result.rows[0].total_expenses || 0;

    console.log(Total Expenses for Budget ID ${budget.id}: ${totalExpenses});

    // Determine the status
    let status = 'within';
    if (totalExpenses > amount) {
      status = 'exceeded';
    } else if (totalExpenses / amount >= 0.8) { // 80% threshold
      status = 'approaching';
    }

    return {
      budget,
      totalExpenses,
      status
    };
  } catch (err) {
    console.error('Error checking budget:', err);
    throw err;
  }
};
```
---

This file includes:
- A brief description of the endpoint.
- Request details with headers and JSON body.
- Response status codes with corresponding JSON.
- Implementation of the checkBudget function.

