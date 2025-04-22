import 'package:bus_resolver/models/person.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/widget/empty_list_placeholder.dart';
import 'package:bus_resolver/widget/people_item.dart';

class PartecipantListScreen extends StatefulWidget {
  final List<Person> partecipantList;
  final List<Person> actionList;
  final Function(Person) togglePersonSelection;
  final Function(Person) deletePerson;

  const PartecipantListScreen({
    super.key,
    required this.partecipantList,
    required this.actionList,
    required this.togglePersonSelection,
    required this.deletePerson,
  });

  @override
  _PartecipantListScreenState createState() => _PartecipantListScreenState();
}

class _PartecipantListScreenState extends State<PartecipantListScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.partecipantList.isEmpty
        ? emptyListScreen(
            'No participants found!',
            'https://e7.pngegg.com/pngimages/334/716/png-clipart-know-your-meme-laughter-feeling-culture-meme-white-culture.png',
            'Add some participants?')
        : ListView.builder(
            itemCount: widget.partecipantList.length,
            itemBuilder: (context, index) {
              final person = widget.partecipantList[index];
              return PersonItem(
                person: person,
                isChecked: widget.actionList.contains(person),
                togglePersonSelection: (person) {
                  setState(() {
                    widget.togglePersonSelection(person);
                  });
                },
              );
            },
          );
  }
}
