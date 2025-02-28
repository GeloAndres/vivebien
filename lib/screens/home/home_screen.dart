import 'package:flutter/material.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/screens/create/create_reminder.dart';
import 'package:vivebien/widget/card/card_customer.dart';

import './../../testing/db_reminde.dart';

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

class BodyCustomer extends StatelessWidget {
  const BodyCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recordatorioListaTesting.length,
      itemBuilder: (context, int index) {
        return CardCustomer(reminders: recordatorioListaTesting, index: index);
      },
    );
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
