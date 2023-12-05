import 'package:app/src/blocs/pages_bloc.dart';
import 'package:app/src/models/pages_model/page_model.dart';
import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:app/src/ui/widgets/colored_icon.dart';
import 'package:app/src/ui/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewGroups extends StatefulWidget {
  final String id;
  final PageBloc pageBloc = PageBloc();
  ViewGroups({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewGroups> createState() => _ViewGroupsState();
}

class _ViewGroupsState extends State<ViewGroups> {

  @override
  void initState() {
    widget.pageBloc.getMenu(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool brightness = Theme
        .of(context)
        .brightness == Brightness.dark;
    return StreamBuilder<GroupsModel>(
        stream: widget.pageBloc.allMenu,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final group = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  for (var i = 0; i < group.actions.length; i++)
                    IconButton(onPressed: () {
                      onItemClick(group.actions[i], context);
                    }, icon: DunesIcon(iconString: group.actions[i].leading))
                ],
              ),
              body: CustomScrollView(slivers: _buildList(group)),
              floatingActionButton: group.floatingAction != null
                  ? FloatingActionButton(
                //backgroundColor: pageThemeData.floatingActionBackgroundColor,
                  onPressed: () async {
                    onItemClick(group.floatingAction!, context);
                  },
                  child: DunesIcon(iconString: group.floatingAction!.leading)
              )
                  : null,
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: LoadingIndicator()),
            );
          }
        }
    );
  }

  _buildList(GroupsModel group) {
    List<Widget> list = [];

    group.menuGroup.forEach((accountGroup) {
      if (accountGroup.showTitle) {
        list.add(
            SliverToBoxAdapter(
              child: ListTile(
                subtitle: Text(accountGroup.title, style: Theme
                    .of(context)
                    .textTheme
                    .headline6),
              ),
            )
        );
      } else
        list.add(SliverToBoxAdapter(child: SizedBox(height: 16)));

      list.add(SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) =>
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      onItemClick(accountGroup.menuItems[index], context);
                    },
                    leading: accountGroup.menuItems[index].leading.isNotEmpty
                        ? ColoredIcon(item: accountGroup.menuItems[index])
                        : null,
                    trailing: accountGroup.menuItems[index].trailing.isNotEmpty
                        ? DunesIcon(iconString: accountGroup.menuItems[index].trailing)
                        : null,
                    title: Text(accountGroup.menuItems[index].title),
                  ),
                  Divider(height: 0)
                ],
              ),
          childCount: accountGroup.menuItems.length,
        ),
      ));
    });
    return list;
  }
}