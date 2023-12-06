import 'package:app/src/ui/widgets/progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../src/blocs/alerts_bloc.dart';
import '../../../../src/functions.dart';
import '../../../../src/models/category_model.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/fcm_details_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
/*
class AlertsPage extends StatefulWidget {
  List<Category> categories;
  final alertsBloc = AlertsBloc();
  AlertsPage({Key? key, required this.categories}) : super(key: key);
  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late String selectedTopic;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    FirebaseMessaging.instance.getToken().then((String? token) {
      widget.alertsBloc.fetchTopics(token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alerts')),
      body: StreamBuilder<FcmDetails>(
        stream: widget.alertsBloc.fcmDetails,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? ListView(
            children: _buildList(snapshot.data!.topics),
          )
              : Center(child: LoadingIndicator());
        },
      ),
    );
  }

  List<Widget> _buildList(List<String> topics) {
    List<Widget> list = [];
    widget.categories.forEach((element) {
      list.add(
        Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              margin: EdgeInsets.all(0),
              child: SwitchListTile(
                value: topics.contains(element.slug),
                title: Text(parseHtmlString(element.name)),
                onChanged: (bool value) => _onChanged(element, value),
              ),
            ),
            Divider(height: 0)
          ],
        ),
      );
    });

    return list;
  }

  Future<void> _onChanged(Category category, bool value) async {
    try {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic(category.slug);
        await FirebaseMessaging.instance.subscribeToTopic(category.id.toString());
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic(category.id.toString());
        await FirebaseMessaging.instance.unsubscribeFromTopic(category.slug);
      }

      // Update the topics in the Bloc
      widget.alertsBloc.updateTopics(category, value);
    } catch (e) {
      print("Error subscribing/unsubscribing to topic: $e");
    }
  }
}*/


class AlertsPage extends StatefulWidget {
  List<Category> categories;
  final alertsBloc = AlertsBloc();

  AlertsPage({Key? key, required this.categories}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  Set<String> selectedTopics = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load the selected categories from shared preferences
    _loadSelectedCategories();
  }

  Future<void> _initializeData() async {
    FirebaseMessaging.instance.getToken().then((String? token) {
      widget.alertsBloc.fetchTopics(token!);
    });
  }

  Future<void> _loadSelectedCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTopics = (prefs.getStringList('selectedTopics') ?? []).toSet();
    });
  }

  Future<void> _saveSelectedCategories(Set<String> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedTopics', categories.toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alerts')),
      body: StreamBuilder<FcmDetails>(
        stream: widget.alertsBloc.fcmDetails,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data != null
              ? ListView(
            children: _buildList(snapshot.data!.topics),
          )
              : Center(child: LoadingIndicator());
        },
      ),
    );
  }

  List<Widget> _buildList(List<String> topics) {
    List<Widget> list = [];
    widget.categories.forEach((element) {
      list.add(
        Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              margin: EdgeInsets.all(0),
              child: SwitchListTile(
                value: selectedTopics.contains(element.slug),
                title: Text(parseHtmlString(element.name)),
                onChanged: (bool value) => _onChanged(element, value),
              ),
            ),
            Divider(height: 0)
          ],
        ),
      );
    });

    return list;
  }

  // Your existing code...

  Future<void> _onChanged(Category category, bool value) async {
    try {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic(category.slug);
        await FirebaseMessaging.instance.subscribeToTopic(category.id.toString());
        // print("sssss");
        selectedTopics.add(category.slug);
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic(category.id.toString());
        await FirebaseMessaging.instance.unsubscribeFromTopic(category.slug);
        // print('uuuu');
        selectedTopics.remove(category.slug);
      }

      // Update the topics in the Bloc
      widget.alertsBloc.updateTopics(category, value);

      // Save the selected categories
      _saveSelectedCategories(selectedTopics);
    } catch (e) {
      print("Error subscribing/unsubscribing to topic: $e");
    }
  }

}
