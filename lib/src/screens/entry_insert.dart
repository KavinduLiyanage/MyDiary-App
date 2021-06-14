import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:provider/provider.dart';

class EntryInsert extends StatefulWidget {

  @override
  _EntryInsertState createState() => _EntryInsertState();
}

class _EntryInsertState extends State<EntryInsert> {

  final entryController = TextEditingController();

  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<EntryProvider>(context,listen: false);

    // if (widget.entry != null){
    //   //Edit
    //   entryController.text = widget.entry.entry;
    //
    //   entryProvider.loadAll(widget.entry);
    // } else {
    //   //Add
    //   // entryProvider.loadAll(null);
    //   // entryProvider.loadAll(widget.entry);
    // }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Select date")
          ,actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: (){
                _pickDate(context).then((value) {
                  // entryProvider.changeDate = value!;
                  if (value != null){
                    entryProvider.changeDate = value;
                  }
                });
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Daily Entry', border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) => entryProvider.changeEntry = value,
              controller: entryController,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Save',style: TextStyle(color: Colors.white)),
              onPressed: () {
                print('save');
                entryProvider.saveEntry();
                Navigator.of(context).pop();
              },
            ),
            // (widget.entry != null) ? RaisedButton(
            //   color: Colors.red,
            //   child: Text('Delete',style: TextStyle(color: Colors.white)),
            //   onPressed: () {
            //     entryProvider.removeEntry(widget.entry.entryId);
            //     Navigator.of(context).pop();
            //   },
            // ): Container(),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2019),
        lastDate: DateTime(2050));

    if (picked != null) return picked;
    return picked;
  }
}