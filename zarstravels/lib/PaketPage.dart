import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'order.dart'; // Import OrderPage untuk navigasi ke halaman pemesanan


// Kelas PaketPage yang menampilkan daftar paket perjalanan
class PaketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ZarsTravel's"),
        backgroundColor: Colors.grey[850],
        actions: [
          // StreamBuilder untuk memantau perubahan status autentikasi pengguna
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                if (user == null) {
                  // Jika pengguna belum login, tampilkan tombol "Login"
                  return TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth');
                    },
                    child: Text("Login", style: TextStyle(color: Colors.cyan)),
                  );
                } else {
                  // Jika pengguna sudah login, tampilkan email pengguna dengan opsi logout
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: Text(user.email ?? '', style: TextStyle(color: Colors.white)),
                    ),
                  );
                }
              }
              // Tampilkan indikator loading saat menunggu status autentikasi
              return CircularProgressIndicator();
            },
          )
        ],
      ),
      // Drawer navigasi untuk akses ke berbagai halaman dalam aplikasi
      drawer: AppDrawer(),
      // LayoutBuilder untuk menyesuaikan tampilan berdasarkan ukuran layar
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Tampilan untuk layar kecil (misalnya, ponsel)
          if (constraints.maxWidth < 600) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul halaman "Paket Spesial Kami"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Paket Spesial Kami',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Deskripsi singkat tentang paket spesial
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Nikmati pengalaman tak terlupakan dengan paket spesial dari ZarsTravel. Jelajahi destinasi eksotis, rasakan keindahan alam yang menakjubkan, dan ciptakan kenangan abadi bersama kami.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  // ListView untuk menampilkan paket dalam bentuk daftar
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildPackageCard(context, 'Surabaya - Malang', '300.000', 'assets/S-M.png', 'Surabaya', 'Malang'),
                      buildPackageCard(context, 'Malang - Yogyakarta', '199.000', 'assets/M-Y.png', 'Malang', 'Yogyakarta'),
                      buildPackageCard(context, 'Yogyakarta - Surabaya', '399.000', 'assets/Y-S.png', 'Yogyakarta', 'Surabaya'),
                      buildPackageCard(context, 'Bandung - Surabaya', '899.000', 'assets/B-S.png', 'Bandung', 'Surabaya'),
                      buildPackageCard(context, 'Jakarta - Yogyakarta', '599.000', 'assets/J-Y.png', 'Jakarta', 'Yogyakarta'),
                      buildPackageCard(context, 'Bandung - Yogyakarta', '499.000', 'assets/B-Y.png', 'Bandung', 'Yogyakarta'),
                    ],
                  ),
                ],
              ),
            );
          } else {
            // Tampilan untuk layar besar (misalnya, tablet atau desktop)
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul halaman "Paket Spesial Kami"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Paket Spesial Kami',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Deskripsi singkat tentang paket spesial
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Nikmati pengalaman tak terlupakan dengan paket spesial dari ZarsTravel. Jelajahi destinasi eksotis, rasakan keindahan alam yang menakjubkan, dan ciptakan kenangan abadi bersama kami.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  // GridView untuk menampilkan paket dalam bentuk grid
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildPackageCard(context, 'Surabaya - Malang', '300.000', 'assets/S-M.png', 'Surabaya', 'Malang'),
                      buildPackageCard(context, 'Malang - Yogyakarta', '199.000', 'assets/M-Y.png', 'Malang', 'Yogyakarta'),
                      buildPackageCard(context, 'Yogyakarta - Surabaya', '399.000', 'assets/Y-S.png', 'Yogyakarta', 'Surabaya'),
                      buildPackageCard(context, 'Bandung - Surabaya', '899.000', 'assets/B-S.png', 'Bandung', 'Surabaya'),
                      buildPackageCard(context, 'Jakarta - Yogyakarta', '599.000', 'assets/J-Y.png', 'Jakarta', 'Yogyakarta'),
                      buildPackageCard(context, 'Bandung - Yogyakarta', '499.000', 'assets/B-Y.png', 'Bandung', 'Yogyakarta'),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Fungsi untuk membangun kartu paket perjalanan
  Widget buildPackageCard(BuildContext context, String title, String price, String imageUrl, String departureLocation, String destinationLocation) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Menampilkan gambar paket perjalanan
          Container(
            height: 150,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // Menampilkan informasi paket perjalanan
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 5),
                // Menampilkan detail paket
                Text(
                  '> 3 Hari 2 Malam\n> Bintang 4\n> Travel Antar Kota\n> Fasilitas Makan',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 5),
                // Menampilkan rating paket
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star_half, color: Colors.yellow),
                    SizedBox(width: 5),
                    Text(
                      '1521 Ulasan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Tombol untuk memesan paket
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        Navigator.pushNamed(context, '/auth'); // Jika belum login, arahkan ke halaman login
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(
                              firstName: '',
                              lastName: '',
                              phoneNumber: '',
                              email: user.email ?? '',
                              orderType: title,
                              departureLocation: departureLocation,
                              destinationLocation: destinationLocation,
                              schedule: '',
                              numberOfPassengers: '1',
                              price: price.replaceAll('.', ''), // Menghapus titik dari harga
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: Text("Book Now"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog logout
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

// Kelas AppDrawer untuk menampilkan drawer navigasi
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header drawer dengan gambar dan judul
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/banner.jpg'),
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
          // Daftar menu dalam drawer
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
