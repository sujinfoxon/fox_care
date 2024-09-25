import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../widgets/custom_elements.dart';
import 'op_ticket.dart';

class PatientRegistration extends StatefulWidget {
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  int selectedIndex = 0;
  String selectedSex = 'Male'; // Default value for Sex
  String selectedBloodGroup = 'A+'; // Default value for Blood Group

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text('Reception Dashboard'),
            )
          : null,
      drawer: isMobile
          ? Drawer(
              child: buildDrawerContent(), // Drawer minimized for mobile
            )
          : null, // No AppBar for web view
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 300, // Sidebar width for larger screens
              color: Colors.blue.shade100,
              child: buildDrawerContent(), // Sidebar content
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(28.0),
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OpTicketPage()),
          );
        },Iconsax.receipt),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(2, 'IP Admission', () {},Iconsax.add_circle),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(3, 'OP Counters', () {},Iconsax.square),
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
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient Information :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('OP Number : ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                    width: 200.0,
                    child: CustomTextField(
                      hintText: 'Enter OP Number',
                    )),
              ],
            ),
          ],
        ),
        SizedBox(height: 60),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              hintText: 'First Name',
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Middle Name',
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Last Name',
            )),
          ],
        ),
        SizedBox(height: 40),
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text('SEX :'),
            ),
            Expanded(
              child: customDropdown(
                'Sex',
                ['Male', 'Female', 'Other'],
                selectedSex,
                (value) {
                  setState(() {
                    selectedSex = value!;
                  });
                },
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 40,
              child: Text('AGE :'),
            ),
            Expanded(
                child: CustomTextField(hintText: '',),),
            SizedBox(width: 20),
            SizedBox(
              width: 40,
              child: Text('DOB :'),
            ),
            Expanded(
                child: CustomTextField(hintText: '(YYYY-MM-DD)',)
            ),
          ],
        ),
        SizedBox(height: 40),
        CustomTextField(hintText: 'Address Line 1'),
        SizedBox(height: 30),
        CustomTextField(hintText: 'Address Line 2'),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(child: CustomTextField(hintText: "Land Mark",)),
            SizedBox(width: 20),
            Expanded(child: CustomTextField(hintText: "City",)),
            SizedBox(width: 20),
            Expanded(child: CustomTextField(hintText: "State",)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child:
                    CustomTextField(hintText: 'Pincode',)),
            SizedBox(width: 20),
            Expanded(
                child:
                CustomTextField(hintText: 'Phone Number 1',)),
            SizedBox(width: 20),
            Expanded(
                child:
                CustomTextField(hintText: 'Phone Number 2',)),
          ],
        ),
        SizedBox(height: 40),

        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text('BLOOD GROUP :'),
            ),
            customDropdown(
                'Blood Group',
                ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                selectedBloodGroup, (value) {
              setState(() {
                selectedBloodGroup = value!;
              });
            }),
          ],
        ),


        SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: 400,
            child: CustomButton(label: 'Register', onPressed: () {},)
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                Text('OP Number ',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                    width: 200.0,
                    child: CustomTextField(
                      hintText: 'Enter OP Number',
                    )),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        custombuildTextField('First Name'),
        SizedBox(height: 16),
        custombuildTextField('Middle Name'),
        SizedBox(height: 16),
        custombuildTextField('Last Name'),
        SizedBox(height: 16),
        customDropdown('Sex', ['Male', 'Female', 'Other'], selectedSex,
            (value) {
          setState(() {
            selectedSex = value!;
          });
        }),
        SizedBox(height: 16),
        custombuildTextField('Age', inputType: TextInputType.number),
        SizedBox(height: 16),
        custombuildTextField('DOB (YYYY-MM-DD)', inputType: TextInputType.datetime),
        SizedBox(height: 16),
        custombuildTextField('Address Line 1'),
        SizedBox(height: 16),
        custombuildTextField('Address Line 2'),
        SizedBox(height: 16),
        custombuildTextField('Land Mark'),
        SizedBox(height: 16),
        custombuildTextField('City'),
        SizedBox(height: 16),
        custombuildTextField('State'),
        SizedBox(height: 16),
        custombuildTextField('Pincode', inputType: TextInputType.number),
        SizedBox(height: 16),
        custombuildTextField('Mobile 1', inputType: TextInputType.phone),
        SizedBox(height: 16),
        custombuildTextField('Mobile 2', inputType: TextInputType.phone),
        SizedBox(height: 16),
        customDropdown(
            'Blood Group',
            ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
            selectedBloodGroup, (value) {
          setState(() {
            selectedBloodGroup = value!;
          });
        }),
        SizedBox(height: 20),
        Center(
          child: SizedBox(
              width: 250,
              child: CustomButton(label: 'Register', onPressed: () {},)
          ),
        ),
      ],
    );
  }



  // Helper widget to create Dropdowns
  Widget buildDrop(String label, List<String> items, String selectedItem,
      ValueChanged<String?> onChanged) {
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
