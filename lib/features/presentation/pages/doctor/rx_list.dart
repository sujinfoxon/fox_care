import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RxList extends StatefulWidget {
  const RxList({super.key});

  @override
  State<RxList> createState() => _RxListState();
}

class Patient {
  int opNumber;
  String name;
  int age;
  String diagnosis;
  int tokenNumber;
  String status;

  Patient({
    required this.opNumber,
    required this.name,
    required this.age,
    required this.diagnosis,
    required this.tokenNumber,
    this.status = 'Pending',
  });
}

class _RxListState extends State<RxList> {
  // To store the index of the selected drawer item
  int selectedIndex = 0;

  List<Patient> patients = [
    Patient(opNumber: 001, name: 'Ramesh', age: 25, diagnosis: 'Fever', tokenNumber: 10),
    // Add more patients as needed
  ];

  void editPatient(BuildContext context, int index) {
    Patient patient = patients[index];
    TextEditingController opNumberController = TextEditingController(text: patient.opNumber.toString());
    TextEditingController nameController = TextEditingController(text: patient.name);
    TextEditingController ageController = TextEditingController(text: patient.age.toString());
    TextEditingController diagnosisController = TextEditingController(text: patient.diagnosis);
    TextEditingController tokenNumberController = TextEditingController(text: patient.tokenNumber.toString());
    TextEditingController statusController = TextEditingController(text: patient.status);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Patient'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: opNumberController,
                  decoration: InputDecoration(labelText: 'OP Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: diagnosisController,
                  decoration: InputDecoration(labelText: 'Diagnosis'),
                ),
                TextField(
                  controller: tokenNumberController,
                  decoration: InputDecoration(labelText: 'Token Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  patient.opNumber = int.parse(opNumberController.text);
                  patient.name = nameController.text;
                  patient.age = int.parse(ageController.text);
                  patient.diagnosis = diagnosisController.text;
                  patient.tokenNumber = int.parse(tokenNumberController.text);
                  patient.status = statusController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        title: Text('Reception Dashboard'),
      )
          : null, // No AppBar for web view
      drawer: isMobile
          ? Drawer(
        child: buildDrawerContent(), // Drawer minimized for mobile
      )
          : null, // No drawer for web view (permanently open)
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 300, // Fixed width for the sidebar
              color: Colors.blue.shade100,
              child: buildDrawerContent(), // Sidebar always open for web view
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildHeader(),
                  SizedBox(height: 20),
                  Expanded(child: dashboard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Drawer content reused for both web and mobile
  Widget buildDrawerContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Doctor - Consultation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        buildDrawerItem(0, 'Home', () {}, Iconsax.mask),
        Divider(height: 5, color: Colors.grey),
        buildDrawerItem(1, 'Rx List', () {}, Iconsax.receipt),
        Divider(height: 5, color: Colors.grey),
        buildDrawerItem(2, 'Patient Search', () {}, Iconsax.receipt),
        Divider(height: 5, color: Colors.grey),
        buildDrawerItem(3, 'Pharmacy Stocks', () {}, Iconsax.add_circle),
        Divider(height: 5, color: Colors.grey),
        buildDrawerItem(4, 'Logout', () {
          // Handle logout action
        }, Iconsax.logout),
      ],
    );
  }

  // Helper method to build drawer items with the ability to highlight the selected item
  Widget buildDrawerItem(
      int index, String title, VoidCallback onTap, IconData icon) {
    return ListTile(
      selected: selectedIndex == index,
      selectedTileColor: Colors.blueAccent.shade100,
      // Highlight color for the selected item
      leading: Icon(
        icon, // Replace with actual icons
        color: selectedIndex == index ? Colors.blue : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: selectedIndex == index ? Colors.blue : Colors.black54,
            fontWeight: FontWeight.w700),
      ),
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
        });
        onTap();
      },
    );
  }

  Widget dashboard() {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Align(
      alignment: isMobile ? Alignment.center : Alignment.center,
      // Align top-left for web, center for mobile
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('OP Number')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Diagnosis')),
            DataColumn(label: Text('Token Number')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Action')),
          ],
          rows: List<DataRow>.generate(
            patients.length,
                (index) => DataRow(
              cells: <DataCell>[
                DataCell(Text(patients[index].opNumber.toString())),
                DataCell(Text(patients[index].name)),
                DataCell(Text(patients[index].age.toString())),
                DataCell(Text(patients[index].diagnosis)),
                DataCell(Text(patients[index].tokenNumber.toString())),
                DataCell(Text(patients[index].status)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => editPatient(context, index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Rx List - 28/10/2024",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
        SizedBox(height: 50,),

      ],
    );


  }

}
