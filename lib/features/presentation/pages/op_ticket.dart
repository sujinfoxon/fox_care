import 'package:flutter/material.dart';
import 'package:foxcare_app/features/presentation/pages/patient_registration.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'op_counters.dart';

class OpTicketPage extends StatefulWidget {
  @override
  State<OpTicketPage> createState() => _OpTicketPageState();
}

class _OpTicketPageState extends State<OpTicketPage> {
  int selectedIndex = 1;
  String selectedSex = 'Male'; // Default value for Sex
  String selectedBloodGroup = 'A+'; // Default value for Blood Group

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        title: Text('OP Ticket Dashboard'),
      )
          : null, // No AppBar for web view
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 250, // Sidebar width for larger screens
              color: Colors.blue.shade100,
              child: buildDrawerContent(), // Sidebar content
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return buildThreeColumnForm(); // Web view
                  } else {
                    return buildSingleColumnForm(); // Mobile view
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar content for desktop view
  Widget buildDrawerContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Reception',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        buildDrawerItem(0, 'Patient Registration', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PatientRegistration()),
          );
        },Iconsax.mask),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(1, 'OP Ticket', () {

        },Iconsax.receipt),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(2, 'IP Admission', () {},Iconsax.add_circle),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(3, 'OP Counters', () {

        },Iconsax.square),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(4, 'Admission Statement', () {},Iconsax.status),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(5, 'Doctor Visit Schedule', () {},Iconsax.hospital),

        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(7, 'Logout', () {
          // Handle logout action
        },Iconsax.logout),
      ],
    );
  }

  Widget buildDrawerItem(int index, String title, VoidCallback onTap,IconData icon) {
    return ListTile(
      selected: selectedIndex == index,
      selectedTileColor: Colors.blueAccent.shade100, // Highlight color for the selected item
      leading: Icon(
        icon, // Replace with actual icons
        color: selectedIndex == index ? Colors.blue : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: selectedIndex == index ? Colors.blue : Colors.black54,fontWeight: FontWeight.w700
        ),
      ),
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
        });
        onTap();
      },
    );
  }

  // Form layout for web with three columns
  Widget buildThreeColumnForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OP Ticket Information:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: buildTextField('OP Number')),
            SizedBox(width: 20),
            Expanded(child: buildTextField('First Name')),
            SizedBox(width: 20),
            Expanded(child: buildTextField('Last Name')),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: buildDropdown('Sex', ['Male', 'Female', 'Other'], selectedSex, (value) {
              setState(() {
                selectedSex = value!;
              });
            })),
            SizedBox(width: 20),
            Expanded(child: buildTextField('Age', inputType: TextInputType.number)),
            SizedBox(width: 20),
            Expanded(child: buildTextField('DOB (YYYY-MM-DD)', inputType: TextInputType.datetime)),
          ],
        ),
        SizedBox(height: 20),
        buildTextField('Address Line 1'),
        SizedBox(height: 16),
        buildTextField('Address Line 2'),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: buildTextField('City')),
            SizedBox(width: 20),
            Expanded(child: buildTextField('State')),
            SizedBox(width: 20),
            Expanded(child: buildTextField('Pincode', inputType: TextInputType.number)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: buildTextField('Mobile 1', inputType: TextInputType.phone)),
            SizedBox(width: 20),
            Expanded(child: buildTextField('Mobile 2', inputType: TextInputType.phone)),
          ],
        ),
        SizedBox(height: 20),
        buildDropdown('Blood Group', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], selectedBloodGroup, (value) {
          setState(() {
            selectedBloodGroup = value!;
          });
        }),
        SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }

  // Form layout for mobile with one column
  Widget buildSingleColumnForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OP Ticket Information:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        buildTextField('OP Number'),
        SizedBox(height: 16),
        buildTextField('First Name'),
        SizedBox(height: 16),
        buildTextField('Last Name'),
        SizedBox(height: 16),
        buildDropdown('Sex', ['Male', 'Female', 'Other'], selectedSex, (value) {
          setState(() {
            selectedSex = value!;
          });
        }),
        SizedBox(height: 16),
        buildTextField('Age', inputType: TextInputType.number),
        SizedBox(height: 16),
        buildTextField('DOB (YYYY-MM-DD)', inputType: TextInputType.datetime),
        SizedBox(height: 16),
        buildTextField('Address Line 1'),
        SizedBox(height: 16),
        buildTextField('Address Line 2'),
        SizedBox(height: 16),
        buildTextField('City'),
        SizedBox(height: 16),
        buildTextField('State'),
        SizedBox(height: 16),
        buildTextField('Pincode', inputType: TextInputType.number),
        SizedBox(height: 16),
        buildTextField('Mobile 1', inputType: TextInputType.phone),
        SizedBox(height: 16),
        buildTextField('Mobile 2', inputType: TextInputType.phone),
        SizedBox(height: 16),
        buildDropdown('Blood Group', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], selectedBloodGroup, (value) {
          setState(() {
            selectedBloodGroup = value!;
          });
        }),
        SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget to create TextFields
  Widget buildTextField(String label, {TextInputType inputType = TextInputType.text}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: inputType,
    );
  }

  // Helper widget to create Dropdowns
  Widget buildDropdown(String label, List<String> items, String selectedItem, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: selectedItem,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
