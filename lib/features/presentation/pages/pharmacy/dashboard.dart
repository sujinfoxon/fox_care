

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({super.key});

  @override
  State<PharmacyDashboard> createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  // To store the index of the selected drawer item
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        title: Text('Pharmacy'),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: dashboard(),
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
          child: Column(
            children: [
              Text(
                'Pharmacy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/user_image.png'),
              ),
              SizedBox(height: 10),
              Text(
                'XYZ Hospital',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

            ],
          ),

        ),

        buildDrawerItem(0, 'Dashboard', () {

        },Iconsax.music_dashboard),

        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(1, 'Order', () {

        },Iconsax.monitor_recorder),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(2, 'Customer', () {

        },Iconsax.people),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(3, 'Doctor', () {

        },Iconsax.hospital),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(4, 'category', () {

        },Iconsax.status),
        Divider(height: 5,color:Colors.grey,),
        buildDrawerItem(5, 'Supplier', () {

        },Iconsax.hospital),

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

    return Align(
      alignment: isMobile ? Alignment.center : Alignment.topLeft, // Align top-left for web, center for mobile
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('child1')
          // Add other form fields or content below
        ],
      ),
    );
  }

  
}
