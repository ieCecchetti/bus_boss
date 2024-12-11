import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/models/person.dart';
import 'package:bus_resolver/screens/choose_imported_partecipants.dart';
import 'package:bus_resolver/functions/google_doc_processor.dart';

class ImportPartecipantsList extends StatefulWidget {
  const ImportPartecipantsList(
      {super.key, required this.bus, required this.updateListOfPartecipants});

  final Bus bus;
  final Function updateListOfPartecipants;
  @override
  State<ImportPartecipantsList> createState() => _ImportPartecipantsListState();
}

class _ImportPartecipantsListState extends State<ImportPartecipantsList> {
  @override
  Widget build(BuildContext context) {
    return widget.bus.listAllSubscribed.isEmpty
        ? Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final TextEditingController urlController =
                        TextEditingController();
                    return AlertDialog(
                      title: const Text('Add SheetId'),
                      content: TextField(
                        controller: urlController,
                        decoration:
                            const InputDecoration(hintText: "Enter SheetId"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Add'),
                          onPressed: () {
                            String sheetId = urlController.text;
                            // Handle the URL addition logic here
                            fetchAndParseSheet(sheetId).then((value) {
                              widget.updateListOfPartecipants(value);
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $error')),
                              );
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.upload_file,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          const Text('List of partecipants'),
          Text(
              'Number of partecipants: ${widget.bus.listAllSubscribed.length}'),
              ],
            ),
          );
        }
}
