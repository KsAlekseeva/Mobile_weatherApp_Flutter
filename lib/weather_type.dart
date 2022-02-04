import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherTypePage extends StatefulWidget {
  const WeatherTypePage({Key key}) : super(key: key);

  @override
  _WeatherTypePageState createState() => _WeatherTypePageState();
}

class _WeatherTypePageState extends State<WeatherTypePage> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

getIcon(String type){
  log(type);
  switch(type){
    case 'Rain':
      return "pictures/10d.png";
    case 'Thunderstorm':
      return "pictures/11d.png";
    case 'Drizzle':
      return "pictures/09d.png";
    case 'Clear':
      return "pictures/01d.png";
    case 'Clouds':
      return "pictures/03d.png";
    case 'Snow':
      return "pictures/13.png";
  }
}