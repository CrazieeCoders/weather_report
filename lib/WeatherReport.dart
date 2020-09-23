import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report/WeatherRepo.dart';
import 'WeatherBloc.dart';
import 'WeatherModel.dart';


class WeatherReport extends StatefulWidget {
  @override
  _WeatherReportState createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {


  final _formKey =GlobalKey<FormState>();

  TextEditingController _weatherController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather report'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          BlocBuilder<WeatherBloc,WeatherState>(
            builder: (context ,state){
              if(state is WeatherNotSearched) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0.5),
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: _weatherController,
                            decoration: InputDecoration(
                                hintText: 'Enter the city'
                            ),

                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter the city Name";
                              }
                              return null;
                            }
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: (){
                          weatherBloc.add(FetchWeather(_weatherController.text));
                        },
                        child: Text('get Temperature'),
                      ),
                    ),
                  ],
                );
              }else if(state is WeatherIsLoading){
                return Center(child: CircularProgressIndicator());
              }else if(state is WeatherIsLoaded){
                 return ShowWeather(state.getWeather,_weatherController.text);
              }
              return Center(child: Text("Error",style: TextStyle(
                fontSize: 20.0,
              ),));
            }
          )

        ],
      )
    );

  }



}

class ShowWeather extends StatelessWidget {

 WeatherModel weather;
  final city;

  ShowWeather(this.weather,this.city);


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: <Widget>[
          Text(
            'Temp ${weather.getTemp.roundToDouble()} \'C',
            style: TextStyle(
                fontSize: 30.0
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'minTemp ${weather.getMinTemp.roundToDouble()} \'C',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),

              Text(
                'maxTemp ${weather.getMaxTemp.roundToDouble()} \'C',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

