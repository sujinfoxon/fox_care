import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foxcare_app/bloc/patient/patient_bloc.dart';
import 'package:foxcare_app/bloc/patient/patient_event.dart';
import 'package:foxcare_app/bloc/patient/patient_state.dart';
import 'package:foxcare_app/features/presentation/pages/ip_admission.dart';
import 'package:foxcare_app/features/presentation/receeption/op_ticket_generate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_elements.dart';
import 'admission_status.dart';
import 'op_counters.dart';
import 'op_ticket.dart';

class PatientRegistration extends StatefulWidget {
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  int selectedIndex = 0;
  String selectedSex = 'Male'; // Default value for Sex
  String selectedBloodGroup = 'A+'; // Default value for Blood Group
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController middlename = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController address1 = TextEditingController();
  final TextEditingController address2 = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();

  final Uuid uuid = Uuid(); // Create an instance of Uuid

  // Function to generate a unique ID
  String generateNumericUid() {
    var random = Random();
    // Generate a 6-digit random number and concatenate it with "Fox"
    return 'Fox' +
        List.generate(6, (_) => random.nextInt(10).toString()).join();
  }

  String uid = '';

  @override
  void initState() {
    // Call the method to generate the UID and assign it to 'uid'
    uid = generateNumericUid();
    super.initState();
  }

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
        }, Iconsax.mask),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(1, 'OP Ticket', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OpTicketPage()),
          );
        }, Iconsax.receipt),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(2, 'IP Admission', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => IpAdmissionPage()),
          );
        }, Iconsax.add_circle),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(3, 'OP Counters', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OpCounters()),
          );
        }, Iconsax.square),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(4, 'Admission Status', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdmissionStatus()),
          );
        }, Iconsax.status),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(5, 'Doctor Visit Schedule', () {}, Iconsax.hospital),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        buildDrawerItem(7, 'Logout', () {
          // Handle logout action
        }, Iconsax.logout),
      ],
    );
  }

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

  // Form layout for web with three columns
  Widget buildThreeColumnForm() {
    final bloc = BlocProvider.of<PatientFormBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient Information :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 60),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              hintText: 'First Name',
              controller: firstname,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Middle Name',
              controller: middlename,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Last Name',
              controller: lastname,
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
              child: CustomTextField(
                hintText: '',
                controller: age,
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 40,
              child: Text('DOB :'),
            ),
            Expanded(
                child: CustomTextField(
              hintText: '(YYYY-MM-DD)',
              controller: dob,
            )),
          ],
        ),
        SizedBox(height: 40),
        CustomTextField(
          hintText: 'Address Line 1',
          controller: address1,
        ),
        SizedBox(height: 30),
        CustomTextField(
          hintText: 'Address Line 2',
          controller: address2,
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              hintText: "Land Mark",
              controller: landmark,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: "City",
              controller: city,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: "State",
              controller: state,
            )),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              hintText: 'Pincode',
              controller: pincode,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Phone Number 1',
              controller: phone1,
            )),
            SizedBox(width: 20),
            Expanded(
                child: CustomTextField(
              hintText: 'Phone Number 2',
              controller: phone2,
            )),
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
            child: BlocConsumer<PatientFormBloc, PatientFormState>(
              listener: (context, state) {
                if (state is FormSubmitFailure) {
                  // Show failure SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error), // Display the error message
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is FormSubmitDuplicate) {
                  // Show duplicate entry SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Patient with the same data already exists.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else if (state is FormSubmitSuccess) {
                  // Show success SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Patient registered successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfPage(
                              lastName: lastname.text,
                              firstName: firstname.text,
                              address: address1.text,
                              age: age.text,
                              phone: phone1.text,
                              opNumber: uid,
                            )),
                    (Route<dynamic> route) =>
                        false, // This removes all previous routes
                  );
                }
              },
              builder: (context, currentState) {
                return currentState is FormSubmitting
                    ? Center(
                        child: SpinKitPumpingHeart(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      )
                    : CustomButton(
                        label: 'Register',
                        onPressed: () {
                          bloc.add(SubmitForm(
                            firstname: firstname.text,
                            lastname: lastname.text,
                            middlename: middlename.text,
                            dob: dob.text,
                            age: age.text,
                            address1: address1.text,
                            address2: address2.text,
                            landmark: landmark.text,
                            city: city.text,
                            state: state.text,
                            pincode: pincode.text,
                            phone1: phone1.text,
                            phone2: phone2.text,
                            sex: selectedSex,
                            bloodGroup: selectedBloodGroup,
                            opNumber: uid,
                          ));
                        },
                      );
              },
            ),
          ),
        )
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
        custombuildTextField('First Name', controller: firstname),
        SizedBox(height: 16),
        custombuildTextField('Middle Name', controller: middlename),
        SizedBox(height: 16),
        custombuildTextField('Last Name', controller: lastname),
        SizedBox(height: 16),
        customDropdown('Sex', ['Male', 'Female', 'Other'], selectedSex,
            (value) {
          setState(() {
            selectedSex = value!;
          });
        }),
        SizedBox(height: 16),
        custombuildTextField('Age',
            inputType: TextInputType.number, controller: age),
        SizedBox(height: 16),
        custombuildTextField('DOB (YYYY-MM-DD)',
            inputType: TextInputType.datetime, controller: dob),
        SizedBox(height: 16),
        custombuildTextField('Address Line 1', controller: address1),
        SizedBox(height: 16),
        custombuildTextField('Address Line 2', controller: address2),
        SizedBox(height: 16),
        custombuildTextField('Land Mark', controller: landmark),
        SizedBox(height: 16),
        custombuildTextField('City', controller: city),
        SizedBox(height: 16),
        custombuildTextField('State', controller: state),
        SizedBox(height: 16),
        custombuildTextField('Pincode',
            inputType: TextInputType.number, controller: pincode),
        SizedBox(height: 16),
        custombuildTextField('Mobile 1',
            inputType: TextInputType.phone, controller: phone1),
        SizedBox(height: 16),
        custombuildTextField('Mobile 2',
            inputType: TextInputType.phone, controller: phone2),
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
              child: CustomButton(
                label: 'Register',
                onPressed: () {},
              )),
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
