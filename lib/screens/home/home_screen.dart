import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/screens/create/create_reminder.dart';
import 'package:vivebien/screens/provider/reminder.dart';
import 'package:vivebien/widget/card/card_customer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vivebien')),
      body: BodyCustomer(),
      floatingActionButton: CustomerFloatingButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class BodyCustomer extends ConsumerWidget {
  const BodyCustomer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reminderList = ref.watch(askReminderProvider);

    if (reminderList.isNotEmpty) {
      return ListView.builder(
        itemCount: reminderList.length,
        itemBuilder: (context, int index) {
          return CardCustomer(
            reminders: reminderList,
            index: index,
            ref: ref,
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment_turned_in_outlined,
                size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tienes recordatorios',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}

class CustomerFloatingButtom extends StatelessWidget {
  const CustomerFloatingButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, size: 45),
      onPressed: () {
        print('precionado el floatingButtom');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateReminder()),
        );
      },
    );
  }
}
