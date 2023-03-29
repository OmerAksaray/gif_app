import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? content = 'happy';
  String? key = 'AIzaSyBtWEf3FRNgr-MHZob6GkNmowsxL1omQf0';
  List<String>? gifler = [];
  String? forText;
  Future<void> getGif() async {
    Response gif = await http.get(Uri.parse(
        'https://tenor.googleapis.com/v2/search?q=$content&key=$key&client_key=my_test_app&limit=8'));

    if (gif.statusCode == 200) {
      Map gelenJson = jsonDecode(gif.body);
      gifler!.clear();
      for (int i = 0; i < 8; i++) {
        print(i);
        gifler!.add(gelenJson['results'][i]['media_formats']['tinygif']['url']);
      }
    } else {
      forText = 'Bağlantıda bir sorun oluştu!!!!!!';
    }

    setState(() {});
  }

  void initState() {
    super.initState();
    getGif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIF APP!'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                content = value;
                print(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.gif_box),
                hintText: 'Type a gif content!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: getGif,
              child: Text('Get Gif!'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                onSurface: Colors.grey,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < gifler!.length; i++)
                gifImage(gifler: gifler, order: gifler![i]),
            ],
          ),
        ],
      ),
    );
  }
}

class gifImage extends StatelessWidget {
  final String order;
  const gifImage({
    super.key,
    required this.gifler,
    required this.order,
  });

  final List<String>? gifler;

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      image: NetworkImage(
        order,
      ),
    );
  }
}
