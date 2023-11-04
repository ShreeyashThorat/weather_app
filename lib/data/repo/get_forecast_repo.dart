import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/api.dart';

import '../../utils/constant_text.dart';
import '../models/forecast_model.dart';

class GetForecastRepo {
  final Api api = Api();
  Future<String?> getLoacation() async {
    try {
      await Geolocator.requestPermission();
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final List<Placemark> p = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final Placemark place = p[0];
      final String location = place.locality.toString();
      log("Location $location");
      return location;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<ForecastModel> fetchForecast(String location) async {
    try {
      Response response = await api.sendRequest
          .get("/forecast.json?key=${ConstantText.apiKey}&days=7&q=$location");

      if (response.statusCode == 200) {
        return ForecastModel.fromJson(response.data);
      } else {
        throw "Failed to get Forecast";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
