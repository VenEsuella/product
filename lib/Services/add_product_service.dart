import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddProductService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('shopping_list');

  Stream<Map<String, String>> getAddProductList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] =
          'Nama Produk\t\t: ${value['name']} \nKode Produk\t\t\t\t: ${value['code']}';
        });
      }
      return items;
    });
  }

  void addProductItem(String nama, code, BuildContext context) {
    if (nama.isEmpty || code.isEmpty) {
      const warning = SnackBar(content: Text("Data yang diinput harus diisi"));
      ScaffoldMessenger.of(context).showSnackBar(warning);
    } else {
      _database.push().set({'name': nama, 'code': code});
    }
  }

  Future<void> removeProductItem(String key) async {
    await _database.child(key).remove();
  }
}