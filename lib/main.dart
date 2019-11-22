import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(Pixabay());
class Pixabay extends StatefulWidget {
  @override
  _PixabayState createState() => _PixabayState();
}
class _PixabayState extends State<Pixabay> {
  Map images;
  List imgList;
  Future getImage() async {
    http.Response response = await http.get('https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true');
    images = json.decode(response.body);
    setState(() {
     imgList = images['hits']; 
    });
  }
  @override
  void initState() {
    super.initState();
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(  
        appBar: AppBar(  
          title: Text("Pixabay"),
          centerTitle: true,
        ),
        body: ListView.builder(  
          itemCount: imgList != null ? imgList.length :0,
          itemBuilder: (context , i) {
            return Card(
              child: Column( 
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(imgList[i]['largeImageURL']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(imgList[i]['userImageURL']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${imgList[i]['tags']}"),
                        ),
                      ],
                    ),
                  ),
                ],
               ),
            );
          },
        ),
      ),
    );
  }
}