import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/screens/detail/detail_reminder.dart';

class CardCustomer extends StatefulWidget {
  final List<Reminder> reminders;
  final int index;

  const CardCustomer({super.key, required this.reminders, required this.index});

  @override
  State<CardCustomer> createState() => _CardCustomerState();
}

class _CardCustomerState extends State<CardCustomer> {
  bool iconCheck = false;

  @override
  Widget build(BuildContext context) {
    final reminderIndex = widget.reminders[widget.index];
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  print(
                    'fue precionado el boton de cheking, posicion: ${widget.index}',
                  );
                },
                icon: Icon(Icons.circle_outlined),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailReminder()),
                    ),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminderIndex.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.blueGrey[600],
                          ),
                          SizedBox(width: 8),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy HH:mm',
                            ).format(reminderIndex.reminderTime),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.repeat,
                            size: 18,
                            color: Colors.blueGrey[600],
                          ),
                          SizedBox(width: 8),
                          Text(
                            reminderIndex.frecuencia.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
