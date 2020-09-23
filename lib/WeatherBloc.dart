import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_report/WeatherModel.dart';
import 'package:weather_report/WeatherRepo.dart';


class WeatherEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class FetchWeather extends WeatherEvent{

  final _city;

  FetchWeather(this._city);
  @override
  // TODO: implement props
  List<Object> get props => [_city];

}

class ResetWeather extends WeatherEvent{}

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class WeatherNotSearched extends WeatherState{
}

class WeatherIsLoading extends WeatherState{

}

class WeatherIsLoaded extends WeatherState{

  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];

}

class WeatherIsNotLoaded extends WeatherState{

}
class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {

  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo);

  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    // TODO: implement mapEventToState
    if(event is FetchWeather){
        yield WeatherIsLoading();
        try{
          WeatherModel weather = await weatherRepo.getWeather(event._city);
          yield WeatherIsLoaded(weather);
        }catch(_){
          yield WeatherIsNotLoaded();
        }
    }else if (event is ResetWeather){
      yield WeatherIsNotLoaded();
    }
  }

}