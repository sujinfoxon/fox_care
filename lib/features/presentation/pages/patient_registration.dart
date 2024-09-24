

import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget {
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
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
              width: 250, // Fixed width for the sidebar
              color: Colors.blue.shade100,
              child: buildDrawerContent(), // Sidebar always open for web view
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: buildForm(),
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
            'Reception',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text('Patient Registration'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('OP Ticket'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('IP Admission'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('OP Counters'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Admission Statement'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Doctor Visit Schedule'),
          onTap: () {},
        ),
        ListTile(
          title: Text('OP Ticket'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            // Handle logout action
          },
        ),
      ],
    );
  }

  // The form displayed in the body
  Widget buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admission Form', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),

          // OP Number
          TextField(
            decoration: InputDecoration(labelText: 'OP Number'),
          ),
          SizedBox(height: 16),

          // First Name
          TextField(
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          SizedBox(height: 16),

          // Middle Name
          TextField(
            decoration: InputDecoration(labelText: 'Middle Name'),
          ),
          SizedBox(height: 16),

          // Cast Name
          TextField(
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          SizedBox(height: 16),

          // Sex
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Sex'),
            items: ['Male', 'Female', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 16),

          // Age
          TextField(
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),

          // DOB
          TextField(
            decoration: InputDecoration(labelText: 'DOB (YYYY-MM-DD)'),
          ),
          SizedBox(height: 16),

          // Address Line 1
          TextField(
            decoration: InputDecoration(labelText: 'Address Line 1'),
          ),
          SizedBox(height: 16),

          // Address Line 2
          TextField(
            decoration: InputDecoration(labelText: 'Address Line 2'),
          ),
          SizedBox(height: 16),

          // Land Mark
          TextField(
            decoration: InputDecoration(labelText: 'Land Mark'),
          ),
          SizedBox(height: 16),

          // City
          TextField(
            decoration: InputDecoration(labelText: 'City'),
          ),
          SizedBox(height: 16),

          // State
          TextField(
            decoration: InputDecoration(labelText: 'State'),
          ),
          SizedBox(height: 16),

          // Pincode
          TextField(
            decoration: InputDecoration(labelText: 'Pincode'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),

          // Mobile 1
          TextField(
            decoration: InputDecoration(labelText: 'Mobile 1'),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),

          // Mobile 2
          TextField(
            decoration: InputDecoration(labelText: 'Mobile 2'),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),

          // Blood Group
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Blood Group'),
            items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 20),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle submit action
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}