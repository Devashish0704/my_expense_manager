# Functional Requirements

## Create Budget

- **Description**: Allow users to create a new budget.
- **Endpoint**: `POST /api/budget`
- **Request Body**:

```json
{ "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }
```

- **Response**: `201 Created`,

```json
{
    "id": int,
     "user_id": int,
    "amount": double,
    "category_id": int,
    "start_date": "yyyy-mm-dd",
    "end_date": "yyyy-mm-dd"
}
```

## Retrieve Budget

- **Description**: Allow users to retrieve budget details.
- **Endpoint**: `GET /api/budget/:id`
- **Response**: `200 OK`, `{ "id": int, "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`

## Update Budget

- **Description**: Allow users to update an existing budget.
- **Endpoint**: `PUT /api/budget/:id`
- **Request Body**: `{ "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`
- **Response**: `200 OK`, `{ "id": int, "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`

## Delete Budget

- **Description**: Allow users to delete a budget.
- **Endpoint**: `DELETE /api/budget/:id`
- **Response**: `200 OK`, `{ "id": int, "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`

## Check Budget

- **Description**: Allow users to check the status of their budget.
- **Endpoint**: `POST /api/budget/check`
- **Request Body**: `{ "user_id": int, "category_id": int, "amount": double, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`
- **Response**: `200 OK`, `{ "budget": { "id": int, "user_id": int, "amount": double, "category_id": int, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }, "totalExpenses": double, "status": "within" | "approaching" | "exceeded" }`

## Schedule Budget Notifications

- **Description**: Allow users to schedule notifications for their budgets.
- **Endpoint**: `POST /api/budget/schedule`
- **Request Body**: `{ "user_id": int, "category_id": int, "amount": double, "start_date": "yyyy-mm-dd", "end_date": "yyyy-mm-dd" }`
- **Response**: `200 OK`, `{ "message": "Notifications scheduled successfully" }`
