import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/models/events.dart';

class EventProvider extends ChangeNotifier {
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  List<Event> _events = [];
  List<Event> _filteredEvents = [];

  List<Event> get events => _events;
  List<Event> get filteredEvents => _filteredEvents;

  EventProvider() {
    listenToEvents();
  }

  Event _currentEvent = Event.empty();

  void filterEvents(String query) {
    _filteredEvents = _events
        .where((event) =>
            event.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void resetFilter() {
    _filteredEvents = _events;
    notifyListeners();
  }

  void listenToEvents() {
    eventsCollection.snapshots().listen((QuerySnapshot snapshot) {
      _events = snapshot.docs
          .map((doc) => Event(
                name: doc['name'],
                date: doc['date'],
                location: doc['location'],
                type: doc['type'],
                participants: doc['participants'],
                photoUrl: doc['photoUrl'],
                userUid: doc['userUid'],
              ))
          .toList();
      // Reset filter when new data is received
      resetFilter();
      notifyListeners();
    });
  }

  Future<void> addEvent(Event event, String userUid) async {
    await eventsCollection.add({
      'name': event.name,
      'date': event.date,
      'location': event.location,
      'type': event.type,
      'participants': event.participants,
      'photoUrl': event.photoUrl,
      'userUid': userUid,
    });
    // Note: No need to call notifyListeners here because listenToEvents will handle updates
  }

  Event getEvent() {
    return _currentEvent;
  }

  void setCurrentEvent(Event event) {
    _currentEvent = event;
    notifyListeners();
  }
}
