import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';
import 'package:vivebien/screens/provider/reminder.dart';

class DetailReminder extends ConsumerStatefulWidget {
  final Reminder reminder;

  const DetailReminder({super.key, required this.reminder});

  @override
  _DetailReminderScreenState createState() => _DetailReminderScreenState();
}

class _DetailReminderScreenState extends ConsumerState<DetailReminder> {
  late final Id _idIsar;
  late final String _id;
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  late DateTime fechaSeleccionada;
  late Frecuencia _frecuenciaSeleccionada;
  late Estado _estadoSeleccionado;

  bool isEnableButtom = false;

  @override
  initState() {
    super.initState();
    _id = widget.reminder.id;
    _idIsar = widget.reminder.idIsar;
    _tituloController.text = widget.reminder.title;
    _descripcionController.text = widget.reminder.description;
    fechaSeleccionada = widget.reminder.reminderTime;
    _frecuenciaSeleccionada = widget.reminder.frecuencia;
    _estadoSeleccionado = widget.reminder.estado;

    _tituloController.addListener(detectChange);
    _descripcionController.addListener(detectChange);
  }

  void detectChange() {
    if (_tituloController.text != widget.reminder.title ||
        _descripcionController.text != widget.reminder.description) {
      setState(() {
        isEnableButtom = true;
      });
    } else {
      setState(() {
        isEnableButtom = false;
      });
    }
  }

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

    DateTime fechaCompleta = fechaSeleccionada;

    if (pickedTime != null) {
      fechaCompleta = DateTime(
        pickedDate!.year,
        pickedDate!.month,
        pickedDate!.day,
        pickedTime!.hour,
        pickedTime!.minute,
      );
    }

    if (fechaCompleta != null && fechaCompleta != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = fechaCompleta;
        isEnableButtom = true;
      });
    }
  }

  void _guardarRecordatorio() {
    final id = _id;
    final idIsar = widget.reminder.idIsar;
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

    print('Recordatorio Actualizado:');
    print('ID : $id');
    print('Isar Id: $idIsar');
    print('Título: $titulo');
    print('Descripción: $descripcion');
    print('Fecha: $fechaSeleccionada');
    print('Frecuencia: $frecuencia');
    print('Estado: $estado');

    final Reminder newReminder = Reminder(
      idIsar: idIsar,
      id: id,
      title: titulo,
      description: descripcion,
      estado: estado,
      frecuencia: frecuencia,
      reminderTime: fecha,
    );

    ref.read(askReminderProvider.notifier).editReminder(newReminder);

    _tituloController.clear();
    _descripcionController.clear();

    setState(() {
      fechaSeleccionada = DateTime.now();
      _frecuenciaSeleccionada = Frecuencia.Unico;
      _estadoSeleccionado = Estado.Pendiente;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
        SnackBar(content: Text('Recordatorio Actualizado con éxito.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Detalle del Recordatorio'),
        actions: [
          ButtomCustomerDelete(
            idIsar: widget.reminder.idIsar,
            id: widget.reminder.id,
          )
        ],
      ),
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
                        if (newValue != widget.reminder.frecuencia) {
                          isEnableButtom = true;
                        } else {
                          isEnableButtom = false;
                        }
                      });
                    },
                    items: Frecuencia.values.map((Frecuencia frecuencia) {
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
                        if (newValue != widget.reminder.estado) {
                          isEnableButtom = true;
                        } else {
                          isEnableButtom = false;
                        }
                      });
                    },
                    items: Estado.values.map((Estado estado) {
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
                onPressed: isEnableButtom ? _guardarRecordatorio : null,
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtomCustomerDelete extends ConsumerWidget {
  final String id;
  final int idIsar;
  const ButtomCustomerDelete(
      {super.key, required this.id, required this.idIsar});

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: IconButton(
        icon: Icon(Icons.delete, size: 32),
        onPressed: () {
          ref.read(askReminderProvider.notifier).deleteReminder(idIsar, id);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Borrado con éxito.')));
          Navigator.pop(context);
        },
      ),
    );
  }
}
