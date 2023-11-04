import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/forecast_model.dart';
import '../../data/repo/get_forecast_repo.dart';

class ForecastController extends GetxController {
  final GetForecastRepo getForecastRepo = GetForecastRepo();
  static ForecastController get instance => Get.find();
  var weatherData = ForecastModel().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentLocationObtained = false.obs;
  final searchLocation = TextEditingController();

  final ForecastModel forecastModel = ForecastModel();
  Future<void> fetchCurrentLocationWeather() async {
    isLoading(true);
    try {
      final location = await getForecastRepo.getLoacation();
      log("Location $location");
      final data = await getForecastRepo.fetchForecast(location!);
      weatherData(data);
      currentLocationObtained(true);
    } catch (e) {
      log("Failed: ${e.toString()}");
      errorMessage("Failed to get data");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWeatherByLocation(String location) async {
    isLoading(true);
    try {
      final data = await getForecastRepo.fetchForecast(location);
      weatherData(data);
      currentLocationObtained(false);
    } catch (e) {
      log("Failed: ${e.toString()}");
      errorMessage("Failed to get data");
    } finally {
      isLoading(false);
    }
  }
}
