import 'package:flutter/material.dart';
import 'package:product/Screens/home_screen.dart';
import 'package:product/Services/add_product_service.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final AddProductService _shoppingService = AddProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller1,
                    decoration:
                    const InputDecoration(hintText: 'Masukkan Nama Produk'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Masukkan Kode Produk'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1),
          Padding(
            padding:
            EdgeInsets.only(bottom: 16.0), // Memberikan ruang di bawah FAB
            child: FloatingActionButton(
              onPressed: () {
                _shoppingService.addProductItem(
                    _controller1.text, _controller2.text, context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.purple, // Ubah warna latar belakang FAB
              elevation: 4, // Berikan efek bayangan pada FAB
              splashColor:
              Colors.white, // Ubah warna efek splash saat FAB ditekan
            ),
          ),
        ],
      ),
    );
  }
}