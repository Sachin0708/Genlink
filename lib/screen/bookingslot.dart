import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

class BookSlotScreen extends StatelessWidget {
  final QueryDocumentSnapshot matchUser;
  final _slotController = TextEditingController();

  BookSlotScreen({super.key, required this.matchUser});

  Future<void> _bookSlot() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('sessions').add({
      'user1': currentUser.uid,
      'user2': matchUser.id,
      'time': _slotController.text,
      'status': 'pending',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Slot with ${matchUser['name']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _slotController,
              decoration: const InputDecoration(
                labelText: 'Select Date & Time',
                hintText: 'DD/MM/YYYY HH:MM',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _bookSlot();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(matchUser: matchUser),
                  ),
                );
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}