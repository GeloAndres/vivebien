import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';
import 'package:vivebien/infrastructure/entities/reminder_impl.dart';
import 'package:vivebien/screens/provider/reminder.dart';

class DetailReminder extends ConsumerStatefulWidget {
  const DetailReminder({super.key});

  @override
  _DetailReminderScreenState createState() => _DetailReminderScreenState();
}

class _DetailReminderScreenState extends ConsumerState<DetailReminder> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime fechaSeleccionada = DateTime.now();
  Frecuencia _frecuenciaSeleccionada = Frecuencia.Unico;
  Estado _estadoSeleccionado = Estado.Pendiente;

  Future<void> _seleccionarFechaHora(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    final DateTime fechaCompleta = await DateTime(
      pickedDate!.year,
      pickedDate!.month,
      pickedDate!.day,
      pickedTime!.hour,
      pickedTime!.minute,
    );

    if (fechaCompleta != null && fechaCompleta != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = fechaCompleta;
      });
    }
  }

  void _guardarRecordatorio() {
    final id = ref.watch(askReminderProvider).length + 1;
    final titulo = _tituloController.text;
    final descripcion = _descripcionController.text;
    final fecha = fechaSeleccionada;
    final frecuencia = _frecuenciaSeleccionada;
    final estado = _estadoSeleccionado;

    if (titulo.isEmpty || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    print('Recordatorio guardado:');
    print('ID : $id');
    print('Título: $titulo');
    print('Descripción: $descripcion');
    print('Fecha: $fechaSeleccionada');
    print('Frecuencia: $frecuencia');
    print('Estado: $estado');

    final Reminder newReminder = ReminderImpl(
      id: id,
      title: titulo,
      description: descripcion,
      estado: estado,
      frecuencia: frecuencia,
      reminderTime: fecha,
    );

    //Guardar el reminder en la lista statica
    ref.read(askReminderProvider.notifier).addReminder(newReminder);

    _tituloController.clear();
    _descripcionController.clear();

    setState(() {
      fechaSeleccionada = DateTime.now();
      _frecuenciaSeleccionada = Frecuencia.Unico;
      _estadoSeleccionado = Estado.Pendiente;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Recordatorio guardado con éxito.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Detalle del Recordatorio')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              //space Time
              SizedBox(
                height: 80,
                child: GestureDetector(
                  onTap: () => _seleccionarFechaHora(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.date_range, size: 30),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(fechaSeleccionada),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Selector de frecuencia
              Row(
                children: [
                  Text('Frecuencia'),
                  SizedBox(width: 40),
                  DropdownButton<Frecuencia>(
                    value: _frecuenciaSeleccionada,
                    onChanged: (Frecuencia? newValue) {
                      setState(() {
                        _frecuenciaSeleccionada = newValue!;
                      });
                    },
                    items:
                        Frecuencia.values.map((Frecuencia frecuencia) {
                          return DropdownMenuItem<Frecuencia>(
                            value: frecuencia,
                            child: Text(frecuencia.toString().split('.').last),
                          );
                        }).toList(),
                  ),
                ],
              ),

              SizedBox(height: 16),

              Row(
                children: [
                  Text('Estado'),
                  SizedBox(width: 70),
                  DropdownButton<Estado>(
                    value: _estadoSeleccionado,
                    onChanged: (Estado? newValue) {
                      setState(() {
                        _estadoSeleccionado = newValue!;
                      });
                    },
                    items:
                        Estado.values.map((Estado estado) {
                          return DropdownMenuItem<Estado>(
                            value: estado,
                            child: Text(estado.toString().split('.').last),
                          );
                        }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _guardarRecordatorio,
                child: Text('Guardar Recordatorio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
