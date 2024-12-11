import 'package:flutter/material.dart';
import 'package:bus_resolver/models/person.dart';

class PersonDetailsScreen extends StatelessWidget {
  final Person person;

  const PersonDetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.name} ${person.surname}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Add your call action here
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Add your call action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    person.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${person.name} ${person.surname}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Fiscal Code: ${person.fiscalCode}',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Cellphone: ${person.cellphone}',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Text(
                            'Role:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10),
                          Chip(
                            label: Text(
                              person.isStaff ? 'Staff' : 'Participant',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                person.isStaff ? Colors.teal : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
