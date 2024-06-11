import 'package:flutter/material.dart';

class PenawaranSpesialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZarsTravel's"),
        backgroundColor: Colors.grey[850],
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Login", style: TextStyle(color: Colors.cyan)),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bali.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bali',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text(
                        '10 Review',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '> 5 Days 6 Nights\n> 2 Person\n> 5 Star Accommodation\n> Transportation\n> Food Facilities',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jelajahi surga tropis ini dengan penawaran eksklusif yang kami persiapkan untuk Anda. Dari liburan romantis hingga petualangan penuh keberanian, Bali menawarkan pengalaman yang tak terlupakan bagi setiap jenis wisatawan. Dengan paket yang dirancang khusus, Anda dapat mengeksplorasi keindahan pantai berpasir putih, menyelami budaya yang kaya, dan menikmati keajaiban alam yang memukau, semua dengan harga istimewa yang tidak akan Anda temukan di tempat lain.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      child: Text("Booking"),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.blue.withOpacity(0.7),
                child: Column(
                  children: [
                    Text(
                      'Special Offer',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '40% OFF',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rp.10Jt',
                      style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Reguler Rp.15Jt',
                      style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ),
            ),
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
                image: AssetImage('banner.jpg'), // Replace with your image URL
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
