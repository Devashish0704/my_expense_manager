# Acceptance Criteria

## Create Budget
- **Given**: A user is authenticated.
- **When**: They submit a valid budget creation request.
- **Then**:
  - A new budget is created in the system.
  - The API returns a `201 Created` response with the newly created budget details.

## Retrieve Budget
- **Given**: A user is authenticated.
- **When**: They request budget details with a valid budget ID.
- **Then**:
  - The API returns a `200 OK` response with the requested budget details.

## Update Budget
- **Given**: A user is authenticated and owns the budget.
- **When**: They submit a valid budget update request.
- **Then**:
  - The budget record in the database is updated.
  - The API returns a `200 OK` response with the updated budget details.

## Delete Budget
- **Given**: A user is authenticated and owns the budget.
- **When**: They request to delete a budget with a valid budget ID.
- **Then**:
  - The budget record is deleted from the database.
  - The API returns a `200 OK` response with the deleted budget details.

## Check Budget Status
- **Given**: A user is authenticated.
- **When**: They submit a valid request to check budget status.
- **Then**:
  - The API returns a `200 OK` response with the budget status (`within`, `approaching`, or `exceeded`).

## Schedule Budget Notifications
- **Given**: A user is authenticated.
- **When**: They schedule notifications for their budget.
- **Then**:
  - Notifications are successfully scheduled.
  - The API returns a `200 OK` response confirming successful scheduling.
