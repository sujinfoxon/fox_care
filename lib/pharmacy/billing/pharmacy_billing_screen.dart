import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.lightBlue[100] : Colors.transparent, // Active tab has background, others are transparent
          foregroundColor: isActive ? Colors.black : Colors.white, // Adjust text color for visibility
          elevation: isActive ? 2 : 0, // Add slight elevation for active button
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Set border radius
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 19)),
      ),
    );
  }
}

class CategoryTabs extends StatefulWidget {
  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int activeIndex = 0; // Tracks the active tab index

  final List<String> categories = [
    "All Items",
    "Antibiotics",
    "Antihistamines",
    "Antihypertensives",
    "Analgesics",
    "Anticonvulsants"
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        categories.length,
            (index) => CategoryButton(
          label: categories[index],
          isActive: index == activeIndex, // Check if this is the active tab
          onPressed: () {
            setState(() {
              activeIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class PharmacyBillingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double textScale = MediaQuery.of(context).size.width / 900; // Adjust text size based on screen width
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5BC0DE),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back, color: Colors.white),
            Text('Medical Billing'),
            Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  height: 30, // Set your desired height
                  width: 300, // Set your desired width
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Set background color
                    borderRadius: BorderRadius.circular(4), // Optional: Set border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for medicines',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF5BC0DE)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color(0xFF5BC0DE),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CategoryTabs(),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: MediaQuery.of(context).size.width > 800 ? 0.8 : 0.7,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        textScale: textScale,
                        productName: index == 1 ? 'Parasitamol' : 'Asthma Tablet',
                        productPrice: index == 1 ? 'Rs:42' : 'Rs:157',
                      );
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    color: Colors.lightBlue[50],
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amioder 100mg Tablet 10’s',
                          style: TextStyle(fontSize: 14 * textScale, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text('Amioder 100mg Tablet 10’s  ₹125',
                                    style: TextStyle(fontSize: 12 * textScale)),
                              );
                            },
                          ),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            'Add Discounts',
                            style: TextStyle(fontSize: 12 * textScale),
                          ),
                          items: <String>['10%', '20%', '30%']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12 * textScale)),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Items: 5',
                              style: TextStyle(fontSize: 14 * textScale),
                            ),
                            Text(
                              'Total Quantity: 5',
                              style: TextStyle(fontSize: 14 * textScale),
                            ),
                          ],
                        ),

                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5BC0DE),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {},
                          child: Text(
                            '₹500  Check Out',
                            style: TextStyle(fontSize: 16 * textScale, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final double textScale;
  final String productName;
  final String productPrice;

  const ProductCard({
    required this.textScale,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Icon(Icons.medical_services, size: 20 * textScale, color: Colors.lightBlue),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    productName,
                    style: TextStyle(fontSize: 14 * textScale, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  productPrice,
                  style: TextStyle(fontSize: 14 * textScale, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

