import 'package:flutter/material.dart';
import 'package:subspace/components/services/networking.dart';
import 'package:subspace/components/utilities/LocationResponse.dart';

final NetworkHelper networkHelper = NetworkHelper("http://10.0.2.2:8080/v1/get_location_data");

class SearchModule extends StatefulWidget {
  SearchModule({Key? key}) : super(key: key);

  @override
  State<SearchModule> createState() => _SearchModuleState();
}

class _SearchModuleState extends State<SearchModule> {
  final TextEditingController _controller = TextEditingController();
  bool _showWeather = false;
  String cityName = "";

  LocationResponse locationResponse = LocationResponse();

  @override
  void initState() {
    super.initState();
  }

  Future<LocationResponse?> getCityWeather(String cityName) async {
    try {
      var weatherData = await networkHelper.getWeatherData(cityName);
      return weatherData;
    } catch (e) {
      // Handle error (e.g., log it, return a default response, etc.)
      print('Error fetching weather data: $e');
      return null;
    }
  }

  void updateUI(LocationResponse? locationWeather) {
    setState(() {
      if (locationWeather == null) {
        locationResponse.temp = 0;
        locationResponse.weather?.description = 'Unable to fetch the data.';
        locationResponse.weather?.icon = 'Error';
        locationResponse.cityname = '';
      } else {
        locationResponse = locationWeather;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Fetch weather data based on the entered city
                  if (cityName.isNotEmpty) {
                    getCityWeather(cityName).then((locationData) {
                      setState(() {
                        _showWeather = true;
                      });
                      updateUI(locationData);
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  // Clear the search text and hide weather containers
                  _controller.clear();
                  setState(() {
                    _showWeather = false;
                  });
                },
              ),
            ],
          ),
          if (_showWeather)
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey.shade300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weather Stats', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Text('Temperature: ${locationResponse.temp}°C'),
                  Text('Weather Condition: ${locationResponse.weather?.description ?? ''}'),
                  // You can add an icon here based on the weather condition
                  // Example: Icon(Icons.wb_sunny),
                ],
              ),
            ),
          if (_showWeather)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: (locationResponse.newsData ?? []).map((newsItem) {
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(8.0),
                      color: Colors.blue,
                      child: Center(
                        child: Text(newsItem?.title ?? 'No Title'),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
