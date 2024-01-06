import 'location.dart';
import 'networking.dart';

const apiUrl = "https://10.0.2.2:8080";


class AllServices {
  Future<dynamic> getServices(String cityName) {
    Location location = Location();
    location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(apiUrl);

    var serviceData = networkHelper.getData(location);
    return serviceData;
  }
}


