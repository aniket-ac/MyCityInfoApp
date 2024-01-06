import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  DetailedScreen({super.key ,required this.title, required this.content, required this.imageUrl}) {
    // TODO: implement DetailedScreen
  }

  final String title,content,imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            padding: const EdgeInsets.all(21),
            children: [
              Card(
                margin: const EdgeInsets.all(10.0),
                child: Image.network('${imageUrl}',fit: BoxFit.contain,width: 500,),
              ),
              Text(
                content,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.visible,
              )
            ],
          )
        ),
      ),
    );
  }
}
