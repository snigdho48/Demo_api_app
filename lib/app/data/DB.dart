import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getNoti() =>
      _db.collection('push').snapshots();
}
