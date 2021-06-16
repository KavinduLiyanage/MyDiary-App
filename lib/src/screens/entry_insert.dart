import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/theme/colors.dart';
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
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text((entryProvider.date != null)
              ? formatDate(entryProvider.date, [MM, ' ', d, ', ', yyyy])
              : "Select date"),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _pickDate(context).then((value) {
                  if (value != null) {
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
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage("images/login.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Enter your note",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextField(
                    maxLines: 12,
                    minLines: 8,
                    onChanged: (String value) =>
                        entryProvider.changeEntry = value,
                    controller: entryController,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print('save');
                        entryProvider.saveEntry();
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) => RootApp()));
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));

    if (picked != null) return picked;
    return picked;
  }
}
