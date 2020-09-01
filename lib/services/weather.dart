import 'package:clima/services/location.dart';
import 'networking.dart';

const apiKey = '4629f92b5d10f9c309d07b6b203f5082';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Location location;

  WeatherModel() {
    location = Location();
  }

  Future<dynamic> getCityWeatherData(String cityName) async {
    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkingHelper networkingHelper = NetworkingHelper(url);
    return await networkingHelper.getData();
  }

  Future<dynamic> getWeatherData() async {
    await location.getActualLocation();
    NetworkingHelper networkingHelper = NetworkingHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    return await networkingHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
