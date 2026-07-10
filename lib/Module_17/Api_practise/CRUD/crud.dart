import 'package:flutter/material.dart';
import 'controler/product_controler.dart';


class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {

  final ProductController productController = ProductController();

  Future<void> fetchData() async {
    await productController.getProducts();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD App"),
      ),
      body: Center(
        child: Text(productController.products.length.toString(),),
      ),
    );
  }
}