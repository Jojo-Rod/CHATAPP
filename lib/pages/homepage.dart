import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/chatpage.dart';
import 'package:main/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_auth.currentUser!.email!),
      ),
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: const Text("HomePage"),
      //   actions: [
      //   ],
      // ),
      body: Center(
        child: Card(
          shadowColor: Colors.blueGrey,
          elevation: 50,
            child: Container(
                width: 1500,
                height: 700,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 1450,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0), 
                            ),
                          ),
                          // color: const Color.fromRGBO(38, 201, 38, 0.498),
                          child:
                              const ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(33, 33, 33, 1))
                                  ,foregroundColor: MaterialStatePropertyAll(Colors.grey),
                                ),
                                onPressed:null,child: Text("Chats", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _buildUserList(),
                        
                      ],
                    ),
                  ),
                ))),
      ),
      floatingActionButton: FloatingActionButton(onPressed: signOut,child: const Icon(Icons.logout_rounded),)
    );
  }

// build a list of users except for the current logged in user

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error : ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading......");
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

// build individual user list items

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
          color: Colors.grey[300],
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(data['email']),
            onTap: () {
              // pass the clicked user's UID TO THE CHAT PAGE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserEmail: data['email'],
                    receiverUserID: data['uid'],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
