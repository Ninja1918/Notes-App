import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/screens/mainApp/edit_screen.dart';
import 'package:to_do_list/screens/signin_screen.dart';
import 'package:to_do_list/screens/mainApp/add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_services.dart';

class MainHomePage extends StatelessWidget {
  final String _email;
  MainHomePage(this._email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPage(_email)));
            }),
            child: const Icon(Icons.add)),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignIn()));
                  });
                },
                icon: Icon(Icons.logout)),
            Padding(padding: EdgeInsets.all(3))
          ],
          title: const Text(
            "Note Making App",
            style: TextStyle(fontFamily: "Roboto"),
          ),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: firebaseFirestore.collection(_email).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final res = snapshot.data!.docs[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.redAccent,
                        child: Icon(Icons.delete),
                      ),
                      onDismissed: (v) {
                        delete(res.id, _email);
                      },
                      child: Card(
                          child: ExpansionTile(
                        title: Text("${res['title']}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        children: [
                          Container(
                              alignment: AlignmentDirectional.centerStart,
                              color: Color.fromARGB(221, 163, 77, 28),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: Text(
                                "${res['detail']}",
                                style: TextStyle(color: Colors.white),
                              )),
                          Row(
                            children: [Text('Date: '), Text("${res['date']}")],
                          )
                        ],
                        leading: IconButton(
                            onPressed: () {
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                            res.id,
                                            res['title'],
                                            res['detail'],
                                            _email)));
                              }
                            },
                            icon: const Icon(Icons.edit)),
                      )),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
