import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/models/person.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/widget/empty_list_placeholder.dart';
import 'package:bus_resolver/widget/people_add_item.dart';
import 'package:bus_resolver/data/mocked_data.dart';

class ChooseImportedPartecipantsScreen extends StatefulWidget {
  const ChooseImportedPartecipantsScreen(
      {super.key, required this.bus, required this.storeSingle, required this.deleteSingle});

  final Bus bus;
  final Function(Person person) storeSingle;
  final Function(Person person) deleteSingle;

  @override
  State<ChooseImportedPartecipantsScreen> createState() =>
      _ChooseImportedPartecipantsScreenState();
}

class _ChooseImportedPartecipantsScreenState
    extends State<ChooseImportedPartecipantsScreen> {

  void _togglePersonSelection(Person person) {
    if (widget.bus.listPerson.contains(person)) {
      widget.deleteSingle(person);
    } else {
      widget.storeSingle(person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.bus.listAllSubscribed.isEmpty
        ? emptyListScreen(
            'No people found!',
            'https://e7.pngegg.com/pngimages/334/716/png-clipart-know-your-meme-laughter-feeling-culture-meme-white-culture.png',
            'Add one to the list?')
        : ListView.builder(
            itemCount: widget.bus.listAllSubscribed.length,
            itemBuilder: (context, index) {
              return PersonAddItem(
                person: widget.bus.listAllSubscribed[index],
                isSelected: widget.bus.listPerson.contains(widget.bus.listAllSubscribed[index]),
                togglePersonSelection: _togglePersonSelection,
              );
            },
          );
  }
}
