import 'package:flutter/material.dart';
import 'package:mydiary/src/models/entry.dart';
import 'package:mydiary/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  late DateTime _date;
  late String _entry;
  late String _entryId;
  var uuid = Uuid();

  //Getters
  DateTime get date => _date;
  String get entry => _entry;
  Stream<List<Entry>> get entries => firestoreService.getEntries();

  //Setters
  set changeDate(DateTime date){
    _date = date;
    notifyListeners();
  }

  set changeEntry(String entry){
    _entry = entry;
    notifyListeners();
  }

  //Functions
  loadAll(Entry entry){
    if (entry != null){
      _date = DateTime.parse(entry.date);
      _entry =entry.entry;
      _entryId = entry.entryId;
    } else {
      _date = DateTime.now();
      _entry = '';
      _entryId = '';
    }
  }

  saveEntry(){
    print('saveEntry');
    print('Add');
    var newEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: uuid.v1());
    firestoreService.setEntry(newEntry);
    // if (_entryId === null){
    //   //Add
    //   print('Add');
    //   var newEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: uuid.v1());
    //   firestoreService.setEntry(newEntry);
    // } else {
    //   //Edit
    //   print('Edit');
    //   var updatedEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: _entryId);
    //   firestoreService.setEntry(updatedEntry);
    // }
  }

  updateEntry(){
    print('updateEntry');
    print('Edit');
    var updatedEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: _entryId);
    firestoreService.setEntry(updatedEntry);
    // if (_entryId == null){
    //   //Add
    //   print('Add');
    //   var newEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: uuid.v1());
    //   firestoreService.setEntry(newEntry);
    // } else {
    //   //Edit
    //   print('Edit');
    //   var updatedEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: _entryId);
    //   firestoreService.setEntry(updatedEntry);
    // }
  }

  removeEntry(String entryId){
    firestoreService.removeEntry(entryId);
  }

}