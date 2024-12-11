import 'package:flutter/material.dart';
import 'package:bus_resolver/models/bus.dart';
import 'package:bus_resolver/screens/bus_details_tabs.dart';

class BusItem extends StatelessWidget {
  final Bus bus;

  const BusItem({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final travelDate = bus.timeDepart.toLocal().toString().split(' ')[0];
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.directions_bus),
      ),
      title: Text('${bus.name}'),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bus Number: ${bus.number}'),
          Text('${bus.from} - ${bus.to} del ${travelDate}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Call button action
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BusDetails(selectedBus: bus),
          ),
        );
      },
    );
  }
}
