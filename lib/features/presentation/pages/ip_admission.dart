import 'package:flutter/material.dart';
import 'package:foxcare_app/features/presentation/pages/admission_status.dart';
import 'package:foxcare_app/features/presentation/pages/doctor_schedule.dart';
import 'package:foxcare_app/features/presentation/pages/op_counters.dart';
import 'package:foxcare_app/features/presentation/pages/patient_registration.dart';
import 'package:foxcare_app/features/presentation/widgets/custom_elements.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/theme/colors.dart';
import 'op_ticket.dart';

class IpAdmissionPage extends StatefulWidget {
  @override
  State<IpAdmissionPage> createState() => _IpAdmissionPageState();
}

class _IpAdmissionPageState extends State<IpAdmissionPage> {
  TimeOfDay now = TimeOfDay.now();
  final date = DateTime.timestamp();
  String SelectedRoom = 'Room';
  String vacantRoom = '1';
  String nursingStation = 'Station A';

  // List of room statuses (true = booked, false = available)
  List<bool> roomStatus = [true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> wardStatus = [true, true, false, false, false, false, false, false, false, false, false, false, false,];
  List<bool> viproomStatus = [true, true, true, false, false, false, false, false, false, false, false];
  List<bool> ICUStatus = [true, true, false, false, false,];

  //int selectedIndex = 1;
  //String selectedSex = 'Male'; // Default value for Sex
  String selectedBloodGroup = 'A+'; // Default value for Blood Group

  bool isSearchPerformed = false; // To track if search has been performed
  Map<String, String>? selectedPatient;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  bool isDataLoaded = false; // To control data loading when button is clicked
  List<Map<String, dynamic>> patientData = []; // Patient data
  int? selectedIndex; // Store selected checkbox index

  // Sample dummy data for patients
  List<Map<String, dynamic>> samplePatients = [
    {
      "opNumber": "OP001",
      "name": "John Doe",
      "age": 30,
      "address": "123 Street, City",
      "ipFromDate": "2024-01-10",
      "ipToDate": "2024-01-20"
    },
    {
      "opNumber": "OP002",
      "name": "Jane Smith",
      "age": 40,
      "address": "456 Avenue, City",
      "ipFromDate": "2024-01-05",
      "ipToDate": "2024-01-15"
    },
    {
      "opNumber": "OP003",
      "name": "Robert Brown",
      "age": 50,
      "address": "789 Boulevard, City",
      "ipFromDate": "2024-01-08",
      "ipToDate": "2024-01-18"
    }
  ];

  @override
  void dispose() {
    // Dispose the controller when it's no longer needed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        title: Text('OP Ticket Dashboard'),
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
        // Drawer items here
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
        buildDrawerItem(2, 'IP Admission', () {}, Iconsax.add_circle),
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
        buildDrawerItem(5, 'Doctor Visit Schedule', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => doctorSchedule()),
          );
        }, Iconsax.hospital),

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

  Widget buildThreeColumnForm() {
    double screenWidth = MediaQuery.of(context).size.width;


    bool isMobile = screenWidth < 600;
    return Align(
      alignment: isMobile ? Alignment.center : Alignment.topLeft,
      // Align top-left for web, center for mobile
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'IP Admission Portal :',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Rooms / Ward Availability',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 15,
          ),
          Scrollbar(
            controller: _scrollController, // Attach the ScrollController
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: [
                  Text('Rooms : '),
                  SizedBox(
                    width: 30,
                  ),
                  Wrap(
                    spacing: 10, // Horizontal spacing between rooms
                    runSpacing: 10, // Vertical spacing between rooms
                    children: List.generate(roomStatus.length, (index) {
                      return GestureDetector(
                        onTap: roomStatus[index]
                            ? null // Disable interaction if the room is booked
                            : () {
                          // Optional: Add booking functionality here if needed
                          // setState to toggle room status or handle booking logic
                        },
                        child: InkWell(
                          child: Container(
                            width: 50,
                            // Set a fixed width for each room box
                            height: 60,
                            // Set a fixed height for each room box
                            decoration: BoxDecoration(
                              color: roomStatus[index]
                                  ? Colors.green[200]
                                  : Colors.grey,
                              // Red for booked, green for available
                              borderRadius: BorderRadius.circular(2),
                              //border: Border.all(color: Colors.black, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('${index + 1}'),
                                Icon(
                                  Icons.bed_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('${index + 1} pressed');
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Scrollbar(
            thumbVisibility: true,
            controller: _scrollController1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController1,
              child: Row(
                children: [
                  Text('Wards : '),
                  SizedBox(
                    width: 30,
                  ),
                  Wrap(
                    spacing: 10, // Horizontal spacing between rooms
                    runSpacing: 10, // Vertical spacing between rooms
                    children: List.generate(wardStatus.length, (index) {
                      return GestureDetector(
                        onTap: wardStatus[index]
                            ? null // Disable interaction if the room is booked
                            : () {
                          // Optional: Add booking functionality here if needed
                          // setState to toggle room status or handle booking logic
                        },
                        child: InkWell(
                          child: Container(
                            width: 50,
                            // Set a fixed width for each room box
                            height: 60,
                            // Set a fixed height for each room box
                            decoration: BoxDecoration(
                              color: wardStatus[index]
                                  ? Colors.green[200]
                                  : Colors.grey,
                              // Red for booked, green for available
                              borderRadius: BorderRadius.circular(2),
                              //border: Border.all(color: Colors.black, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('${index + 1}'),
                                Icon(
                                  Icons.bed_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('${index + 1} pressed');
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Scrollbar(
            thumbVisibility: true,
            controller: _scrollController2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController2,
              child: Row(
                children: [
                  Text('VIP Rooms : '),
                  Wrap(
                    spacing: 10, // Horizontal spacing between rooms
                    runSpacing: 10, // Vertical spacing between rooms
                    children: List.generate(viproomStatus.length, (index) {
                      return GestureDetector(
                        onTap: viproomStatus[index]
                            ? null // Disable interaction if the room is booked
                            : () {
                          // Optional: Add booking functionality here if needed
                          // setState to toggle room status or handle booking logic
                        },
                        child: InkWell(
                          child: Container(
                            width: 50,
                            // Set a fixed width for each room box
                            height: 60,
                            // Set a fixed height for each room box
                            decoration: BoxDecoration(
                              color: viproomStatus[index]
                                  ? Colors.green[200]
                                  : Colors.grey,
                              // Red for booked, green for available
                              borderRadius: BorderRadius.circular(2),
                              //border: Border.all(color: Colors.black, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('${index + 1}'),
                                Icon(
                                  Icons.bed_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('${index + 1} pressed');
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Scrollbar(
            thumbVisibility: true,
            controller: _scrollController3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController3,
              child: Row(
                children: [
                  Text('ICU : '),
                  SizedBox(
                    width: 45,
                  ),
                  Wrap(
                    spacing: 10, // Horizontal spacing between rooms
                    runSpacing: 10, // Vertical spacing between rooms
                    children: List.generate(ICUStatus.length, (index) {
                      return GestureDetector(
                        onTap: ICUStatus[index]
                            ? null // Disable interaction if the room is booked
                            : () {
                          // Optional: Add booking functionality here if needed
                          // setState to toggle room status or handle booking logic
                        },
                        child: InkWell(
                          child: Container(
                            width: 50,
                            // Set a fixed width for each room box
                            height: 60,
                            // Set a fixed height for each room box
                            decoration: BoxDecoration(
                              color: ICUStatus[index]
                                  ? Colors.green[200]
                                  : Colors.grey,
                              // Red for booked, green for available
                              borderRadius: BorderRadius.circular(2),
                              //border: Border.all(color: Colors.black, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('${index + 1}'),
                                Icon(
                                  Icons.bed_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('${index + 1} pressed');
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 40,
          ),

          Text(
            'IP Initiation :',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30,),

          // Inpatient Registration Check button

          SizedBox(
            width: 350,
            child: CustomButton(label: "Inpatient Registration Check",onPressed: () {
              setState(() {
                isDataLoaded = true; // Show the data list on button click
                patientData = samplePatients; // Load patient data
              });
            },),
          ),
          SizedBox(height: 20),
          // Display the list of patient data after button click
          isDataLoaded ? buildPatientList() : Container(),
          SizedBox(height: 20),

          // Display selected patient details in text fields
          selectedIndex != null ? buildSelectedPatientDetails() : Container(),

          // Add other form fields or content below
        ],
      ),
    );
  }

  Widget buildSingleColumnForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'IP Admission Portal :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Rooms / Ward Availability',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 15,
        ),
        Scrollbar(
          controller: _scrollController, // Attach the ScrollController
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: [
                Text('Rooms : '),
                SizedBox(
                  width: 30,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between rooms
                  runSpacing: 10, // Vertical spacing between rooms
                  children: List.generate(roomStatus.length, (index) {
                    return GestureDetector(
                      onTap: roomStatus[index]
                          ? null // Disable interaction if the room is booked
                          : () {
                        // Optional: Add booking functionality here if needed
                        // setState to toggle room status or handle booking logic
                      },
                      child: InkWell(
                        child: Container(
                          width: 50,
                          // Set a fixed width for each room box
                          height: 60,
                          // Set a fixed height for each room box
                          decoration: BoxDecoration(
                            color: roomStatus[index]
                                ? Colors.green[200]
                                : Colors.grey,
                            // Red for booked, green for available
                            borderRadius: BorderRadius.circular(2),
                            //border: Border.all(color: Colors.black, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('${index + 1}'),
                              Icon(
                                Icons.bed_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('${index + 1} pressed');
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Scrollbar(
          thumbVisibility: true,
          controller: _scrollController1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController1,
            child: Row(
              children: [
                Text('Wards : '),
                SizedBox(
                  width: 30,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between rooms
                  runSpacing: 10, // Vertical spacing between rooms
                  children: List.generate(wardStatus.length, (index) {
                    return GestureDetector(
                      onTap: wardStatus[index]
                          ? null // Disable interaction if the room is booked
                          : () {
                        // Optional: Add booking functionality here if needed
                        // setState to toggle room status or handle booking logic
                      },
                      child: InkWell(
                        child: Container(
                          width: 50,
                          // Set a fixed width for each room box
                          height: 60,
                          // Set a fixed height for each room box
                          decoration: BoxDecoration(
                            color: wardStatus[index]
                                ? Colors.green[200]
                                : Colors.grey,
                            // Red for booked, green for available
                            borderRadius: BorderRadius.circular(2),
                            //border: Border.all(color: Colors.black, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('${index + 1}'),
                              Icon(
                                Icons.bed_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('${index + 1} pressed');
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Scrollbar(
          thumbVisibility: true,
          controller: _scrollController2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController2,
            child: Row(
              children: [
                Text('VIP Rooms : '),
                Wrap(
                  spacing: 10, // Horizontal spacing between rooms
                  runSpacing: 10, // Vertical spacing between rooms
                  children: List.generate(viproomStatus.length, (index) {
                    return GestureDetector(
                      onTap: viproomStatus[index]
                          ? null // Disable interaction if the room is booked
                          : () {
                        // Optional: Add booking functionality here if needed
                        // setState to toggle room status or handle booking logic
                      },
                      child: InkWell(
                        child: Container(
                          width: 50,
                          // Set a fixed width for each room box
                          height: 60,
                          // Set a fixed height for each room box
                          decoration: BoxDecoration(
                            color: viproomStatus[index]
                                ? Colors.green[200]
                                : Colors.grey,
                            // Red for booked, green for available
                            borderRadius: BorderRadius.circular(2),
                            //border: Border.all(color: Colors.black, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('${index + 1}'),
                              Icon(
                                Icons.bed_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('${index + 1} pressed');
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Scrollbar(
          thumbVisibility: true,
          controller: _scrollController3,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController3,
            child: Row(
              children: [
                Text('ICU : '),
                SizedBox(
                  width: 45,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between rooms
                  runSpacing: 10, // Vertical spacing between rooms
                  children: List.generate(ICUStatus.length, (index) {
                    return GestureDetector(
                      onTap: ICUStatus[index]
                          ? null // Disable interaction if the room is booked
                          : () {
                        // Optional: Add booking functionality here if needed
                        // setState to toggle room status or handle booking logic
                      },
                      child: InkWell(
                        child: Container(
                          width: 50,
                          // Set a fixed width for each room box
                          height: 60,
                          // Set a fixed height for each room box
                          decoration: BoxDecoration(
                            color: ICUStatus[index]
                                ? Colors.green[200]
                                : Colors.grey,
                            // Red for booked, green for available
                            borderRadius: BorderRadius.circular(2),
                            //border: Border.all(color: Colors.black, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('${index + 1}'),
                              Icon(
                                Icons.bed_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('${index + 1} pressed');
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 40,
        ),

        Text(
          'IP Initiation :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30,),

        // Inpatient Registration Check button

        SizedBox(
          width: 350,
          child: CustomButton(label: "Inpatient Registration Check",onPressed: () {
            setState(() {
              isDataLoaded = true; // Show the data list on button click
              patientData = samplePatients; // Load patient data
            });
          },),
        ),
        SizedBox(height: 20),
        // Display the list of patient data after button click
        isDataLoaded ? buildPatientList() : Container(),
        SizedBox(height: 20),

        // Display selected patient details in text fields
        selectedIndex != null ? buildSelectedPatientDetails() : Container(),

        // Add other form fields or content below
      ],
    );
  }

  // Build the list of patients with checkboxes
  Widget buildPatientList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: patientData.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(
              "${patientData[index]['opNumber']} - ${patientData[index]['name']}"),
          subtitle: Text(
              "Age: ${patientData[index]['age']} - IP from ${patientData[index]['ipFromDate']} to ${patientData[index]['ipToDate']}"),
          value: selectedIndex == index,
          onChanged: (bool? value) {
            setState(() {
              selectedIndex = index; // Set the selected patient
            });
          },
        );
      },
    );
  }

  Widget buildTextField(String label,
      {String? initialValue, TextInputType inputType = TextInputType.text}) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        // Reduces the overall height of the TextField
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue, width: 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      keyboardType: inputType,
      controller: TextEditingController(text: initialValue),
    );
  }

  Widget buildSelectedPatientDetails() {

    var selectedPatient = patientData[selectedIndex!];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('OP Number :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['opNumber']),
              ),
              SizedBox(width: 20,),

              Text('Name :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['name']),
              ),

            ],
          ),
          SizedBox(height: 30,),

          Row(
            children: [
              Text('Age :'),
              SizedBox(width: 65),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['age'].toString(),),
              ),
              SizedBox(width: 20,),

              Text('Address :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['address']),
              ),

            ],
          ),

          SizedBox(height: 30,),

          Row(
            children: [
              Text('From Date :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['ipFromDate']),
              ),
              SizedBox(width: 20,),

              Text('To Date :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customIPbuildTextField(selectedPatient['ipToDate']),
              ),

            ],
          ),

          SizedBox(height: 30,),

          Row(
            children: [
              Text('Stay :'),
              SizedBox(width: 60),
              SizedBox(
                width: 200,
                child: customDropdown('Stay',['Room','Ward','vipRoom','ICU'], SelectedRoom,(value) {
                  SelectedRoom = value!;
                }),
              ),
              SizedBox(width: 20,),

              Text('Availablility :'),
              SizedBox(width: 15),
              SizedBox(
                width: 200,
                child: customDropdown('Vacant',['1','2','3','4'], vacantRoom,(value) {
                  vacantRoom = value!;
                }),
              ),

            ],
          ),
          SizedBox(height: 25,),

          Row(
            children: [
              Text('Nursing Station :'),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: customDropdown('Station',['Station A','Station B','ICU Station'], nursingStation,(value) {
                  nursingStation = value!;
                }),
              ),
              SizedBox(width: 20,),



            ],
          ),
          SizedBox(height: 30,),
          Text(
            'By Stander Information :',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('By Stander Name : '),
              SizedBox(
                width: 200,
                child: custombuildTextField('Enter Name'),
              ),
              SizedBox(width: 20,),

              Text('Phone Number : '),
              SizedBox(
                width: 200,
                child: custombuildTextField('Enter Phone No'),
              ),

            ],
          ),
          SizedBox(height: 20,),

          Row(
            children: [
              Text('Relation : '),
              SizedBox(width: 30,),
              SizedBox(
                width: 200,
                child: custombuildTextField('Relation with patient'),
              ),
            ],
          ),

          SizedBox(height: 30,),

          Row(
            children: [
              SizedBox(width: 50,),
              SizedBox(
                width: 250,
                child: CustomButton(label: 'Register', onPressed: () {}),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
