import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/theme/colors.dart';
import 'package:provider/provider.dart';

class EntryUpdate extends StatefulWidget {
  final Entry entry;

  EntryUpdate({required this.entry});

  @override
  _EntryUpdateState createState() => _EntryUpdateState();
}

class _EntryUpdateState extends State<EntryUpdate> {

  final entryController = TextEditingController();

  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<EntryProvider>(context,listen: false);
    if (widget.entry != null){
      //Edit
      entryController.text = widget.entry.entry;

      entryProvider.loadAll(widget.entry);
    } else {
      //Add
      // entryProvider.loadAll(null);
      entryProvider.loadAll(widget.entry);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(formatDate(entryProvider.date, [MM, ' ', d, ', ', yyyy]))
          ,actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: (){
                _pickDate(context,entryProvider).then((value) {
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
              color: primary,
              child: Text('Update',style: TextStyle(color: Colors.white)),
              onPressed: () {
                entryProvider.updateEntry();
                Navigator.of(context).pop();
              },
            ),
            (widget.entry != null) ? RaisedButton(
              color: grey,
              child: Text('Delete',style: TextStyle(color: Colors.white)),
              onPressed: () {
                entryProvider.removeEntry(widget.entry.entryId);
                Navigator.of(context).pop();
              },
            ): Container(),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context, EntryProvider entryProvider) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: entryProvider.date, firstDate: DateTime(2019),
        lastDate: DateTime(2050));

    if (picked != null) return picked;
    return picked;
  }
}