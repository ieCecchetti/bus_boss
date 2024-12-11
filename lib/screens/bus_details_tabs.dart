import 'package:bus_resolver/data/mocked_data.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/screens/trip_details_screen.dart';
import 'package:bus_resolver/screens/partecipants_list_screen.dart';
import 'package:bus_resolver/screens/update_partecipant_list_screen.dart';
import 'package:bus_resolver/models/person.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({super.key, required this.selectedBus});

  final Bus selectedBus;

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  List<Person> allRegisteredPeople = [];
  List<Person> checkedPersonList = [];

  void _addPersonToBus(Person person) {
    setState(() {
      if (!widget.selectedBus.listPerson.contains(person)) {
        widget.selectedBus.listPerson.add(person);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Person added to the bus: ${person.code}')),
        );
      }
    });
  }

  void _deletePersonFromBus(Person person) {
    setState(() {
      widget.selectedBus.listPerson.remove(person);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Person removed from the bus: ${person.code}')),
    );
  }

  void toggleCheckPerson(Person person) {
    setState(() {
      if (!checkedPersonList.contains(person)) {
        checkedPersonList.add(person);
      } else {
        checkedPersonList.remove(person);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    allRegisteredPeople = widget.selectedBus.listAllSubscribed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Add your call action here
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          busDetailsHeader(
              context, widget.selectedBus, checkedPersonList.length),
          activityTabBar(context, widget.selectedBus),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => UpdatePeopleListScreen(
                allPeopleList: allRegisteredPeople,
                subscribedPeople: widget.selectedBus.listPerson
                  ..sort((a, b) => a.isStaff ? -1 : 1),
                deleteSingle: _deletePersonFromBus,
                storeSingle: _addPersonToBus,
              ),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget busDetailsHeader(
      BuildContext context, Bus selectedBus, int verifiedPeopleCount) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Background color or gradient
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow effect
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            // First row: Bus details
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20, // Smaller size
                  child: Icon(
                    Icons.directions_bus,
                    color: Colors.blueAccent,
                    size: 20, // Smaller icon
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${selectedBus.listPerson.length}/${selectedBus.size} seats available',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Second row: Verified people
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '$verifiedPeopleCount/${widget.selectedBus.listPerson.length} verified',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget activityTabBar(BuildContext context, Bus selectedBus) {
    final availableHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: SizedBox(
          height: availableHeight,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "Details"),
                  Tab(text: "Partecipants"),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    TripDetailsScreen(bus: selectedBus),
                    PartecipantListScreen(
                        partecipantList: widget.selectedBus.listPerson
                          ..sort((a, b) => a.isStaff ? -1 : 1),
                        checkedPartecipantsList: checkedPersonList,
                        deletePerson: _deletePersonFromBus,
                        togglePersonChecked: toggleCheckPerson),
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
