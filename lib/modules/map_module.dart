import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:subspace/components/maps.dart';

class MapModule extends StatefulWidget {
  const MapModule({super.key});

  @override
  State<MapModule> createState() => _MapModuleState();
}

class _MapModuleState extends State<MapModule> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Container(
        child: ActualMap(),
      ),
    );
  }
}
