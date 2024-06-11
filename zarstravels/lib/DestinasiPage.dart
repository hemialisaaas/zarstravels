import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//destinasipage
class DestinasiPage extends StatelessWidget {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Destinasi Favorit',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selamat datang di halaman Destinasi Favorit kami! Temukan pesona dan keindahan dari destinasi-destinasi pilihan kami yang menakjubkan. Dari panorama alam yang memikat hingga warisan budaya yang kaya, kami hadirkan rangkuman destinasi unggulan yang pasti memukau hati dan jiwa Anda. Siapkan koper Anda untuk petualangan tak terlupakan bersama kami!',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                buildDestinationCard('Jakarta', '20 Tours\n15 Places', 'assets/jakarta.jpg'),
                buildDestinationCard('Bandung', '12 Tours\n9 Places', 'assets/bandung.jpg'),
                buildDestinationCard('Medan', '18 Tours\n9 Places', 'assets/medan.jpg'),
                buildDestinationCard('Yogyakarta', '14 Tours\n12 Places', 'assets/jogja.jpg'),
                buildDestinationCard('Makassar', '25 Tours\n10 Places', 'assets/makassar.jpg'),
                buildDestinationCard('Bali', '14 Tours\n6 Places', 'assets/bali.jpg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDestinationCard(String title, String subtitle, String imageUrl) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//ShowLogoutDialog
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
