import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeeform/employee.dart';
import 'package:employeeform/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController inputController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  void getOntheload() async {
    EmployeeStream = await DatabaseMethod().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOntheload();
    super.initState();
  }

  Stream? EmployeeStream;
  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    // ignore: unused_local_variable
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "name: " + ds["name"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      inputController.text = ds["name"];
                                      ageController.text = ds["age"];
                                      locationController.text = ds["location"];
                                      editEmployeeDetails(ds["id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethod()
                                          .deleteEmployeedetail(ds["id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "age: " + ds["age"],
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "location: " + ds["location"],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Employee()));
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Firebase",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
        child: Column(
          children: [Expanded(child: allEmployeeDetails())],
        ),
      ),
    );
  }

  Future editEmployeeDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: Container(
              height: 450,
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(width: 60.0),
                    const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 13, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: inputController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text("Age",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: ageController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text("Location",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: locationController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
                Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> updateinfo = {
                      "name": inputController.text,
                      "age": ageController.text,
                      "location": locationController.text,
                      "id": id
                    };
                    await DatabaseMethod()
                        .updateEmployeedetail(id, updateinfo)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Update"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shadowColor: Colors.grey,
                    backgroundColor: Colors.amber[100],
                  ),
                ))
              ]))));
}
