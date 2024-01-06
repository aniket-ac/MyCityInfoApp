import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class ActualMap extends StatefulWidget {
  const ActualMap({super.key});

  @override
  State<ActualMap> createState() => _ActualMapState();
}

class _ActualMapState extends State<ActualMap> {
  MapController mapController = MapController();
  TextEditingController searchController = TextEditingController();
  LatLng currentLocation = LatLng(13.16964417467077, -77.5351330402057);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search Location',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchLocation();
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 8.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: currentLocation,
                      child: IgnorePointer(
                        child: CustomPaint(
                            size: Size.fromRadius(20),
                            painter: MarkerPainter()
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  Future<void> searchLocation() async {
    const apiKey = '0dd50748297c4c38aa2027c71bb721b7';
    final searchQuery = searchController.text;

    final response = await http.get(
      Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=$searchQuery&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        final result = data['results'][0];
        final geometry = result['geometry'];
        final lat = geometry['lat'];
        final lng = geometry['lng'];

        setState(() {
          currentLocation = LatLng(lat, lng);
          mapController.move(currentLocation, 13.0);
        });
      } else {
        // Handle no results
        print('No results found');
      }
    } else {
      // Handle API error
      print('Error: ${response.reasonPhrase}');
    }
  }
}


class MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
