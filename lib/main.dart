import 'package:flutter/material.dart';

class ExpenseModel {
  String cost;
  int id;
  int price;
  ExpenseModel({required this.id, required this.cost, required this.price});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final costController = TextEditingController();

  final priceController = TextEditingController();

  final idController = TextEditingController();

  final SearchController = TextEditingController();
  List<ExpenseModel> data = [
    ExpenseModel(
      id: 1,
      cost: "water",
      price: 3000,
    ),
  ];

  void updateData() {
    int id = int.parse(idController.text);
    String cost = costController.text;
    int price = int.parse(priceController.text);

    ExpenseModel existingData = data.firstWhere((element) => element.id == id,
        orElse: () => ExpenseModel(id: 0, cost: '', price: 0));

    if (existingData != null) {
      setState(() {
        existingData.cost = cost;
        existingData.price = price;
      });
    } else {
      setState(() {
        data.add(
          ExpenseModel(
            id: id,
            cost: cost,
            price: price,
          ),
        );
      });
    }
  }

  List<ExpenseModel> search(String value) {
    List<ExpenseModel> result = data
        .where(
          (item) => item.cost.toLowerCase().contains(
                value.toLowerCase(),
              ),
        )
        .toList();
    return result;
    //must loop in another class
    // List<ExpenseModel> qwert = search("w");
    // for (int i = 0; i < data.length; i++) {
    //   print("i=${i}");
    //   print("id=${data[i].cost}");
    // }
  }

  void clearData() {
    idController.clear();
    costController.clear();
    priceController.clear();
  }

  void addData() {
    setState(() {
      data.add(
        ExpenseModel(
          id: int.parse(idController.text),
          cost: costController.text,
          price: int.parse(idController.text),
        ),
      );
      idController.clear();
      costController.clear();
      priceController.clear();
    });
  }

  void deleteData(int index) {
    setState(
      () {
        data.removeAt(index);
      },
    );
  }

  int valueTotal() {
    int result = 0;
    for (int i = 0; i < data.length; i++) {
      result += data[i].price;
      //  print(result);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test02"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Enter ID"),
                  controller: idController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Enter cost"),
                  controller: costController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Enter price"),
                  controller: priceController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Search"),
                  controller: SearchController,
                  onChanged: (value) => search,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        addData();
                        //  valueTotal();
                      },
                      child: Text("Add"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        updateData();
                      },
                      child: Text("Update"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        clearData();
                      },
                      child: Text("Clear"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        search(SearchController.text);
                      },
                      child: Text("Search"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                  ],
                ),
                Column(
                  children: List.generate(
                    data.length,
                    (index) => Card(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("cost: ${data[index].id}"),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("cost: ${data[index].cost}"),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("price: ${data[index].price}"),
                                ),
                                //SizedBox(),
                              ],
                            ),
                            Align(
                              // alignment: Alignment.bottomRight,
                              child: IconButton(
                                  onPressed: () {
                                    deleteData(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  )),
                            ),
                            IconButton(
                              onPressed: () {
                                idController.text = data[index].id.toString();
                                costController.text = data[index].cost;
                                priceController.text =
                                    data[index].price.toString();
                              },
                              icon: Icon(Icons.edit),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     clearData();
                            //   },
                            //   icon: Icon(Icons.reset_tv),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Card(
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Total: ${valueTotal()}"),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
