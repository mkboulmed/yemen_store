import './../models/category_model.dart';
import './../models/fcm_details_model.dart';
import '../resources/api_provider.dart';
import 'package:rxdart/rxdart.dart';


// alerts_bloc.dart

class AlertsBloc {
  final _fcmDetailsFetcher = BehaviorSubject<FcmDetails>();
  final api = ApiProvider();
  late FcmDetails fDetails;

  ValueStream<FcmDetails> get fcmDetails => _fcmDetailsFetcher.stream;

  Future<void> fetchTopics(String token) async {
    try {
      Map<String, dynamic> data = {};
      data['token'] = token;
      final response = await api.post('/wp-admin/admin-ajax.php?action=fcm_details', data);

      if (response.statusCode == 200) {
        fDetails = fcmDetailsFromJson(response.body);
        _fcmDetailsFetcher.sink.add(fDetails);
      } else {
        _fcmDetailsFetcher.sink.addError(true);
        throw Exception(
          'Unexpected response from server: (${response.statusCode}) ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print("Error fetching topics: $e");
      // Handle the error, e.g., show a snackbar or log the error
    }
  }

  dispose() {
    _fcmDetailsFetcher.close();
  }

  void updateTopics(Category category, bool value) {
    if (value) {
      if (!fDetails.topics.contains(category.slug)) {
        fDetails.topics.add(category.slug);
      }
    } else {
      fDetails.topics.remove(category.slug);
    }
    _fcmDetailsFetcher.sink.add(fDetails);
  }
}

final bloc = AlertsBloc();