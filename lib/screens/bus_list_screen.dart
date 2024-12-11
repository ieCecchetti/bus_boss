import 'package:bus_resolver/models/bus.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/widget/empty_list_placeholder.dart';
import 'package:bus_resolver/widget/bus_item.dart';
import 'package:bus_resolver/screens/add_bus_tabs.dart';
import 'package:intl/intl.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key, required this.busList});
  final List<Bus> busList;

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  late List<Bus> _busList;

  @override
  void initState() {
    super.initState();
    _busList = widget.busList;
  }

  void createBus(Bus bus) {
    setState(() {
      _busList.add(bus);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Bus>> groupedBusList = Map.fromEntries(
      _busList
          .fold<Map<String, List<Bus>>>({}, (map, bus) {
            String date =
                DateFormat('yyyy-MM-dd').format(bus.timeDepart).toString();
            map.putIfAbsent(date, () => []).add(bus);
            return map;
          })
          .entries
          .toList()
        ..sort((entry1, entry2) => entry2.key.compareTo(entry1.key)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus List'),
      ),
      body: (_busList.isEmpty)
          ? emptyListScreen(
              'Hey, I cant find any bus!',
              'https://e7.pngegg.com/pngimages/334/716/png-clipart-know-your-meme-laughter-feeling-culture-meme-white-culture.png',
              'Maybe you have to create one?')
          : printBusByDate(groupedBusList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => AddBusTabsScreen(storeBus: createBus),
          ),);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget printBusByDate(Map<String, List<Bus>> groupedBusList) {
  return ListView.builder(
    itemCount: groupedBusList.keys.length,
    itemBuilder: (context, groupIndex) {
      // Get the current date and list of buses
      final date = groupedBusList.keys.toList()[groupIndex];
      final busList = groupedBusList[date] ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          // Separator
          const Divider(
            thickness: 1.5,
            color: Colors.grey,
          ),
          // List of buses for the day
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling for nested list
            shrinkWrap: true, // Allow the list to wrap its height
            itemCount: busList.length,
            itemBuilder: (context, index) {
              final bus = busList[index];
              return Dismissible(
                key: Key(bus.id.toString()),
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
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              // Perform delete operation
                              busList.removeAt(index);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (_) {
                  // Perform additional delete logic if needed
                },
                child: BusItem(bus: bus),
              );
            },
          ),
        ],
      );
    },
  );
}
}
