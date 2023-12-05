import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:flutter/material.dart';
import './../../../models/blocks_model.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import '../../../functions.dart';

class ListTileItems extends StatefulWidget {
  final Block block;
  const ListTileItems({Key? key, required this.block}) : super(key: key);
  @override
  _ListTileItemsState createState() => _ListTileItemsState();
}

class _ListTileItemsState extends State<ListTileItems> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final TextStyle? style = theme.textTheme.bodyText2;
    final Color? captionColor = theme.textTheme.caption!.color;
    TextStyle subtitleTextStyle =
    style!.copyWith(color: widget.block.titleColor.withOpacity(0.6), fontSize: 12.0);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    int count = widget.block.children.length;

    if(widget.block.children.length > 0 && widget.block.headerAlign != 'none') {
      count = widget.block.children.length + 1;
    }

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {

            if(index == 0 && widget.block.headerAlign != 'none') {
              double padding = widget.block.mainAxisSpacing == 0 ? 16 : widget.block.mainAxisSpacing;
              return Container(
                  padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                  color: isDark ? Colors.transparent : widget.block.backgroundColor,
                  child: BannerTitle(block: widget.block)
              );
            }

            if(index != 0 && widget.block.headerAlign != 'none') {
              index = index - 1;
            }

            return GestureDetector(
              onTap: () async {
                onItemClick(widget.block.children[index], context);
              },
              child: Column(
                children: [
                  ListTile(
                    tileColor: isDark ? Colors.transparent : widget.block.backgroundColor,
                    //minLeadingWidth: 56,
                    //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    onTap: () async {
                      onItemClick(widget.block.children[index], context);
                    },
                    dense: false,
                    isThreeLine: widget.block.children[index].description.isNotEmpty,
                    trailing: widget.block.children[index].trailing.isNotEmpty ? DunesIcon(iconString: widget.block.children[index].trailing, color: widget.block.children[index].iconStyle != null ? widget.block.titleColor.withOpacity(0.6) : null) : null,
                    leading: DunesIcon(iconString: widget.block.children[index].leading, color: widget.block.children[index].iconStyle != null ? widget.block.titleColor : null),
                    title: Text(parseHtmlString(widget.block.children[index].title), maxLines: 2, style: TextStyle(color: widget.block.titleColor)),
                    subtitle: widget.block.children[index].description.isNotEmpty ? Text(parseHtmlString(widget.block.children[index].description), maxLines: 1, style: subtitleTextStyle) : null,
                  ),
                  Divider(height: 0)
                ],
              ),
            );
          },
          childCount: count,
        ),
      ),
    );
  }
}
