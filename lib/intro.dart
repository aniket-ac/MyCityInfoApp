
import 'package:flutter/material.dart';
import 'package:subspace/modules/list_view_screen.dart';
import 'package:subspace/modules/map_module.dart';
import 'package:subspace/modules/search_module.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: 'first',
          child: Material(
            child: InkWell(
              child: Image.asset('images/start.jpg',fit: BoxFit.contain,),
              onTap: (){
                Navigator.pushNamed(context, '#');
              },
            ),
          )
      )
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
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const ListViewScreen(),
    const MapModule(),
    SearchModule()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
