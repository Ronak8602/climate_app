import 'dart:convert';

import 'location_screen.dart';
import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network('https://api.weatherbit.io/v2.0/current?lat=${location.latitude}&lon=${location.longitude}&key=$weatherBitApiKey');

    var data = await network.getData();
    var weatherData = jsonDecode(data);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
        ),
      ),
    );
  }
}
