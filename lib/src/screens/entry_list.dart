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
        actions: <Widget>[
          IconButton(onPressed: (){
             showSearch(context: context, delegate: EntrySearch());
          }, icon: Icon(Icons.search))
        ],
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
                      Icon(Icons.edit, color: Colors.orange),
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
        child: Icon(Icons.add, color: Colors.deepOrange),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EntryInsert()));
        },
      ),
    );
  }
}

class EntrySearch extends SearchDelegate<String>{

  final entrylist = [
    "Trip to Kandy",
    "Medical Checkups",
    "New Year Resolutions",
    "Weight Loss Routine"
  ];

  final recententrylist = [
    "Trip to Kandy",
    "Medical Checkups",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
        onPressed: (){
      query = "" ;
        },
        icon: Icon(Icons.clear)
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
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
              "Medical Checkups",
            ),
          ],
        ),
        subtitle: Row(

          children: [
            Text(
              "June 1, 2021",
            )
          ],
        ),
        onTap: () {
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recententrylist
        : entrylist.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: (){
            showResults(context);
          },
          title: RichText(text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold
            ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)
                )
              ]
          ),),
        ),
      itemCount: suggestionList.length,
    );
  }
  
}