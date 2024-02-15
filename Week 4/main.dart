// Ramita Deeprom 6488018
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '6488018 Meow Meow Listing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffb74093)),
        primarySwatch: Colors.amber,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Meow Meow Listing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: const [
                ProductBox(
                  'A random cute kitty going out', '-`♡´-✧˖°.☾', 'Paid by cuteness only',
                  'meow.jpg'),
                ProductBox(
                  'A random cute kitty going to school', 'ᓚᘏᗢ✮⋆˙✮ ⋆ ⭒˚｡⋆', 'Paid by cuteness only',
                  'meoow.jpg'),
                ProductBox(
                  'A random cute kitty staring at you', '✩°｡⋆⸜(˙꒳​˙ )', 'Paid by cuteness only',
                  'meooow.jpg'),
                ProductBox(
                  'A random kitty wanna cute you', 'ฅ^•ﻌ•^ฅ', 'Paid by cuteness only',
                  'meoooow.jpg')
            ],
          ),
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;
  const ProductBox(this.name, this.description, this.price, this.image,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("assets/appimages/$image"),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(description),
                          Text("Price: ${price.toString()}"),
                        ],
                      )))
            ])));
  }
}
