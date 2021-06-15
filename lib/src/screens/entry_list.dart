import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/screens/entry_update.dart';
import 'package:mydiary/src/screens/entry_insert.dart';
import 'package:provider/provider.dart';

class EntryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Journal'),
      ),
      body: StreamBuilder<List<Entry>>(
          stream: entryProvider.entries,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.white10,
                  child: ListTile(
                  trailing:
                  Icon(Icons.edit, color: Colors.deepOrange),
                  title: Row(
                  children: [
                  Text(
                  snapshot.data![index].entry,
                  ),
                  ],
                  ),
                  subtitle: Row(

                  children: [
                  Text(
                  formatDate(DateTime.parse(snapshot.data![index].date),
                  [MM, ' ', d, ', ', yyyy]),
    )
    ],
    ),
    onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>
    EntryUpdate(entry: snapshot.data![index])));
    },
    ),
                  );
                },
    );
    }
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EntryInsert()));
        },
      ),
    );
  }
}