# Use Cases

This section describes the use cases for managing recurring transactions in the Expense Manager API.

## Use Case 1: Create Recurring Transaction

- **Actor**: User
- **Description**: User creates a new recurring transaction.
- **Preconditions**: User is authenticated and provides valid transaction details.
- **Postconditions**: A new recurring transaction is added to the user's account.

## Use Case 2: Retrieve Recurring Transaction

- **Actor**: User
- **Description**: User retrieves details of a specific recurring transaction.
- **Preconditions**: User is authenticated and provides a valid transaction ID.
- **Postconditions**: Transaction details are displayed to the user.

## Use Case 3: Update Recurring Transaction

- **Actor**: User
- **Description**: User updates details of an existing recurring transaction.
- **Preconditions**: User is authenticated, owns the transaction, and provides valid updated details.
- **Postconditions**: The recurring transaction details are updated in the database.

## Use Case 4: Delete Recurring Transaction

- **Actor**: User
- **Description**: User deletes an existing recurring transaction.
- **Preconditions**: User is authenticated, owns the transaction being deleted.
- **Postconditions**: The recurring transaction is removed from the user's account.

## Use Case 5: List Recurring Transactions

- **Actor**: User
- **Description**: User views a list of all recurring transactions associated with their account.
- **Preconditions**: User is authenticated and requests the list of transactions.
- **Postconditions**: A list of recurring transactions is displayed to the user.

## Use Case 6: Schedule Recurring Transaction Notifications

- **Actor**: User
- **Description**: User schedules notifications for upcoming recurring transactions.
- **Preconditions**: User is authenticated and specifies notification preferences.
- **Postconditions**: Notifications for recurring transactions are scheduled as per user-defined settings.
