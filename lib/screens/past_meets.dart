import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vid_call/resources/firestore_resources.dart';

class PastMeets extends StatelessWidget {
  const PastMeets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreRes().pastMeetings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              int hasCreatedthis = ((snapshot.data! as dynamic).docs[index]
                      ['joinedAt'])
                  .toString()
                  .compareTo("Null");

              String text = "";
              if (hasCreatedthis == 0) {
                //if joinedAt is null then the user has created this
                text =
                    'Created at ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}';
              } else {
                text =
                    'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['joinedAt'].toDate())}';
              }
              return ListTile(
                leading: (hasCreatedthis == 0)
                    ? const Icon(
                        Icons.person,
                        size: 30,
                      )
                    : const Icon(
                        Icons.transit_enterexit_sharp,
                        size: 30,
                      ),
                title: Text(
                  'Meet ID: ${(snapshot.data! as dynamic).docs[index]['meetName']}',
                ),
                subtitle: Text(
                  text,
                ),
              );
            });
      },
    );
  }
}
