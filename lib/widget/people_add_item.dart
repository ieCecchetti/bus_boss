import 'package:flutter/material.dart';
import 'package:bus_resolver/models/person.dart';

class PersonAddItem extends StatelessWidget {
  final Person person;
  final bool isSelected;
  final Function togglePersonSelection;

  const PersonAddItem(
      {super.key,
      required this.person,
      required this.isSelected,
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
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Kolbe ID: ${person.code}'),
          Text('CF: ${person.fiscalCode}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: isSelected ? const Icon(Icons.check) : const Icon(Icons.add),
            onPressed: () {
              // Info button action
              togglePersonSelection(person);
            },
          ),
        ],
      ),
      onTap: () {
        // do nothing
      },
    );
  }
}
