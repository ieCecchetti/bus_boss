import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/models/person.dart';
import 'package:bus_resolver/screens/person_details_screen.dart';
import 'package:intl/intl.dart';

class TripDetailsScreen extends StatelessWidget {
  final Bus bus;

  const TripDetailsScreen({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    List<Person> staffList = bus.listPerson.where((person) => person.isStaff).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://cavourese.it/media/03_servizi_turistici/SKCHPLUS2.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                    SimpleEntry('Data:',
                      DateFormat('yyyy-MM-dd').format(bus.timeDepart)),
                    SimpleEntry('Bus Name:', bus.number),
                    const SizedBox(height: 10),
                    SimpleEntry('Bus Name:', bus.driver),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                      const Text(
                        'Staff:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      ...List.generate(
                        staffList.length, 
                        (index) {
                        Person person = staffList[index]; 
                        String initials = "${person.name[0]}${person.surname[0]}".toUpperCase();
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonDetailsScreen(person: person),
                            ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                            initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                          ),
                        );
                        },
                      ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SimpleEntry('Partenza:', bus.from),
                    const SizedBox(height: 10),
                    SimpleEntry('Ritorno:', bus.to),
                    const SizedBox(height: 10),
                    SimpleEntry('Departure Time:', TimeOfDay.fromDateTime(bus.timeDepart).format(context)),
                    const SizedBox(height: 10),
                    SimpleEntry('Arrival Time:',
                        TimeOfDay.fromDateTime(bus.timeReturn).format(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SimpleEntry(title, value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            overflow: TextOverflow
                .ellipsis, // Optional, to show "..." if the value doesn't fit
            softWrap: true, // Allow wrapping of text
          ),
        ),
      ],
    );
  }

}
