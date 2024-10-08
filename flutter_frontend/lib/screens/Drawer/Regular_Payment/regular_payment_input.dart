import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Regular_Payment/bloc/regular_payment_bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/expense_category_dropdown.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/income_category_dropdown.dart';
import 'package:intl/intl.dart';

class RegularPaymentInput extends StatefulWidget {
  const RegularPaymentInput({super.key});

  @override
  State<RegularPaymentInput> createState() => _RegularPaymentInputState();
}

TextEditingController paymentNameController = TextEditingController();
TextEditingController paymentStartDateController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController numberOfPaymentsController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController customizePaymentsController = TextEditingController();

final _formKeyRP = GlobalKey<FormState>();

String paymentFrequency = 'Monthly';
String numberOfPayments = 'Unlimited';
String type = 'expense';
String category = 'General';
int? selectedCategory = 1;

List<String> frequencies = [
  'Daily',
  'Weekly',
  'Monthly',
  'Every 3 Months',
  'Every 6 Months',
  'Yearly'
];
List<String> numberOfPaymentsOptions = ['Unlimited', 'Customize'];
List<String> types = ['expense', 'income'];
Map<int, String> categories = CategoryService.expenseCategories;

class _RegularPaymentInputState extends State<RegularPaymentInput> {
  void _handleCategoryChanged(int? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  void _clearControllers() {
    paymentNameController.clear();
    paymentStartDateController.clear();
    amountController.clear();
    numberOfPaymentsController.clear();
    descriptionController.clear();
    customizePaymentsController.clear();
  }

  void _submitRegularPay() async {
    if (_formKeyRP.currentState!.validate()) {
      String paymentName = paymentNameController.text;
      String paymentFreq = paymentFrequency;
      String paymentStartDate = paymentStartDateController.text.isEmpty
          ? DateTime.now().toString()
          : paymentStartDateController.text;
      String amount = amountController.text;
      String description = descriptionController.text;
      String categoryId = selectedCategory.toString();
      String numberOfPaymentsValue = numberOfPayments == 'Customize'
          ? customizePaymentsController.text
          : '0';
      String? maxPayment;
      String? remainingPayment;

      if (numberOfPayments == 'Unlimited') {
        maxPayment = null;
        remainingPayment = null;
      } else if (numberOfPayments == 'Customize') {
        maxPayment = numberOfPaymentsValue;
        remainingPayment = numberOfPaymentsValue;
      }

      Map<String, String> addRegularPaymentData = {
        'id': AuthService().userID.toString(),
        'payment_name': paymentName,
        'amount': amount,
        'start_date': paymentStartDate,
        'frequency': paymentFreq,
        'category_id': categoryId,
        'description': description,
        'type': type
      };

      if (maxPayment != null && remainingPayment != null) {
        addRegularPaymentData['max_payments'] = maxPayment;
        addRegularPaymentData['remaining_payments'] = remainingPayment;
      }

      BlocProvider.of<RegularPaymentBloc>(context).add(
          AddRegularPaymentEvent(regularPaymentData: addRegularPaymentData));

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _clearControllers();
    context.read<CategoryBloc>().add(LoadExpenseCategoriesEvent());
    context.read<PaymentsBloc>().add(SelectUnlimitedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyRP,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Add Payment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _submitRegularPay,
                ),
              ],
            ),
            TextFormField(
              controller: paymentNameController,
              decoration: const InputDecoration(
                labelText: 'Payment Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Payment Name';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: paymentFrequency,
              items: frequencies.map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  paymentFrequency = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Payment Frequency',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: paymentStartDateController,
              decoration: const InputDecoration(
                labelText: 'Payment Start Date',
                hintText: 'Select Date',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    paymentStartDateController.text = formattedDate;
                  });
                }
              },
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (Every Time)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: type,
              items: types.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  type = newValue!;
                  if (type == 'expense') {
                    context
                        .read<CategoryBloc>()
                        .add(LoadExpenseCategoriesEvent());
                  } else if (type == 'income') {
                    context
                        .read<CategoryBloc>()
                        .add(LoadIncomeCategoriesEvent());
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadedState) {
                  return state.isExpense
                      ? ExpenseCategoryDropDown(
                          expenseCategories: CategoryService.expenseCategories,
                          expenseCategoriesCanBeDeleted:
                              CategoryService.expenseCategoriesCanBeDeleted,
                          selectedCategory: selectedCategory,
                          onCategoryChanged: _handleCategoryChanged,
                        )
                      : IncomeCategoryDropdown(
                          incomeCategories: CategoryService.incomeCategories,
                          incomeCategoriesCanBeDeleted:
                              CategoryService.incomeCategoriesCanBeDeleted,
                          selectedCategory: selectedCategory,
                          onCategoryChanged: _handleCategoryChanged,
                        );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            DropdownButtonFormField<String>(
              value: numberOfPayments,
              items: numberOfPaymentsOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  numberOfPayments = newValue!;
                  if (numberOfPayments == 'Unlimited') {
                    context.read<PaymentsBloc>().add(SelectUnlimitedEvent());
                  } else if (numberOfPayments == 'Customize') {
                    context.read<PaymentsBloc>().add(SelectCustomizeEvent());
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Number of Payments',
                border: OutlineInputBorder(),
              ),
            ),
            BlocBuilder<PaymentsBloc, PaymentsState>(
              builder: (context, state) {
                if (state is PaymentsLoadedState && state.isCustomize) {
                  return TextFormField(
                    controller: customizePaymentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Customize Number of Payments',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
