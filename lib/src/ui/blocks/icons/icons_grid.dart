import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/blocks/banners/banner_title.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';

class IconsGrid extends StatefulWidget {
  final Block block;
  const IconsGrid({Key? key, required this.block}) : super(key: key);
  @override
  _IconsGridState createState() => _IconsGridState();
}

class _IconsGridState extends State<IconsGrid> {
  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double mainAxisSpacingTop = widget.block.mainAxisSpacing;
    if(widget.block.headerAlign != 'none') {
      mainAxisSpacingTop = 0;
    }

    return SliverToBoxAdapter(
      child: widget.block.horizontal ? Container(
        margin: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
        child: Container(
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          padding: EdgeInsets.only(top: widget.block.blockPadding.top, bottom: widget.block.blockPadding.bottom),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: widget.block.blockPadding.left, right: widget.block.blockPadding.right),
                  child: BannerTitle(block: widget.block)),
              Container(
                height: widget.block.childHeight,
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: widget.block.crossAxisSpacing,
                  mainAxisSpacing: widget.block.mainAxisSpacing,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  childAspectRatio: widget.block.childAspectRatio,
                  crossAxisCount: widget.block.crossAxisCount,
                  padding: EdgeInsets.only(left: widget.block.blockPadding.left, right: widget.block.blockPadding.right),
                  children: _buildBlockList(context),
                ),
              )
            ],
          ),
        ),
      ) : Container(
        margin: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
        child: Container(
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          padding: EdgeInsets.fromLTRB(widget.block.mainAxisSpacing, mainAxisSpacingTop, widget.block.mainAxisSpacing, widget.block.mainAxisSpacing),
          child: Column(
            children: [
              BannerTitle(block: widget.block),
              GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(widget.block.blockPadding.left, widget.block.blockPadding.top, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: widget.block.maxCrossAxisExtent,
                    mainAxisSpacing: widget.block.mainAxisSpacing,
                    crossAxisSpacing: widget.block.crossAxisSpacing,
                    childAspectRatio: widget.block.childWidth/widget.block.childHeight,
                  ),
                  itemCount: widget.block.children.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(0),
                      elevation: widget.block.elevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.block.borderRadius),
                      ),
                      child: InkWell(
                        radius: widget.block.borderRadius,
                        onTap: () async {
                          onItemClick(widget.block.children[index], context);
                        },
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: isDark ? widget.block.titleColor.withOpacity(0.2) : widget.block.titleColor.withOpacity(0.2),
                                    boxShadow: [
                                      BoxShadow(color: Colors.transparent),
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: DunesIcon(iconString: widget.block.children[index].leading, color: widget.block.children[index].iconStyle != null ? widget.block.titleColor : null),
                                        onPressed: () async {

                                        }),
                                  ),
                                ),
                              ),
                              if(widget.block.children[index].title.isNotEmpty)
                              Column(
                                children: [
                                  SizedBox(height: 4),
                                  Text(widget.block.children[index].title, maxLines: 2, textAlign: TextAlign.center, style: TextStyle(color: widget.block.titleColor),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _buildBlockList(BuildContext context) {
    List<Widget> list = [];

    widget.block.children.forEach((element) {
      list.add(Card(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        elevation: widget.block.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.block.borderRadius),
        ),
        child: InkWell(
          radius: widget.block.borderRadius,
          onTap: () async {
            onItemClick(element, context);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).brightness == Brightness.dark ? widget.block.titleColor.withOpacity(0.2) : widget.block.titleColor.withOpacity(0.2),
                      boxShadow: [
                        BoxShadow(color: Colors.transparent),
                      ],
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: DunesIcon(iconString: element.leading, color: element.iconStyle != null ? widget.block.titleColor : null),
                          onPressed: () async {
                            onItemClick(element, context);
                          }),
                    ),
                  ),
                ),
                if(element.title.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 4),
                      Text(element.title, maxLines: 2, textAlign: TextAlign.center, style: TextStyle(color: widget.block.titleColor),),
                    ],
                  )
              ],
            ),
          ),
        ),
      ));
    });

    return list;
  }
}
