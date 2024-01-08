import 'package:flutter/material.dart';
import 'package:project/models/events.dart';
import 'package:project/presentation/organizer/AddEventPage.dart';
import 'package:project/service/EventCard.dart';
import 'package:project/service/EventService.dart';
import 'package:provider/provider.dart';

class HomeOrganizer extends StatefulWidget {
  @override
  _HomeOrganizerState createState() => _HomeOrganizerState();
}
class _HomeOrganizerState extends State<HomeOrganizer> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Text('AZA HomeOrganizer'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                // Implement the filtering logic based on the event name
                eventProvider.filterEvents(value);
              },
              decoration: InputDecoration(
                labelText: 'Search by Event Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    eventProvider.resetFilter();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<EventProvider>(
              builder: (context, eventProvider, child) {
                return ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: eventProvider.filteredEvents.length,
                  itemBuilder: (context, index) {
                    Event event = eventProvider.filteredEvents[index];

                    return EventCard(
                      event: event,
                      onDelete: () {
                        // Implement delete functionality
                        // You can use eventProvider.deleteEvent(event) to delete the event
                      },
                      onEdit: () {
                        // Implement edit functionality
                        // You can navigate to the EditEventPage with the selected event
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
