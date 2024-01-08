import 'package:flutter/material.dart';
import 'package:project/models/events.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  EventCard({
    required this.event,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            event.photoUrl,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text('Date: ${event.date}'),
                Text('Location: ${event.location}'),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}