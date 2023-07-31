import 'package:bloc/bloc.dart';
import 'package:weather/api/http_exception.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherEmpty()) {
    on<FetchWeather>(mapEventToState);
  }

  Future<void> mapEventToState(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    if (event is FetchWeather) {
      emit(WeatherLoading());
      try {
        final weather = await _weatherRepository.getWeather(
          cityName: event.cityName,
          latitude: event.latitude,
          longitude: event.longitude,
        );

        emit(WeatherLoaded(weather: weather));
      } catch (exception) {
        if (exception is HTTPException) {
          emit(WeatherError(errorCode: exception.code));
        } else {
          emit(const WeatherError(errorCode: 500));
        }
      }
    }
  }
}
