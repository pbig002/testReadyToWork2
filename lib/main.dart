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
  List<ExpenseModel> allData = [
    ExpenseModel(
      id: 1,
      cost: "water",
      price: 3000,
    ),
  ];
  //for  show data when search
  List<ExpenseModel> foundData = [];
  @override
  void initState() {
    // TODO: implement initState
    foundData = allData;
    super.initState();
  }

  void updateData() {
    int id = int.parse(idController.text);
    String cost = costController.text;
    int price = int.parse(priceController.text);

    ExpenseModel existingData = allData.firstWhere(
        (element) => element.id == id,
        orElse: () => ExpenseModel(id: 0, cost: '', price: 0));

    if (existingData != null) {
      setState(() {
        existingData.cost = cost;
        existingData.price = price;
      });
    } else {
      setState(() {
        allData.add(
          ExpenseModel(
            id: id,
            cost: cost,
            price: price,
          ),
        );
      });
    }
  }

  void search(String value) {
    List<ExpenseModel> result = [];
    if (value.isEmpty) {
      result = allData;
    } else {
      result = allData
          .where(
              (item) => item.cost.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      foundData = result;
    });
  }

  void clearData() {
    idController.clear();
    costController.clear();
    priceController.clear();
  }

  void addData() {
    setState(() {
      allData.add(
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
        allData.removeAt(index);
      },
    );
  }

  void handleAddData(String idText, String cost, String priceText) {
    int? id = int.tryParse(idText);
    int? price = int.tryParse(priceText);

    if (id == null || cost.isEmpty || price == null) {
      print("data is null ");
    } else {
      addData();
    }
  }

  int valueTotal() {
    int result = 0;
    for (int i = 0; i < foundData.length; i++) {
      result += foundData[i].price;
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
                  onChanged: (value) => search(SearchController.text),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        handleAddData(idController.text, costController.text,
                            priceController.text);
                      },
                      child: Text("Add"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        updateData();
                      },
                      style: ButtonStyle(backgroundColor: null),
                      child: const Text("Update"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        clearData();
                      },
                      child: Text("Clear"),
                      style: ButtonStyle(backgroundColor: null),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //search for click
                    // TextButton(
                    //   onPressed: () {
                    //     search(SearchController.text);
                    //   },
                    //   child: Text("Search"),
                    //   style: ButtonStyle(backgroundColor: null),
                    // ),
                  ],
                ),
                Column(
                  children: List.generate(
                    foundData.length,
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
                                  child: Text("cost: ${foundData[index].id}"),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("cost: ${foundData[index].cost}"),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text("price: ${foundData[index].price}"),
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
                                idController.text =
                                    foundData[index].id.toString();
                                costController.text = foundData[index].cost;
                                priceController.text =
                                    foundData[index].price.toString();
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
