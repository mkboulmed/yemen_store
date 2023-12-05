import 'package:app/src/blocs/subscription_bloc.dart';
import 'package:app/src/models/subscription_model.dart';
import 'package:flutter/material.dart';

class SubscriptionOrders extends StatefulWidget {
  final subscriptionBloc = SubscriptionBloc();
  SubscriptionOrders({Key? key}) : super(key: key);

  @override
  State<SubscriptionOrders> createState() => _SubscriptionOrdersState();
}

class _SubscriptionOrdersState extends State<SubscriptionOrders>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _controller.index = 0;
    _controller.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Your Packages'),
          bottom: TabBar(
            isScrollable: false,
            indicatorWeight: 4,
            //indicatorSize: TabBarIndicatorSize.label,
            //indicatorPadding: EdgeInsets.all(model.blocks.settings.bottomTabBarStyle.indicatorPadding),
            controller: _controller,
            tabs: [Tab(text: 'Active'), Tab(text: 'Expired')],
          )),
      body: Builder(builder: (context) {
        if (_controller.index == 0)
          return ActiveSunscription(subscriptionBloc: widget.subscriptionBloc);
        else
          return ExpiredSubscription(subscriptionBloc: widget.subscriptionBloc);
      }),
    );
  }

  void _handleTabSelection() {
    setState(() {});
  }
}

class ActiveSunscription extends StatefulWidget {
  final SubscriptionBloc subscriptionBloc;
  ActiveSunscription({
    Key? key,
    required this.subscriptionBloc,
  }) : super(key: key);

  @override
  State<ActiveSunscription> createState() => _ActiveSunscriptionState();
}

class _ActiveSunscriptionState extends State<ActiveSunscription> {
  @override
  void initState() {
    super.initState();
    widget.subscriptionBloc.getActiveSubscription();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.subscriptionBloc.allActive,
        builder: (context, AsyncSnapshot<List<SubscriptionModel>> snapshot) {
          print(snapshot.hasData);

          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.length > 0 ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data!.length);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title: Text('ORDER NO: ' + snapshot.data![index].orderNumber),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot
                              .data![index].order.lineItems[index].name, style: Theme.of(context).textTheme.subtitle2,),
                          Text('TZS ' +
                              snapshot.data![index].order.lineItems[index].price
                                  .toString()),
                          Text(snapshot.data![index].order.dateCreated
                              .toIso8601String()),
                          Divider()
                        ],
                      )),
                );
              },
            ) : Center(child: Text('There is no active packages'));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

class ExpiredSubscription extends StatefulWidget {
  final SubscriptionBloc subscriptionBloc;
  ExpiredSubscription({Key? key, required this.subscriptionBloc})
      : super(key: key);

  @override
  State<ExpiredSubscription> createState() => _ExpiredSubscriptionState();
}

class _ExpiredSubscriptionState extends State<ExpiredSubscription> {
  @override
  void initState() {
    super.initState();
    widget.subscriptionBloc.getExpiredSubscription();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.subscriptionBloc.allExpired,
        builder: (context, AsyncSnapshot<List<SubscriptionModel>> snapshot) {
          // print(snapshot.hasData);
          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text('Order No: ' +
                                snapshot.data![index].orderNumber),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot
                                    .data![index].order.lineItems[0].name),
                                Text('TZS ' +
                                    snapshot
                                        .data![index].order.lineItems[0].price
                                        .toString()),
                                Text(snapshot.data![index].order.dateCreated
                                    .toIso8601String()),
                                Divider()
                              ],
                            )),
                      );
                    },
                  )
                : Center(child: Text('There is no expired packages'));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
