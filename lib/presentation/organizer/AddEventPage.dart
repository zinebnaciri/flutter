import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/events.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventTypeController = TextEditingController();
  TextEditingController eventParticipantsController = TextEditingController();
  String imageUrl = '';
  late String userUid;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    userUid = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageUrl = pickedImage.path;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _uploadImageAndAddEvent() async {
    try {
      if (imageUrl.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref();
        File imageFile = File(imageUrl);
        String imageName = path.basename(imageFile.path);
        Reference storageReference = storageRef.child('images/$imageName');

        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          String downloadUrl = await storageReference.getDownloadURL();
          print("Download URL: $downloadUrl");

          Event newEvent = Event(
            name: eventNameController.text,
            date: eventDateController.text,
            location: eventLocationController.text,
            type: eventTypeController.text,
            participants: eventParticipantsController.text,
            photoUrl: downloadUrl,
            userUid: userUid,
          );

          await _addEvent(newEvent);

          _clearInputFields();
          imageUrl = '';

          Navigator.of(context).pop();
        });
      } else {
        print("Please select an image for the event");
      }
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
    }
  }

  Future<void> _addEvent(Event event) async {
    await _firestore.collection('events').add(event.toMap());
  }

  void _clearInputFields() {
    eventNameController.clear();
    eventDateController.clear();
    eventLocationController.clear();
    eventTypeController.clear();
    eventParticipantsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey,
              child: imageUrl.isNotEmpty
                  ? Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text('No Image Selected'),
                    ),
            ),
            TextField(
              controller: eventNameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            TextField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  eventDateController.text = _dateFormat.format(pickedDate);
                }
              },
              controller: eventDateController,
              decoration: InputDecoration(labelText: 'Event Date'),
            ),
            TextField(
              controller: eventLocationController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: eventTypeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: eventParticipantsController,
              decoration: InputDecoration(labelText: 'Participants'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImageAndAddEvent,
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
