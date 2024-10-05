import 'package:flutter/material.dart';
import 'package:foxcare_app/features/presentation/pages/patient_registration.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/theme/colors.dart';
import '../widgets/custom_elements.dart';
import 'ip_admission.dart';
import 'op_ticket.dart';

class OpCounters extends StatefulWidget {
  const OpCounters({super.key});

  @override
  State<OpCounters> createState() => _OpCountersState();
}


class _OpCountersState extends State<OpCounters> {
  int selectedIndex = 3;
  List<bool> isCheckedList = [false];
  List<String?> selectedActionList = [null];
  List<String> actions = ['Cancel', 'Returned', 'Missing'];
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Dispose the controller when it's no longer needed
    _scrollController.dispose();
    super.dispose();
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
          SingleChildScrollView(child: dashboard()),
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
        buildDrawerItem(2, 'IP Admission', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => IpAdmissionPage()),
          );
        },Iconsax.add_circle),
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

  // Helper method to build drawer items with the ability to highlight the selected item
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

  // The form displayed in the body
  Widget dashboard() {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OP Counter Status :',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Text('Total Counters : '),
              SizedBox(
                width: 200,
                  child: CustomTextField(hintText: 'Total Counters'),),
              SizedBox(width: 20,),

              Text('Total Token Genenrated : '),
              SizedBox(
                  width: 250,
                  child: CustomTextField(hintText: 'Total Token Generated'),),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('Waiting Tokens : '),
              SizedBox(
                width: 250,
                child: CustomTextField(hintText: 'Total Waiting Tokens'),),
            ],
          ),
          SizedBox(height: 30,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Add horizontal scrolling for tables
            child: Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FixedColumnWidth(150.0), // Set fixed width for each column
                1: FixedColumnWidth(150.0),
                2: FixedColumnWidth(150.0),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Counter 1', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Counter 2', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Counter 3', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Dr. Rajesh (General Phy)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Dr. Lekshmi (Cardiology)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Dr. Babu (Orthopaedician)'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('5, 20, 25, 30'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('8, 9, 10, 14'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('2, 4, 19, 31'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 30,),

          // List of entries (replacing table)
          SizedBox(height: 20),
          Text(
            'Missing Tokens:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          // Wrap ListView.builder inside LayoutBuilder to constrain its width
          



        ],
      ),
    );
  }


}
