import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/L7HKFNNkzIIr1Ir1oyF1/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
              ));
            final documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection("chats/L7HKFNNkzIIr1Ir1oyF1/messages")
                .add({'text': 'This was added by clicking the button 2'});
          }),
    );
  }
}
