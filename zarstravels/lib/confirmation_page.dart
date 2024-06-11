import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmationPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String orderType;
  final String departureLocation;
  final String destinationLocation;
  final String schedule;
  final String numberOfPassengers;
  final String price;

  ConfirmationPage({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.orderType,
    required this.departureLocation,
    required this.destinationLocation,
    required this.schedule,
    required this.numberOfPassengers,
    required this.price,
  });

  Future<void> _confirmOrder(BuildContext context) async {
    // Create an instance of Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Save the order details to Firestore
    await firestore.collection('orders').add({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'orderType': orderType,
      'departureLocation': departureLocation,
      'destinationLocation': destinationLocation,
      'schedule': schedule,
      'numberOfPassengers': numberOfPassengers,
      'price': price,
    });

    // Navigate back to the home page or show a confirmation message
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order confirmed!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konfirmasi Order"),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildReadOnlyTextField("First Name", firstName)),
                  SizedBox(width: 10),
                  Expanded(child: _buildReadOnlyTextField("Last Name", lastName)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildReadOnlyTextField("Phone Number", phoneNumber)),
                  SizedBox(width: 10),
                  Expanded(child: _buildReadOnlyTextField("Email", email)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildReadOnlyTextField("Order Type", orderType)),
                  SizedBox(width: 10),
                  Expanded(child: _buildReadOnlyTextField("Departure Location", departureLocation)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildReadOnlyTextField("Destination Location", destinationLocation)),
                  SizedBox(width: 10),
                  Expanded(child: _buildReadOnlyTextField("Schedule", schedule)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildReadOnlyTextField("Number of Passengers", numberOfPassengers)),
                  SizedBox(width: 10),
                  Expanded(child: _buildReadOnlyTextField("Price", "Rp $price")),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Pembayaran melalui:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Mandiri - 1273237293 a/n Zars Travel'),
              Text('BCA - 132173212 a/n Zars Travel'),
              Text('BRI - 318534912 a/n Zars Travel'),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'firstName': firstName,
                          'lastName': lastName,
                          'phoneNumber': phoneNumber,
                          'email': email,
                          'schedule': schedule,
                          'numberOfPassengers': numberOfPassengers,
                          'price': price,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: Text("Update Order"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _confirmOrder(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      child: Text("Konfirmasi"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        controller: TextEditingController(text: value),
        readOnly: true,
      ),
    );
  }
}
