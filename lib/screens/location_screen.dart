import 'package:climate_app/screens/city_screen.dart';
import 'package:climate_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';
import 'package:climate_app/services/weather.dart';

class LocationScreen extends StatefulWidget {

  final weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  late int temperature;
  late int condition;
  late String cityName;

  WeatherModel weatherModel=WeatherModel();

  @override
  void initState() {
    super.initState();
    upDateUi(widget.weatherData);
  }

  void upDateUi(dynamic weatherData){
    try{
      double temp=weatherData['data'][0]['temp']; //data[0].temp
      temperature=temp.toInt();
      condition=weatherData['data'][0]['weather']['code'];//data[0].weather.code
      cityName=weatherData['data'][0]['city_name'];} //data[0].city_name

    catch(e){
      print(e);
      temperature=22;
      condition=801;
      cityName='Gwalior';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        }));
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weatherModel.getWeatherIcon(condition) }',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temperature)} in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
