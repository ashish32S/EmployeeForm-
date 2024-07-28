import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }

  Future updateEmployeedetail(
      String id, Map<String, dynamic> updateinfo) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateinfo);
  }

  Future deleteEmployeedetail(String id) async {
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }
}
