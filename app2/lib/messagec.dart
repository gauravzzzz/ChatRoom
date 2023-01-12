import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class messagesc extends StatefulWidget {
  String email;

  messagesc({required this.email});
  @override
  _messagescState createState() => _messagescState(email: email);
}

class _messagescState extends State<messagesc> {
  String email;

  _messagescState({required this.email});

  final Stream<QuerySnapshot> _messageStream1=  FirebaseFirestore.instance
      .collection('messagesc')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream1,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.purple,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        qs['email'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              qs['message'],
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            d.hour.toString().padLeft(2,'0') + ":" + d.minute.toString().padLeft(2,'0'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}