import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report/WeatherBloc.dart';
import 'package:weather_report/WeatherRepo.dart';
import 'package:weather_report/WeatherReport.dart';
import 'package:bloc/bloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,

      ),
      home: BlocProvider(
          builder: (context)=>WeatherBloc(WeatherRepo()),
          child: WeatherReport()),
    );
  }
}


