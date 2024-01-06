import 'package:http/http.dart';
import 'package:subspace/components/utilities/LocationResponse.dart';
import 'dart:convert';

import 'location.dart';


class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<LocationResponse> getData(Location location) async {
    var data = {'latitude': location.latitude, 'longitude': location.longitude, 'city_name': null};
    final Map<String, String> headers = {'Content-Type': 'application/json'};
      Response response = await post(Uri.parse(url),
          headers: headers,
          body: jsonEncode(data)
      );
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        print(data);
        return LocationResponse.fromJson(decodeData);
      } else {
        print(response.statusCode);
        throw Exception(response.statusCode);
      }
    }

  Future getWeatherData(String city) async {
    var data = {
      'latitude': null,
      'longitude': null,
      'city_name': city
    };
    final Map<String, String> header = {'Content-type':'application/json'};
    Response response = await post(Uri.parse(url),
      headers: header,
      body: jsonEncode(data)
    );
    if(response.statusCode == 200){
      String data = response.body;
      var decodeData = jsonDecode(data);
      return LocationResponse.fromJson(decodeData);
    }else{
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  }
