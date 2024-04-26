import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product/Screens/add_product_screen.dart';
import 'package:product/Services/add_product_service.dart';


class HomeScreen extends StatelessWidget {
  final AddProductService _addProductService = AddProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: <Widget>[
          const SizedBox(height: 1),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductScreen()),
                  );
                },
                backgroundColor: Colors.deepPurple,
                elevation: 4,
                splashColor:
                Colors.white,
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Map<String, String>>(
              stream: _addProductService.getAddProductList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, String> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _addProductService.removeProductItem(key);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}