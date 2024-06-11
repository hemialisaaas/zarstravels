import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DestinasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZarsTravel's"),
        backgroundColor: Colors.grey[850],
        actions: [
          // StreamBuilder digunakan untuk memantau perubahan status autentikasi pengguna
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                if (user == null) {
                  // Jika tidak ada pengguna yang login, tampilkan tombol "Login"
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
      // Drawer navigasi yang memuat menu untuk mengakses berbagai halaman dalam aplikasi
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul halaman "Destinasi Favorit"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Destinasi Favorit',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Deskripsi singkat tentang halaman destinasi favorit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selamat datang di halaman Destinasi Favorit kami! Temukan pesona dan keindahan dari destinasi-destinasi pilihan kami yang menakjubkan. Dari panorama alam yang memikat hingga warisan budaya yang kaya, kami hadirkan rangkuman destinasi unggulan yang pasti memukau hati dan jiwa Anda. Siapkan koper Anda untuk petualangan tak terlupakan bersama kami!',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // GridView untuk menampilkan kartu destinasi dalam bentuk grid
            GridView.count(
              crossAxisCount: 2, // Jumlah kolom dalam grid
              crossAxisSpacing: 10, // Jarak horizontal antar kolom
              mainAxisSpacing: 10, // Jarak vertikal antar baris
              shrinkWrap: true, // Mengatur agar GridView menyesuaikan ukurannya dengan konten
              physics: NeverScrollableScrollPhysics(), // Nonaktifkan scroll pada GridView
              children: <Widget>[
                // Memanggil fungsi buildDestinationCard untuk setiap destinasi
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

  // Fungsi untuk membangun kartu destinasi
  Widget buildDestinationCard(String title, String subtitle, String imageUrl) {
    return Card(
      child: Column(
        children: <Widget>[
          // Menampilkan gambar destinasi
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // Menampilkan judul dan subtitle destinasi
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
              Navigator.of(ctx).pop(); // Menutup dialog
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Logout dari Firebase
              Navigator.of(ctx).pop(); // Menutup dialog
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
          // Header drawer dengan gambar dan judul aplikasi
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/banner.jpg'), // Ganti dengan URL gambar Anda
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
          // Menu navigasi untuk Home
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          // Menu navigasi untuk Destinasi
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Destinasi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/destinasi');
            },
          ),
          // Menu navigasi untuk Paket
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Paket'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/paket');
            },
          ),
          // Menu navigasi untuk Penawaran Spesial
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Penawaran Spesial'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/penawaran-spesial');
            },
          ),
          // Menu navigasi untuk Blog
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Blog'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/blog');
            },
          ),
          // Menu navigasi untuk Tentang Kami
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
