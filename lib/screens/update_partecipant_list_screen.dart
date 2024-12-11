import 'package:bus_resolver/models/person.dart';
import 'package:flutter/material.dart';
import 'package:bus_resolver/widget/empty_list_placeholder.dart';
import 'package:bus_resolver/widget/people_add_item.dart';
import 'package:bus_resolver/data/mocked_data.dart';

class UpdatePeopleListScreen extends StatefulWidget {
  const UpdatePeopleListScreen(
      {super.key,
      required this.allPeopleList,
      required this.subscribedPeople,
      required this.storeSingle,
      required this.deleteSingle});

  final List<Person> allPeopleList;
  final List<Person> subscribedPeople;
  final Function(Person person) storeSingle;
  final Function(Person person) deleteSingle;

  @override
  State<UpdatePeopleListScreen> createState() => _UpdatePeopleListScreenState();
}

class _UpdatePeopleListScreenState extends State<UpdatePeopleListScreen> {
  List<Person> _allPeopleList = [];
  List<Person> _subscribedPeople = [];

  void _initPeopleLists() {
    setState(() {
      _allPeopleList = mockPerson..sort((a, b) => a.isStaff ? -1 : 1);
      _subscribedPeople = widget.subscribedPeople;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPeopleLists();
  }

  void _togglePersonSelection(Person person) {
    setState(() {
      if (_subscribedPeople.contains(person)) {
        _subscribedPeople.remove(person);
        widget.deleteSingle(person);
      } else {
        _subscribedPeople.add(person);
        widget.storeSingle(person);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Partecipant'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _allPeopleList.isEmpty
            ? emptyListScreen(
                'No people can be registered for the bus!',
                'https://e7.pngegg.com/pngimages/334/716/png-clipart-know-your-meme-laughter-feeling-culture-meme-white-culture.png',
                'Add one to the list?')
            : ListView.builder(
                itemCount: _allPeopleList.length,
                itemBuilder: (context, index) {
                  return PersonAddItem(
                    person: _allPeopleList[index],
                    isSelected:
                        _subscribedPeople.contains(_allPeopleList[index]),
                    togglePersonSelection: _togglePersonSelection,
                  );
                },
              ));
  }
}
