import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client, Response;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './../config.dart';
import '../models/product_model.dart';

//Directory _appDocsDir;

class ApiProvider {

  static final ApiProvider _apiProvider = new ApiProvider._internal();

  var filter = new Map<String, String>();

  factory ApiProvider() {
    return _apiProvider;
  }

  Future init() async {
    filter['flutter_app'] = '1';
    filter['distance'] = '10';
    //TODO TEST FOR VENDOR APP
    //filter['bao_vendor_id'] = '119';
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //_appDocsDir = await getApplicationDocumentsDirectory();
  }

  ApiProvider._internal();

  Client client = Client();
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8",
    "Accept": "application/json"
  };
  Map<String, dynamic> cookies = {};
  List<Cookie> cookieList = [];
  Config config = Config();

  Future<http.Response> fetchBlocks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cookies = prefs.getString('cookies') != null ? json.decode(prefs.getString('cookies')!) : {};
    //cookies = {};
    headers['cookie'] = generateCookieHeader();
    //print(config.url + '/wp-admin/admin-ajax.php?action=build-app-online-dotapp&' + Uri(queryParameters:filter).query);
    //Get Request not translating for WPML categories and products. Post Works for WPML, Get not working for some site for unknown reason. Make it get request if not working any site
    final response = await http.get(
      Uri.parse(config.url + '/wp-admin/admin-ajax.php?action=build-app-online-dotapp&' + Uri(queryParameters:filter).query),
      headers: headers,
      //body: filter
    );
    return response;
  }

  Future<List<Product>> fetchProductList(Map data) async {
    data.addAll(filter);
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(config.url + '/wp-admin/admin-ajax.php?action=build-app-online-products'),
      headers: headers,
      body: data,
    );
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception(
        'Unexpected response from server: (${response.statusCode}) ${response.reasonPhrase}',
      );
    }
  }

  Future<List<Product>> fetchRecentProducts(data) async {
    data.addAll(filter);
    final response = await http.post(
      Uri.parse(config.url + '/wp-admin/admin-ajax.php?action=build-app-online-products'),
      headers: headers,
      body: data,
    );
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<dynamic> fetchProducts(data) async {
    data.addAll(filter);
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(config.url + '/wp-admin/admin-ajax.php?action=build-app-online-products'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<dynamic> get(String endPoint) async {
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    if(filter.containsKey('lang')) {
      endPoint = endPoint + '&lang=' + filter['lang']!;
    }
    endPoint = endPoint + '&flutter_app=1';
    final response = await http.get(
      Uri.parse(config.url + endPoint),
      headers: headers,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> getRazorPay(String endPoint) async {
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.get(
      Uri.parse(config.url + endPoint),
      headers: headers,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> postWithCookies(String endPoint, Map data) async {
    data.addAll(filter);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cookies = prefs.getString('cookies') != null ? json.decode(prefs.getString('cookies')!) : {};
    headers['cookie'] = generateCookieHeader();
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(config.url + endPoint),
      headers: headers,
      body: data,
    );
    _updateCookie(response);
    return response;
  }

  Future<Response> post(String endPoint, Map data) async {
    //print(data);
    data.addAll(filter);
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    Response response = await http.post(
      Uri.parse(config.url + endPoint),
      headers: headers,
      body: data,
    );
    _updateCookie(response);
    return response;
  }

  //Future<Response> postTest(String endPoint, Map data) async {
    //Map<String, String> header = {
      //"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      //"Connection": "keep-alive",
      //"Accept-Encoding": "gzip, deflate, br",
      //"Accept": "application/json, text/javascript, */*; q=0.01",
    //};
    //header['content-type'] ='application/json; charset=utf-8';
    //header['Accept'] ='application/json, text/javascript, */*; q=0.01';
    //header['cookie'] = headers['cookie']!;
    //data.addAll(filter);
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    //Response response = await http.post(
      //Uri.parse(config.url + endPoint),
      //headers: header,
      //body: data,
    //);
    //_updateCookie(response);
    //return response;
  //}

  Future<dynamic> postWihoutUserLocation(String endPoint, Map data) async {
    if(filter.containsKey('lang')) {
      data['lang'] = filter['lang'];
    }
    data['flutter_app'] = '1';
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(config.url + endPoint),
      headers: headers,
      body: data,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> adminAjaxWithLanCode(String endPoint, Map data) async {
    data.addAll(filter);
    //data.addAll({'wpml_language_code' : 'ar'});
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(config.url + endPoint),
      headers: headers,
      body: data,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> wpGet(String endPoint, {Map<String, dynamic> data = const {}}) async {
    Map<String, String> stringQueryParameters = Map<String, String>();
    data.forEach((key, value) => stringQueryParameters[key] = value.toString());
    String url = config.url + '/wp-json/wp/v2/' + endPoint + '?' + Uri(queryParameters:stringQueryParameters).query;
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> adminAjax(Map data) async {
    data.addAll(filter);
    final response = await http.post(
      Uri.parse(config.url + '/wp-admin/admin-ajax.php'),
      headers: headers,
      body: data,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load');
    }
  }

  void _updateCookie(http.Response response) async {
    String? allSetCookie = response.headers['set-cookie'];
    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');
      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');
        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }
      headers['cookie'] = generateCookieHeader();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cookies', json.encode(cookies));
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];
        if (key == 'path') return;
        cookies[key] = value;
      }
    }
  }

  String generateCookieHeader() {
    String cookie = "";
    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += "; ";
      cookie += key + "=" + cookies[key];
    }
    return cookie;
  }

  String generateWebViewCookieHeader() {
    String cookie = "";
    for (var key in cookies.keys) {
      if( key.contains('woocommerce') ||
          key.contains('wordpress')
      ) {
        if (cookie.length > 0) cookie += "; ";
        cookie += key + "=" + cookies[key];
      }
    }
    return cookie;
  }

  List<Cookie> generateCookies() {
    cookieList.clear();
    for (var key in cookies.keys) {
      Cookie ck = new Cookie(key, cookies[key]);
      cookieList.add(ck);
    }
    return cookieList;
  }

  Future<dynamic> getPaymentUrl(String endPoint) async {
    headers['cookie'] = generateCookieHeader();
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
      Uri.parse(endPoint),
      headers: headers,
    );
    _updateCookie(response);
    return response;
  }

  Future<dynamic> postAjax(String url, Map data) async {
    headers['cookie'] = generateCookieHeader();
    //headers['content-type'] = 'application/x-www-form-urlencoded; charset=utf-8';
    final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data
    );
    _updateCookie(response);
    return response;
  }

  processExternalPaymentToken(String url, dynamic data) async {
    headers['content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
    headers['Accept'] = 'application/json, text/javascript, */*; q=0.01';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );
    //_updateCookie(response);
    return response;
  }

  processPayMongoToken(String url, String authorizationKey, dynamic data) async {
    Map<String, String> headers = {
      "content-type": "application/json; charset=utf-8",
      "Accept": "application/json, text/javascript, */*; q=0.01",
      "authorization": 'Basic ${authorizationKey}'
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );
    //_updateCookie(response);
    return response;
  }

  Future<dynamic> postWithCookiesEncoded(String endPoint, Map data) async {
    headers['cookie'] = generateCookieHeader();
    final response = await http.post(
      Uri.parse(config.url + endPoint),
      headers: headers,
      body: json.encode(data),
    );
    _updateCookie(response);
    return response;
  }


  /*downloadSplashSave(List<Child> splashScreens) async {

    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    var i = 0;

    splashScreens.forEach((element) async {

      File file = fileFromDocsDir("splash" + i.toString() + ".jpg");

      if(element.image != null && element.image.isNotEmpty) {
        final Uri resolved = Uri.base.resolve(element.image);
        final HttpClientRequest request = await HttpClient().getUrl(resolved);
        headers?.forEach((String name, String value) {
          request.headers.add(name, value);
        });
        final HttpClientResponse response = await request.close();
        if (response.statusCode != HttpStatus.ok)
          throw NetworkImageLoadException(statusCode: response.statusCode, uri: resolved);

        final Uint8List bytes = await consolidateHttpClientResponseBytes(
          response,
          onBytesReceived: (int cumulative, int total) {
            chunkEvents.add(ImageChunkEvent(
              cumulativeBytesLoaded: cumulative,
              expectedTotalBytes: total,
            ));
          },
        );

        if (bytes.lengthInBytes == 0) {
          throw Exception('NetworkImage is an empty file: $resolved');
        }

        i++;

        if(file != null)
        file.writeAsBytes(bytes, flush: true);
      }

      if(i == splashScreens.length) {
        //chunkEvents.close();
      }

    });


  }

  File fileFromDocsDir(String filename) {
    String pathName = p.join(_appDocsDir.path, filename);
  }*/

}
