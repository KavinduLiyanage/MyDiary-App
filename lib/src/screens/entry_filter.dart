import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/helpers/colorList.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/screens/entry_update.dart';
import 'package:mydiary/src/screens/entry_insert.dart';
import 'package:mydiary/src/theme/colors.dart';
import 'package:provider/provider.dart';

class EntryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Diary'),
        leading: Icon(
          Icons.menu,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: EntrySearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder<List<Entry>>(
          stream: entryProvider.entries,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EntryUpdate(entry: snapshot.data![index])));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.01),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 25, right: 25, bottom: 25, top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDate(DateTime.parse(snapshot.data![index].date),
                                    [MM, ' ', d, ', ', yyyy]),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d).withOpacity(0.6)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].entry,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: (size.width - 40),
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff67727d).withOpacity(0.1)),
                                  ),
                                  Container(
                                    width: (size.width - 40) *
                                        colorList[index]['percentage'],
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: colorList[index]['color']),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                );
              },
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add, color: Colors.deepOrange),
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => EntryInsert()));
      //   },
      // ),
    );
  }
}

class EntrySearch extends SearchDelegate<String> {
  final entrylist = [
    "Trip to Kandy",
    "Medical Checkups",
    "New Year Resolutions",
    "My Weight Loss Routine",
    "My New Job"
  ];

  final recententrylist = [
    "Trip to Kandy",
    "Weight Loss Routine",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white10,
      child: ListTile(
        trailing: Icon(Icons.edit, color: Colors.deepOrange),
        title: Row(
          children: [
            Text(
              "My New Job",
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Text(
              "March 1, 2021",
            )
          ],
        ),
        onTap: () {},
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
        onTap: () {
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
