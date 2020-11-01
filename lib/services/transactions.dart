import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plat/models/transactions.dart';

class TransactionsClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  TransactionsClient({
    @required this.httpClient,
  }) : assert(httpClient != null);
  Future<List<Transaction>> getLastSavedTransactions(String id) async {
    //final locationUrl = '$baseUrl/api/location/search/?query=$id';
    //final locationResponse = await this.httpClient.get(locationUrl);
    //if (locationResponse.statusCode != 200) {
    //  throw Exception('error getting locationId for city');
    //}

    //final locationJson = jsonDecode(locationResponse.body) as List;

    return [
      Transaction(
          id: "1234",
          dueDate: "2020-05-05",
          amount: "5000.00",
          isIncluded: false)
    ]; //mock
  }

  Future<List<Transaction>> getNewCandidateTransactions(String id) async {
    //final locationUrl = '$baseUrl/api/location/search/?query=$id';
    //final locationResponse = await this.httpClient.get(locationUrl);
    //if (locationResponse.statusCode != 200) {
    //  throw Exception('error getting locationId for city');
    //}

    //final locationJson = jsonDecode(locationResponse.body) as List;

    return [
      Transaction(
          id: "5678",
          dueDate: "2020-05-05",
          amount: "3500.00",
          isIncluded: false)
    ];
  }
}
