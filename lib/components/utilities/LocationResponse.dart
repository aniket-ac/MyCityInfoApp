class NewsDatum {
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  NewsDatum({this.title, this.description, this.url, this.urlToImage, this.content});

  NewsDatum.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['content'] = content;
    return data;
  }
}

class LocationResponse {
  String? cityname;
  Weather? weather;
  int? temp;
  List<NewsDatum?>? newsData;

  LocationResponse({this.cityname, this.weather, this.temp, this.newsData});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    cityname = json['city_name'];
    weather = json['weather'] != null ? Weather?.fromJson(json['weather']) : null;
    temp = json['temp'];
    if (json['newsData'] != null) {
      newsData = <NewsDatum>[];
      json['newsData'].forEach((v) {
        newsData!.add(NewsDatum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_name'] = cityname;
    data['weather'] = weather!.toJson();
    data['temp'] = temp;
    data['newsData'] =newsData != null ? newsData!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Weather {
  String? icon;
  int? code;
  String? description;

  Weather({this.icon, this.code, this.description});

  Weather.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['code'] = code;
    data['description'] = description;
    return data;
  }
}

