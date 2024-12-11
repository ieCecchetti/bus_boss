import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:uuid/uuid.dart';

class AddBusScreen extends StatefulWidget {
  const AddBusScreen({super.key, required this.bus, required this.updateBus});

  final Bus bus;
  final Function(Bus) updateBus;

  @override
  _AddBusScreenState createState() => _AddBusScreenState();
}

class _AddBusScreenState extends State<AddBusScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  DateTime? _timeDepart;
  DateTime? _timeReturn;

  void _saveBus() {
    if (_formKey.currentState!.validate()) {
      // Here you would create the bus object
      final updatedBus = widget.bus.copyWith(
        id: const Uuid().v4(),
        name: _nameController.text,
        number: _numberController.text,
        size: int.parse(_sizeController.text),
        driver: _driverController.text,
        contact: _contactController.text,
        timeDepart: _timeDepart!,
        timeReturn: _timeReturn!,
        from: _fromController.text,
        to: _toController.text,
      );

      widget.updateBus(updatedBus);

      // Proceed with adding the bus (save to database, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bus created: ${updatedBus.name}')),
      );
      Navigator.pop(context, updatedBus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Bus Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a bus name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Bus Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a bus number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _sizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Bus Size'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the bus size';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _driverController,
              decoration: const InputDecoration(labelText: 'Driver Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the driver\'s name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: 80, // Fixed width for the prefix field
                  child: TextFormField(
                    initialValue: '+1', // Default country code
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Prefix',
                      border: OutlineInputBorder(),
                      isDense: true, // Makes the field more compact
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Prefix required';
                      }
                      if (!RegExp(r'^\+\d{1,4}$').hasMatch(value)) {
                        return 'Invalid prefix';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      isDense: true, // Makes the field more compact
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number required';
                      }
                      // if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                      //   return 'Invalid phone number';
                      // }
                      if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
                        return 'Invalid phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _fromController,
              decoration: const InputDecoration(labelText: 'Travel from'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter departure location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _toController,
              decoration: const InputDecoration(labelText: 'Travel to'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter destination location';
                }
                return null;
              },
            ),
            ListTile(
              title: const Text('Departure Time'),
              subtitle: _timeDepart != null
                  ? Text(
                      '${_timeDepart!.year}-${_timeDepart!.month.toString().padLeft(2, '0')}-${_timeDepart!.day.toString().padLeft(2, '0')} '
                      '${_timeDepart!.hour.toString().padLeft(2, '0')}:${_timeDepart!.minute.toString().padLeft(2, '0')}',
                    )
                  : null,
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _timeDepart = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
            ListTile(
              title: const Text('Return Time'),
              subtitle: _timeReturn != null
                  ? Text(
                      '${_timeReturn!.year}-${_timeReturn!.month.toString().padLeft(2, '0')}-${_timeReturn!.day.toString().padLeft(2, '0')} '
                      '${_timeReturn!.hour.toString().padLeft(2, '0')}:${_timeReturn!.minute.toString().padLeft(2, '0')}',
                    )
                  : null,
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _timeReturn = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
              labelText: 'Number of Participants: ${widget.bus.listPerson.length}',
              enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
