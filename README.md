# Aplikasi Pemesanan ZarsTravel

Aplikasi Pemesanan ZarsTravel adalah aplikasi seluler yang dibangun menggunakan Flutter yang memungkinkan pengguna untuk memesan paket perjalanan, masuk, dan mendaftar menggunakan Otentikasi Firebase.

## Fitur

- **Masuk dan Pendaftaran:** Pengguna dapat mendaftar dan masuk menggunakan email dan kata sandi mereka.
- **Pemesanan:** Pengguna dapat mengisi detail pemesanan mereka dan melihat harga total yang dihitung berdasarkan jumlah penumpang.
- **Penawaran Khusus:** Pengguna dapat melihat penawaran perjalanan khusus dengan deskripsi rinci.

## Memulai

### Prasyarat

- Flutter SDK: [Instal Flutter](https://flutter.dev/docs/get-started/install)
- Akun Firebase: [Buat Proyek Firebase](https://firebase.google.com/)

### Instalasi

1. **Kloning repositori:**
    ```bash
    git clone https://github.com/username/zarstravel-booking-app.git
    cd zarstravel-booking-app
    ```

2. **Instal dependensi:**
    ```bash
    flutter pub get
    ```

3. **Menyiapkan Firebase:**
   - Buka [Firebase Console](https://console.firebase.google.com/).
   - Buat proyek baru.
   - Tambahkan aplikasi Android dan unduh file `google-services.json`.
   - Letakkan file `google-services.json` di direktori `android/app`.
   - Tambahkan aplikasi iOS dan unduh file `GoogleService-Info.plist`.
   - Letakkan file `GoogleService-Info.plist` di direktori `ios/Runner`.
   - Ikuti instruksi di Firebase Console untuk menambahkan Firebase ke proyek Flutter Anda.

4. **Menjalankan aplikasi:**
    ```bash
    flutter run
    ```

## Penggunaan

- **Masuk/Pendaftaran:**
  - Buka aplikasi dan navigasikan ke tab masuk atau pendaftaran.
  - Masukkan email dan kata sandi Anda untuk masuk atau membuat akun baru.

- **Pemesanan:**
  - Setelah masuk, navigasikan ke halaman pemesanan.
  - Isi formulir pemesanan dengan detail yang diperlukan.
  - Kirim formulir untuk melihat halaman konfirmasi.

- **Penawaran Khusus:**
  - Lihat penawaran perjalanan khusus dengan deskripsi dan harga yang terperinci.



