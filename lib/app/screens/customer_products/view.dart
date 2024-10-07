import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CustomerProducts extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Television | Samsung | TV | 42\"",
      "price": "₹ 69000",
      "type": "Product",
      "serialNumber": "78521874850",
      "status": "Warehouse",
    },
    {
      "name": "Washing Machine | Haier | 9Kg",
      "price": "₹ 69000",
      "type": "Product",
      "serialNumber": "78521874100",
      "status": "Warehouse",
    },
    // More products...
  ];

  CustomerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.customerProducts,
      showBackButton: true,
      stepperAvailable: false,
      showFloatingActionButton: false,
      body: Column(
        children: [
          _buildCustomerInfo(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // Shadow on the bottom
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, -2), // Shadow on the top
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'John Mathew Richard',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '9876543210',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductCard(products[index]),
          ),
          _buildDeliveryChargeInput(),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        color: CustomColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductHeader(product),
              SizedBox(height: 8),
              _buildProductDetails(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(Map<String, dynamic> product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product['name'],
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            product['status'],
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails(Map<String, dynamic> product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetailColumn(TextString.price, product['price']),
        _buildDetailColumn(TextString.type, product['type']),
        _buildDetailColumn(TextString.serialNo, product['serialNumber']),
      ],
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDeliveryChargeInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: TextString.deliveryCharge,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            // Submit action here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.selectionColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(
            TextString.submit,
            style: TextStyle(color: CustomColors.white),
          ),
        ),
      ],
    );
  }
}
