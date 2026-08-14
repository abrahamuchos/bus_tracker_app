import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants{
  ApiConstants._();

  static String baseUrl = dotenv.get('API_BASE_URL');


  static const String activeTrip = '/trips/active';
  static const String updateTripLocation = '/trips/{trip}/locations';
}