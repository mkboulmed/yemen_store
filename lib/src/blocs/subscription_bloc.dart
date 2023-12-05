import 'dart:convert';
import 'package:app/src/models/subscription_model.dart';
import 'package:app/src/models/vendor/store_model.dart';
import 'package:app/src/resources/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionBloc{

  List<SubscriptionModel> activeSubscription = [];

  final apiProvider = ApiProvider();
  final _subscriptionFetcher = BehaviorSubject<List<SubscriptionModel>>();
  final _storeFetcher = BehaviorSubject<StoreModel>();

  ValueStream<List<SubscriptionModel>> get allActive => _subscriptionFetcher.stream;

  ValueStream<StoreModel> get storeInfo => _storeFetcher.stream;


  getActiveSubscription() async {
    final response = await apiProvider.get(
        '/wp-admin/admin-ajax.php?action=build-app-online-subscriptions');
    activeSubscription = subscriptionFromJson(response.body);
    _subscriptionFetcher.sink.add(activeSubscription);
  }

  List<SubscriptionModel> expiredSubscription = [];

  final _expireSubscriptionFetcher =
  BehaviorSubject<List<SubscriptionModel>>();

  ValueStream<List<SubscriptionModel>> get allExpired =>
      _expireSubscriptionFetcher.stream;

  getExpiredSubscription() async {
    final response = await apiProvider.get(
        '/wp-admin/admin-ajax.php?action=build-app-online-subscriptions&status=expired');
    print(response.body);
    expiredSubscription = subscriptionFromJson(response.body);
    _expireSubscriptionFetcher.sink.add(expiredSubscription);
  }

  //TODO Load from main site
  getStoreInfo(String storeId) async {
    final response = await apiProvider.get(
        '/wp-admin/admin-ajax.php?action=build-app-online-store_info&store_id=' + storeId);
    StoreModel store = StoreModel.fromJson(json.decode(response.body));
    _storeFetcher.sink.add(store);
  }
}
