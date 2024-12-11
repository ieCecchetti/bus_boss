import 'package:bus_resolver/models/person.dart';

class Bus {
  final String id;
  final String name;
  final String number;
  final int size;
  final String driver;
  final String contact;
  final List<Person> listAllSubscribed;
  final List<Person> listPerson;
  final DateTime timeDepart;
  final DateTime timeReturn;
  final String from;
  final String to;

  Bus({
    required this.id,
    required this.name,
    required this.number,
    required this.size,
    required this.driver,
    required this.contact,
    required this.listAllSubscribed,
    required this.listPerson,
    required this.timeDepart,
    required this.timeReturn,
    required this.from,
    required this.to,
  });

   Bus copyWith({
    String? contact,
    String? driver,
    String? from,
    String? id,
    List<Person>? listAllSubscribed,
    List<Person>? listPerson,
    String? name,
    String? number,
    int? size,
    DateTime? timeDepart,
    DateTime? timeReturn,
    String? to,
  }) {
    return Bus(
      contact: contact ?? this.contact,
      driver: driver ?? this.driver,
      from: from ?? this.from,
      id: id ?? this.id,
      listAllSubscribed: listAllSubscribed ?? this.listAllSubscribed,
      listPerson: listPerson ?? this.listPerson,
      name: name ?? this.name,
      number: number ?? this.number,
      size: size ?? this.size,
      timeDepart: timeDepart ?? this.timeDepart,
      timeReturn: timeReturn ?? this.timeReturn,
      to: to ?? this.to,
    );
  }
}
