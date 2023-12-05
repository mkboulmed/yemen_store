
class Config {

  String appName = 'Store Yemen Tawfeer';
  String androidPackageName = 'com.mstoreapp.flutter1689584752324';
  String iosPackageName = 'com.mstoreapp.flutter1689584752324';

  String url = 'https://yementawfeer.shop';
  String consumerKey = 'ck_28d85b48544b7b9f92209cf59ebfa4ede7d40a90';
  String consumerSecret = 'cs_7359fb8a8a68cca96049ddf584563341e8c2d4de';
  String mapApiKey = 'AIzaSyAds4grQ1sFnd1gSR8ne7WfcOB-9tLaNl8';

  static Config _singleton = new Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal();

  Map<String, dynamic> appConfig = Map<String, dynamic>();

  Config loadFromMap(Map<String, dynamic> map) {
    appConfig.addAll(map);
    return _singleton;
  }

  dynamic get(String key) => appConfig[key];

  bool getBool(String key) => appConfig[key];

  int getInt(String key) => appConfig[key];

  double getDouble(String key) => appConfig[key];

  String getString(String key) => appConfig[key];

  void clear() => appConfig.clear();

  @Deprecated("use updateValue instead")
  void setValue(key, value) => value.runtimeType != appConfig[key].runtimeType
      ? throw ("wrong type")
      : appConfig.update(key, (dynamic) => value);

  void updateValue(String key, dynamic value) {
    if (appConfig[key] != null &&
        value.runtimeType != appConfig[key].runtimeType) {
      throw ("The persistent type of ${appConfig[key].runtimeType} does not match the given type ${value.runtimeType}");
    }
    appConfig.update(key, (dynamic) => value);
  }

  void addValue(String key, dynamic value) =>
      appConfig.putIfAbsent(key, () => value);

  add(Map<String, dynamic> map) => appConfig.addAll(map);



}