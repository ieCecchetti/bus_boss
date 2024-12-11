import 'package:bus_resolver/models/person.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/widget/empty_list_placeholder.dart';
import 'package:bus_resolver/widget/people_item.dart';

class PartecipantListScreen extends StatefulWidget {
  const PartecipantListScreen(
      {super.key,
      required this.partecipantList,
      required this.actionList,
      required this.deletePerson,
      required this.togglePersonChecked});

  final List<Person> partecipantList;
  final List<Person> actionList;
  final Function deletePerson;
  final Function togglePersonChecked;

  @override
  _PartecipantListScreenState createState() => _PartecipantListScreenState();
}

class _PartecipantListScreenState extends State<PartecipantListScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.partecipantList.isEmpty)
        ? emptyListScreen(
            'Hey, I cant find any people registered on this bus!',
            'https://e7.pngegg.com/pngimages/334/716/png-clipart-know-your-meme-laughter-feeling-culture-meme-white-culture.png',
            'Maybe you have to add some?')
        : ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
            itemCount: widget.partecipantList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(widget.partecipantList[index].code.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you want to delete this bus?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (_) {
                  setState(() {
                    widget.deletePerson(widget.partecipantList[index]);
                  });
                },
                child: PersonItem(
                  person: widget.partecipantList[index],
                  isChecked: widget.actionList
                      .contains(widget.partecipantList[index]),
                  togglePersonSelection: widget.togglePersonChecked,
                ),
              );
            },
          );
  }
}
