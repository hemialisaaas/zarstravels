import 'package:flutter/material.dart';
import 'confirmation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Widget OrderPage yang menerima detail order sebagai parameter
class OrderPage extends StatefulWidget {
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

  // Konstruktor untuk menerima parameter order
  OrderPage({
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

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Deklarasi controller untuk setiap TextField
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _orderTypeController;
  late TextEditingController _departureLocationController;
  late TextEditingController _destinationLocationController;
  late TextEditingController _scheduleController;
  late TextEditingController _passengerController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai yang diterima dari widget
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _emailController = TextEditingController(text: widget.email);
    _orderTypeController = TextEditingController(text: widget.orderType);
    _departureLocationController = TextEditingController(text: widget.departureLocation);
    _destinationLocationController = TextEditingController(text: widget.destinationLocation);
    _scheduleController = TextEditingController(text: widget.schedule);
    _passengerController = TextEditingController(text: widget.numberOfPassengers);
    _priceController = TextEditingController(text: (int.parse(widget.numberOfPassengers) * int.parse(widget.price)).toString());
    _passengerController.addListener(_updatePrice); // Listener untuk memperbarui harga berdasarkan jumlah penumpang
  }

  // Fungsi untuk memperbarui harga berdasarkan jumlah penumpang
  void _updatePrice() {
    int passengerCount = int.tryParse(_passengerController.text) ?? 0;
    int totalPrice = passengerCount * int.parse(widget.price);
    _priceController.text = totalPrice.toString();
  }

  @override
  void dispose() {
    // Dispose controller untuk menghindari kebocoran memori
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _orderTypeController.dispose();
    _departureLocationController.dispose();
    _destinationLocationController.dispose();
    _scheduleController.dispose();
    _passengerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengonfirmasi order dan menyimpan detailnya ke Firebase
  Future<void> _confirmOrder() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Tambahkan logika Anda di sini untuk menyimpan detail order ke Firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Now"),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField untuk First Name
              TextField(
                decoration: InputDecoration(
                  labelText: "First Name",
                ),
                controller: _firstNameController,
              ),
              // TextField untuk Last Name
              TextField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
                controller: _lastNameController,
              ),
              // TextField untuk Phone Number
              TextField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                ),
                controller: _phoneNumberController,
              ),
              // TextField untuk Email (read-only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                controller: _emailController,
                readOnly: true,
              ),
              // TextField untuk Order Type (read-only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Order Type",
                ),
                controller: _orderTypeController,
                readOnly: true,
              ),
              // TextField untuk Departure Location (read-only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Departure Location",
                ),
                controller: _departureLocationController,
                readOnly: true,
              ),
              // TextField untuk Destination Location (read-only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Destination Location",
                ),
                controller: _destinationLocationController,
                readOnly: true,
              ),
              // TextField untuk Schedule
              TextField(
                decoration: InputDecoration(
                  labelText: "Schedule",
                ),
                controller: _scheduleController,
              ),
              // TextField untuk Number of Passengers
              TextField(
                decoration: InputDecoration(
                  labelText: "Number of Passengers",
                ),
                controller: _passengerController,
                keyboardType: TextInputType.number,
              ),
              // TextField untuk Price (read-only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                controller: _priceController,
                readOnly: true,
              ),
              SizedBox(height: 20),
              // Tombol Submit untuk konfirmasi order
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationPage(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: _phoneNumberController.text,
                        email: _emailController.text,
                        orderType: _orderTypeController.text,
                        departureLocation: _departureLocationController.text,
                        destinationLocation: _destinationLocationController.text,
                        schedule: _scheduleController.text,
                        numberOfPassengers: _passengerController.text,
                        price: _priceController.text,
                      ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      // Perbarui controller dengan hasil dari ConfirmationPage
                      _firstNameController.text = result['firstName'];
                      _lastNameController.text = result['lastName'];
                      _phoneNumberController.text = result['phoneNumber'];
                      _emailController.text = result['email'];
                      _scheduleController.text = result['schedule'];
                      _passengerController.text = result['numberOfPassengers'];
                      _priceController.text = result['price'];
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                ),
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
