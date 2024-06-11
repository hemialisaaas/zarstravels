import 'package:flutter/material.dart';
import 'DestinasiPage.dart';
import 'PaketPage.dart';
import 'PenawaranSpesialPage.dart';
import 'BlogPage.dart';
import 'autentikasi.dart';
import 'order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/destinasi': (context) => DestinasiPage(),
        '/paket': (context) => PaketPage(),
        '/penawaran-spesial': (context) => PenawaranSpesialPage(),
        '/blog': (context) => BlogPage(),
        '/auth': (context) => AuthPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZarsTravel's"),
        backgroundColor: Colors.grey[850],
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                if (user == null) {
                  return TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth');
                    },
                    child: Text("Login", style: TextStyle(color: Colors.cyan)),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: Text(user.email ?? '', style: TextStyle(color: Colors.white)),
                    ),
                  );
                }
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    'Jelajahi Dunia bersama Dedelru.',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: Text("Pesan Sekarang"),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SearchWidget(),
            SizedBox(height: 20),
            ServiceDescriptions(),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _dateController = TextEditingController();
  String? selectedDepartureLocation;
  String? selectedArrivalLocation;
  String? selectedPassengerCount;

  final List<String> locations = [
    'Jakarta',
    'Bandung',
    'Depok',
    'Bekasi',
    'Karawang',
    'Tangerang'
  ];

  final List<String> passengerCounts = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ChoiceChip(
              label: Text("Travel Bus"),
              selected: true,
              onSelected: (bool selected) {},
            ),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Pilih Lokasi Keberangkatan",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            value: selectedDepartureLocation,
            onChanged: (String? newValue) {
              setState(() {
                selectedDepartureLocation = newValue;
              });
            },
            items: locations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Pilih Lokasi Tujuan",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            value: selectedArrivalLocation,
            onChanged: (String? newValue) {
              setState(() {
                selectedArrivalLocation = newValue;
              });
            },
            items: locations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Jadwal",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  _dateController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                });
              }
            },
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Jumlah Penumpang",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            value: selectedPassengerCount,
            onChanged: (String? newValue) {
              setState(() {
                selectedPassengerCount = newValue;
              });
            },
            items: passengerCounts.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(
                        firstName: '', // Fill with the actual value
                        lastName: '', // Fill with the actual value
                        phoneNumber: '', // Fill with the actual value
                        email: user.email ?? '', // Fill with the actual value from Firebase
                        orderType: 'Travel Bus', // Fixed value
                        departureLocation: selectedDepartureLocation ?? '',
                        destinationLocation: selectedArrivalLocation ?? '',
                        schedule: _dateController.text,
                        numberOfPassengers: selectedPassengerCount ?? '1',
                        price: '200000', // Fixed value for each passenger
                      ),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, '/auth');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              child: Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDescriptions extends StatelessWidget {
  final List<ServiceDescription> services = [
    ServiceDescription('assets/24.jpeg', '24 Hours Service'),
    ServiceDescription('assets/ac.jpeg', 'Air Conditioner'),
    ServiceDescription('assets/charger.jpeg', 'Free Charging'),
    ServiceDescription('assets/drink.jpeg', 'Free Mineral Water'),
    ServiceDescription('assets/neck.jpeg', 'Neck Pillow'),
    ServiceDescription('assets/storage.jpeg', 'Extensive Storage'),
    ServiceDescription('assets/seat.jpeg', 'Comfortable Seat'),
    ServiceDescription('assets/tv.jpeg', 'LED TV'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columnCount = (constraints.maxWidth > 600) ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: (constraints.maxWidth > 600) ? 2 : 3,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return ServiceDescriptionCard(
              image: services[index].image,
              title: services[index].title,
            );
          },
        );
      },
    );
  }
}

class ServiceDescription {
  final String image;
  final String title;

  ServiceDescription(this.image, this.title);
}

class ServiceDescriptionCard extends StatelessWidget {
  final String image;
  final String title;

  ServiceDescriptionCard({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(image, width: 40, height: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/banner.jpg'), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'ZarsTravel\'s',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Destinasi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/destinasi');
            },
          ),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Paket'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/paket');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Penawaran Spesial'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/penawaran-spesial');
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Blog'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/blog');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Tentang Kami'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tentang-kami');
            },
          ),
        ],
      ),
    );
  }
}
