import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class PaydayClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  PaydayClient({
    @required this.httpClient,
  }) : assert(httpClient != null);
  Future<double> getMemoizedPayday(String id) async {
    //final locationUrl = '$baseUrl/api/location/search/?query=$id';
    //final locationResponse = await this.httpClient.get(locationUrl);
    //if (locationResponse.statusCode != 200) {
    //  throw Exception('error getting locationId for city');
    //}

    //final locationJson = jsonDecode(locationResponse.body) as List;

    return 0.5; //mock
  }

  Future<double> getRecomputePayday(String id) async {
    //final locationUrl = '$baseUrl/api/location/search/?query=$id';
    //final locationResponse = await this.httpClient.get(locationUrl);
    //if (locationResponse.statusCode != 200) {
    //  throw Exception('error getting locationId for city');
    //}

    //final locationJson = jsonDecode(locationResponse.body) as List;

    return 0.7;
  }
}
