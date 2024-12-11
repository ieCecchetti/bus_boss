import 'package:bus_resolver/models/bus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bus_resolver/data/mocked_data.dart';
import 'package:bus_resolver/screens/bus_list_screen.dart';
import 'package:bus_resolver/screens/partecipants_list_screen.dart';
import 'package:bus_resolver/screens/trip_details_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const BusResolver());
}

class BusResolver extends StatelessWidget {
  const BusResolver({super.key});
// PartecipantListScreen(partecipantList: mockPerson..sort((a, b) => a.isStaff ? -1 : 1))

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Resolver',
      theme: theme,
      home: BusListScreen(busList: mockBuses),
    );
  }
}
