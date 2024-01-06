import 'package:subspace/components/services/location.dart';
import 'package:subspace/components/services/networking.dart';
import 'package:subspace/components/utilities/LocationResponse.dart';

final NetworkHelper networkHelper = NetworkHelper("http://10.0.2.2:8080/v1/get_location_data");

Future<LocationResponse?> fetchData() async {
  Location location = Location();

  try {
    await location.getCurrentLocation();
    return networkHelper.getData(location);
  } catch (e) {
    // Handle error (e.g., log it, return a default response, etc.)
    print('Error fetching location data: $e');
    return null;
  }
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
