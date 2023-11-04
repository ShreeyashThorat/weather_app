import 'package:get/get.dart';
import 'package:weather_app/presentations/authenticate/login.dart';
import 'package:weather_app/presentations/authenticate/main_page.dart';
import 'package:weather_app/presentations/authenticate/sign_up.dart';
import 'package:weather_app/presentations/dashboard/home/home_page.dart';

var routes = [
  GetPage(
    name: '/mainpage',
    page: () => const MainPage(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/signup',
    page: () => const SignUp(),
  ),
  GetPage(
    name: '/home',
    page: () => const HomePage(),
  ),
];
