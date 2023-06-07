import 'package:flutter/material.dart';

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

  void showCost() {
    var showCost = costController;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("qwerty"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("cost"),
              ),
              TextField(
                controller: costController,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("price"),
              ),
              TextField(
                controller: priceController,
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  print("object");
                },
                child: Text("Add"),
                style: ButtonStyle(backgroundColor: null),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("cost: ${costController}"),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("price: ${priceController}"),
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                    ),
                  ],
                ),
                color: Colors.amber,
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Card(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("qwerty"),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("qwerty1"),
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
    );
  }
}
