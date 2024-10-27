import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PharmacyBillingScreen extends StatefulWidget {
  const PharmacyBillingScreen({super.key});

  @override
  State<PharmacyBillingScreen> createState() => _PharmacyBillingScreenState();
}

class _PharmacyBillingScreenState extends State<PharmacyBillingScreen> {
  @override
  Widget build(BuildContext context) {
    double textScale = MediaQuery.of(context).size.width / 800; // Adjust text size based on screen width

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Billing'),
        leading: const Icon(Icons.arrow_back),
        actions: const [Icon(Icons.search)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.lightBlue,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  CategoryButton(label: 'All Items'),
                  CategoryButton(label: 'Antibiotics'),
                  CategoryButton(label: 'Antihistamines'),
                  CategoryButton(label: 'Antihypertensives'),
                  CategoryButton(label: 'Analgesics'),
                  CategoryButton(label: 'Anticonvulsants'),
                ],
              ),
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
                      mainAxisSpacing:16.0,
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
                    padding: const EdgeInsets.all(8.0),
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
                        Text(
                          'Total Items: 5',
                          style: TextStyle(fontSize: 14 * textScale),
                        ),
                        Text(
                          'Total Quantity: 5',
                          style: TextStyle(fontSize: 14 * textScale),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
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


class CategoryButton extends StatelessWidget {
  final String label;

  const CategoryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[100],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
        onPressed: () {},
        child: Text(label, style: const TextStyle(fontSize: 14)),
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
                Text(
                  productName,
                  style: TextStyle(fontSize: 14 * textScale, fontWeight: FontWeight.bold),
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

