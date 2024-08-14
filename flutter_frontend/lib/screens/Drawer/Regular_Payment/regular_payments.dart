import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/Drawer/Regular_Payment/regular_payment_input.dart';
import 'package:flutter_frontend/screens/Drawer/Regular_Payment/bloc/regular_payment_bloc.dart';
import 'package:intl/intl.dart';

class RegularPaymentScreen extends StatefulWidget {
  const RegularPaymentScreen({super.key});

  @override
  State<RegularPaymentScreen> createState() => _RegularPaymentScreenState();
}

class _RegularPaymentScreenState extends State<RegularPaymentScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RegularPaymentBloc>(context)
        .add(FetchRegularPaymentsEvent());
  }

  void showAddPaymentBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const RegularPaymentInput()).whenComplete(() {
      context.read<RegularPaymentBloc>().add(FetchRegularPaymentsEvent());
    });
  }

  String formatDate(String dateStr, String formatPattern) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat(formatPattern).format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double addRegularButtonWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Regular Payments')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: BlocListener<RegularPaymentBloc, RegularPaymentState>(
              listener: (context, state) {
                if (state is RegularPaymentAddedState) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                    backgroundColor:
                        state.isSuccess ? Colors.green : Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: BlocBuilder<RegularPaymentBloc, RegularPaymentState>(
                builder: (context, state) {
                  if (state is RegularPaymentLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RegularPaymentLoadedState) {
                    final regularPayments = state.regularPaymentsOfUser ?? [];
                    return ListView.builder(
                      itemCount: regularPayments.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(regularPayments[index]['id'].toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: kPrimaryBgColor,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          onDismissed: (direction) {
                            BlocProvider.of<RegularPaymentBloc>(context)
                                .add(SlideDeleteEvent(
                              dataId: regularPayments[index]['id'] ,
                            ));
                          },
                          child: Card(
                            child: ListTile(
                              subtitle:
                                  Text(regularPayments[index]['payment_name']),
                              trailing: Text(
                                  regularPayments[index]['type'] == 'expense'
                                      ? "-${regularPayments[index]['amount']}"
                                      : "+${regularPayments[index]['amount']}"),
                              leading: Text(
                                "${regularPayments[index]['frequency']}     ",
                                style: const TextStyle(fontSize: 13),
                              ),
                              title: Text(formatDate(
                                  regularPayments[index]['start_date'],
                                  'EEE, MMM d, y')),
                              onLongPress: () {},
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is RegularPaymentErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(45, 71, 96, 137),
        child: Container(
          height: 60.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: showAddPaymentBottomSheet,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(addRegularButtonWidth,
                      50), // width: 80% of the screen width, height: 50
                  backgroundColor:
                      kPrimaryAccentColor, // Button background color
                  foregroundColor: kPrimaryTextColor, // Text color
                ),
                child: const Text('Add Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
