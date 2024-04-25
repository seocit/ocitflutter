import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class CompanyService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('company_list');

  Stream<Map<String, String>> getCompanyList() {
    return _database.onValue.map((event) {
      final Map<String, String> company = {};
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          company[key] = value['name'] as String;
          company[key] = value['address'] as String;
          company[key] = value['balance'] as String;
        });
      }
      return company;
    });
  }
}
