import 'api_services.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'post_details_screen.dart';

void main() {
  runApp(MaterialApp(home: DataImporter(), debugShowCheckedModeBanner: false));
}

class DataImporter extends StatefulWidget {
  const DataImporter({super.key});

  @override
  State<DataImporter> createState() => _DataImporterState();
}

class _DataImporterState extends State<DataImporter> {
  TextEditingController inputProductName = TextEditingController();
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputImg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Importer'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                print(snapshot.data);
                print(snapshot.error);

                if (!snapshot.hasData) {
                  return const Text("No Data");
                }

                final productData = snapshot.data!;

                return ListView.builder(
                  itemCount: productData.length,
                  itemBuilder: (_, index) {
                    final data = productData[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PostDetailsScreen(PostId: data.productName,),
                        ),
                      ),

                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            data.img,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(Icons.broken_image),
                              );
                            },
                          ),
                          title: Text(data.productName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                data.price.toString(),
                                style: TextStyle(color: Colors.green),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  bool success = await ApiService.deleteData(
                                    data.id,
                                  );
                                  if (success) {
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('New Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: inputImg,
                        decoration: InputDecoration(hintText: 'Paste Img src'),
                      ),
                      TextFormField(
                        controller: inputProductName,
                        decoration: InputDecoration(hintText: 'Product Name'),
                      ),
                      TextFormField(
                        controller: inputPrice,
                        decoration: InputDecoration(hintText: 'Product Price'),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        model newProduct = model(
                          id: '',
                          productName: inputProductName.text,
                          img: inputImg.text,
                          price: int.parse(inputPrice.text),
                        );

                        bool dataLoaded = await ApiService.createData(
                          newProduct,
                        );
                        if (dataLoaded) {
                          Navigator.pop(context);
                          inputPrice.clear();
                          inputImg.clear();
                          inputProductName.clear();
                          setState(() {});
                        }
                      },
                      child: Text('SAVE'),
                    ),
                  ],
                ),
              );
            },

            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
