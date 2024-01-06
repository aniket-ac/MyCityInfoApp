import 'package:flutter/material.dart';
import 'package:subspace/components/utilities/LocationResponse.dart';
import 'package:subspace/components/utilities/responses.dart';
import 'package:subspace/modules/detail_view_screen.dart';
import 'package:subspace/modules/list_view_screen.dart';



class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationResponse?>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          LocationResponse? data = snapshot.data;
          List<NewsDatum>? newsData = data?.newsData?.cast<NewsDatum>();

          // Display the fetched data in your UI.
          return ListView.builder(
            itemCount: newsData?.length ?? 0,
            itemBuilder: (context, index) {
              NewsDatum currentNews = newsData![index];

              return Posts(newsDatum: currentNews);
            },
          );
        }
      },
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({Key? key, required this.newsDatum}) : super(key: key);

  final NewsDatum newsDatum;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailedScreen(
              title: newsDatum.title??'',
              content: newsDatum.content??'',
              imageUrl: newsDatum.urlToImage??'https://www.google.com/images/branding/googlelogo/1x/googlelogo_light_color_272x92dp.png ',))
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5.0,
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                  '${newsDatum.urlToImage ?? 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_light_color_272x92dp.png'}',
                width: 100,
              )
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: Text(
                newsDatum.title ?? '',
                textAlign: TextAlign.justify,
                textWidthBasis: TextWidthBasis.longestLine,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
