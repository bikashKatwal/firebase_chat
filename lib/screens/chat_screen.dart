import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: Text('Flutter chat'),
        actionWidgets: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text("Logout")
                    ],
                  ))
            ],
            onChanged: (value) {
              if (value == 'logout') {
                AuthService _authService = AuthService();
                _authService.signOut();
              }
            },
          )
        ],
      ),
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
