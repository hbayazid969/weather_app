import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            actions: [Icon(Icons.search), Icon(Icons.location_disabled)],
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 73, 73, 73),
            title: Text("Weather App")),
        backgroundColor: Color.fromARGB(255, 85, 84, 84),
        body: weatherMap != null
            ? Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                height: double.infinity,
                color: Color.fromARGB(255, 110, 110, 110),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${Jiffy(DateTime.now()).format("MMM do yy")}, ${Jiffy(DateTime.now()).format("h:mm")}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1),
                                ),
                                Text(
                                  "${weatherMap!["name"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1),
                                ),
                              ],
                            )),
                        Center(
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Color.fromARGB(255, 121, 116, 116),
                            child: CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 68, 67, 67),
                              radius: 110,
                              child: Column(
                                children: [
                                  forecastMap!["list"][0]["weather"][0]
                                              ["description"] ==
                                          "Clear"
                                      ? Image.network(
                                          "https://cdn.pixabay.com/photo/2013/07/13/10/23/sun-157126_640.png",
                                          height: 90,
                                          width: 100,
                                        )
                                      : Image.network(
                                          "https://cdn3d.iconscout.com/3d/premium/thumb/sunny-and-rainy-4167793-3457160.png",
                                          height: 90,
                                          width: 100,
                                        ),
                                  Text(
                                    "${forecastMap!["list"][0]["main"]["temp"]}°",
                                    style: TextStyle(
                                        fontSize: 50, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Feeles like ${forecastMap!["list"][0]["main"]["feels_like"]}°",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                              Text(
                                "${forecastMap!["list"][0]["weather"][0]["description"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 400,
                          color: Color.fromARGB(255, 110, 110, 110),
                          child: Column(
                            children: [
                              Text(
                                "Humidity :${forecastMap!["list"][0]["main"]["humidity"]}, Pressure ${forecastMap!["list"][0]["main"]["pressure"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Sunset ${Jiffy("${DateTime.fromMillisecondsSinceEpoch(weatherMap!["sys"]["sunset"] * 1000)}").format("h:mm:a")}, Sunrise ${Jiffy("${DateTime.fromMillisecondsSinceEpoch(weatherMap!["sys"]["sunrise"] * 1000)}").format("h:mm:a")}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 2,
                          width: 500,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: forecastMap!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Color.fromARGB(255, 85, 84, 84),
                                elevation: 4,
                                child: Container(
                                  width: 160,
                                  margin: EdgeInsets.only(right: 8),
                                  height: double.infinity,
                                  color: Color.fromARGB(255, 110, 110, 110),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${Jiffy(forecastMap!["list"][index]["dt_txt"]).format("EEE, h:mm")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Image.network(
                                          "https://cdn3d.iconscout.com/3d/premium/thumb/sunny-and-rainy-4167793-3457160.png",
                                          height: 70,
                                          width: 71,
                                        ),
                                        Text(
                                          "${forecastMap!["list"][index]["main"]["temp_min"]}/${forecastMap!["list"][index]["main"]["temp_max"]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${forecastMap!["list"][index]["weather"][0]["description"]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              letterSpacing: 1),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        )
                      ]),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    fetchWeatherData();

    print("Out latitude is $latitude and longitude is $longitude");
  }

  fetchWeatherData() async {
    var weatherResponce = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude=hourly%2Cdaily&appid=cc93193086a048993d938d8583ede38a&fbclid=IwAR1rg9BHqDzqxJia8bplKeuzaNLUVMWNCsfmGjp1-IHI0hpsrGe7Hnq5FMI"));
    var forecastResponce = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=cc93193086a048993d938d8583ede38a&fbclid=IwAR3Hr9_sSo-ju9Us4-W-MpsVaeQyp10SZvo84iTiJ7WjrqTNSkbxRURH5RQ"));
    setState(() {
      weatherMap = Map<String, dynamic>.from(jsonDecode(weatherResponce.body));
      forecastMap =
          Map<String, dynamic>.from(jsonDecode(forecastResponce.body));
    });
    print("ssssssssssssssssssssss${weatherResponce.body}");
  }

  Map<String, dynamic>? weatherMap;
  Map<String, dynamic>? forecastMap;

  late Position position;
  double? latitude, longitude;
}
