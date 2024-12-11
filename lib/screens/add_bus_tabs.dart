import 'package:bus_resolver/screens/add_bus_screen.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/models/person.dart';
import 'package:bus_resolver/screens/import_partecipant_screen.dart';
import 'package:bus_resolver/screens/choose_imported_partecipants.dart';

class AddBusTabsScreen extends StatefulWidget {
  final Function(Bus) storeBus;

  const AddBusTabsScreen({super.key, required this.storeBus});

  @override
  State<AddBusTabsScreen> createState() => _AddBusTabsScreenState();
}

class _AddBusTabsScreenState extends State<AddBusTabsScreen> {
  List<Person> checkedPersonList = [];
  Bus bus = Bus(
      contact: '',
      driver: '',
      from: '',
      id: '',
      listAllSubscribed: [],
      listPerson: [],
      name: '',
      number: '',
      size: 0,
      timeDepart: DateTime.now(),
      timeReturn: DateTime.now(),
      to: '');

  void _addPersonToBus(Person person) {
    setState(() {
      if (!bus.listPerson.contains(person)) {
        bus.listPerson.add(person);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Person added to the bus: ${person.code}')),
        );
      }
    });
  }

  void _deletePersonFromBus(Person person) {
    setState(() {
      bus.listPerson.remove(person);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Person removed from the bus: ${person.code}')),
    );
  }

  void updateListOfPartecipants(List<Person> value) {
    setState(() {
      bus = bus.copyWith(
        listAllSubscribed: value,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new bus'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          activityTabBar(context, bus),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        onPressed: () {
          widget.storeBus(bus);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget activityTabBar(BuildContext context, Bus bus) {
    final availableHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 3,
        child: SizedBox(
          height: availableHeight,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "Import File"),
                  Tab(text: "Create Trip"),
                  Tab(text: "Add partecipants"),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    ImportPartecipantsList(
                      bus: bus,
                      updateListOfPartecipants: updateListOfPartecipants
                    ),
                    AddBusScreen(
                      bus: bus,
                      updateBus: widget.storeBus,
                    ),
                    ChooseImportedPartecipantsScreen(
                      bus: bus,
                      storeSingle: _addPersonToBus,
                      deleteSingle: _deletePersonFromBus,
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
