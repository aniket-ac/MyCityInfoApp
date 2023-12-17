import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subspace/modules/detail_view_screen.dart';
import 'package:subspace/components/sample_posts.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  List<String> postTitle = ['Post 1', 'Post 2', 'Post 3', 'Post 4'];
  Widget build(BuildContext context) {
    return ListView(
          children: [
            for (var i in postTitle) Posts(title: i),
          ],
        );
  }
}

class Posts extends StatelessWidget {
  const Posts({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5.0,
      child: Row( 
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('images/720s.jpg',height: 50 ,),
          ),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),

              Container(
                width: 260,
                child: Text('Divide the remaining vertical space among the children'
                    'with non-zero flex factors (e.g., those that are Expanded) according'
                    'to their flex factor. For example, a child with a flex factor of 2.0 '
                    'will receive twice the amount of vertical '
                    'space as a child with a flex factor '),
              )
            ],
          )
        ],
      )
    );
  }
}
