import 'package:flutter/material.dart';
import 'package:bus_resolver/models/person.dart';
import 'package:bus_resolver/screens/person_details_screen.dart';

class PersonItem extends StatelessWidget {
  final Person person;
  final bool isChecked;
  final Function togglePersonSelection;

  const PersonItem(
      {super.key,
      required this.person,
      required this.isChecked,
      required this.togglePersonSelection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        '${person.name} ${person.surname}',
        style: TextStyle(
          fontWeight: person.isStaff ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(person.code),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: isChecked
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.circle_outlined),
            onPressed: () {
              togglePersonSelection(person);
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PersonDetailsScreen(person: person),
          ),
        );
      },
    );
  }
}
