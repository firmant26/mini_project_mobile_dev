import 'package:flutter/material.dart';

// Model untuk merepresentasikan setiap item menu
class MenuItem {
  String name;
  int price;
  int quantity;

  MenuItem({required this.name, required this.price, this.quantity = 0});
}

// Widget utama aplikasi
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Daftar untuk menyimpan data makanan
  final List<MenuItem> makanan = [
    MenuItem(name: 'Makanan 1', price: 5000, quantity: 3),
    MenuItem(name: 'Makanan 2', price: 5000, quantity: 2),
    MenuItem(name: 'Makanan 3', price: 5000),
    MenuItem(name: 'Makanan 4', price: 5000), // Duplikat sengaja untuk contoh
    MenuItem(name: 'Makanan 5', price: 5000),
  ];

  // Daftar untuk menyimpan data minuman
  final List<MenuItem> minuman = [
    MenuItem(name: 'Minuman 1', price: 7000),
    MenuItem(name: 'Minuman 2', price: 7000),
    MenuItem(name: 'Minuman 3', price: 7000, quantity: 2),
    MenuItem(name: 'Minuman 4', price: 7000, quantity: 2),
    MenuItem(name: 'Minuman 5', price: 7000),
  ];

  // Fungsi untuk mereset semua jumlah pesanan
  void _resetQuantities() {
    setState(() {
      for (var item in makanan) {
        item.quantity = 0;
      }
      for (var item in minuman) {
        item.quantity = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MENUS', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Judul kategori Makanan
          const Text(
            'Makanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          // Daftar item makanan
          ...makanan.map((item) => _buildMenuItemCard(item)).toList(),
          const SizedBox(height: 20),

          // Judul kategori Minuman
          const Text(
            'Minuman',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          // Daftar item minuman
          ...minuman.map((item) => _buildMenuItemCard(item)).toList(),
        ],
      ),
      // Bagian bawah layar untuk navigasi halaman dan tombol aksi
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaginationControls(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika untuk tombol Transaction
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Transaction'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetQuantities,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  // Widget untuk membuat satu baris item menu
  Widget _buildMenuItemCard(MenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Tampilan jumlah item
          Container(
            width: 40,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 15),

          // Nama dan harga item
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text('Rp. ${item.price}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),

          // Tombol kurang dan tambah
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () {
                    setState(() {
                      if (item.quantity > 0) {
                        item.quantity--;
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () {
                    setState(() {
                      item.quantity++;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk kontrol paginasi (halaman)
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: () {}, child: const Text('← Previous')),
        // Tombol halaman
        SizedBox(
          width: 40,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('1'),
          ),
        ),
        SizedBox(width: 40, child: TextButton(onPressed: () {}, child: const Text('2'))),
        const Text('...'),
        SizedBox(width: 40, child: TextButton(onPressed: () {}, child: const Text('4'))),
        TextButton(onPressed: () {}, child: const Text('Next →')),
      ],
    );
  }
}

// Fungsi main untuk menjalankan aplikasi
void main() {
  runApp(const MaterialApp(
    home: MenuScreen(),
    debugShowCheckedModeBanner: false,
  ));
}