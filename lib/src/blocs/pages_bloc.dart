import 'dart:convert';
import 'package:app/src/models/pages_model/page_model.dart';
import 'package:rxdart/rxdart.dart';
import './../resources/api_provider.dart';

class PageBloc {

  final apiProvider = ApiProvider();
  final _pageFetcher = BehaviorSubject<PageModel>();

  ValueStream<PageModel> get allPage => _pageFetcher.stream;

  final _menuFetcher = BehaviorSubject<GroupsModel>();

  ValueStream<GroupsModel> get allMenu => _menuFetcher.stream;

  getPage(String id) async {
    final response = await apiProvider.get('/wp-admin/admin-ajax.php?action=build-app-online-page&id=' + id.toString());
    if(response.statusCode == 200) {
      PageModel page = PageModel.fromJson(json.decode(response.body));
      _pageFetcher.sink.add(page);
    } else {
      //
    }
  }

  getMenu(String id) async {
    final response = await apiProvider.get('/wp-admin/admin-ajax.php?action=build-app-online-group&id=' + id.toString());
    if(response.statusCode == 200) {
      GroupsModel menu = GroupsModel.fromJson(json.decode(response.body));
      _menuFetcher.sink.add(menu);
    } else {
      //
    }
  }

  dispose() {
    _pageFetcher.close();
  }
}

final PageBloc pageBloc = PageBloc();
