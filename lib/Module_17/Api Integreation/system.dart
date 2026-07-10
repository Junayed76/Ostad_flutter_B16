import 'api_services.dart';
import 'package:flutter/material.dart';
import 'model.dart';

void main() {
  runApp(MaterialApp(home: DataImporter(), debugShowCheckedModeBanner: false));
}

class DataImporter extends StatefulWidget {
  const DataImporter({super.key});

  @override
  State<DataImporter> createState() => _DataImporterState();
}

class _DataImporterState extends State<DataImporter> {


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await apiService.fetchData();
    setState(() {
       datas = data!;
    });
  }

  List<model> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Importer'), centerTitle: true),
      body: Column(
        children: [datas.isEmpty ? Text('Failed') : Text('DataLoaded')],
      ),
    );
  }
}
