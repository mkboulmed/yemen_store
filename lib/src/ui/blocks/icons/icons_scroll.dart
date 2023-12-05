import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/blocks/banners/banner_title.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';

class IconsScroll extends StatefulWidget {
  final Block block;
  const IconsScroll({Key? key, required this.block}) : super(key: key);
  @override
  _IconsScrollState createState() => _IconsScrollState();
}

class _IconsScrollState extends State<IconsScroll> {
  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double padding = widget.block.mainAxisSpacing == 0 ? 16 : widget.block.mainAxisSpacing;


    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverToBoxAdapter(
        child: Card(
          elevation: 0,
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(widget.block.blockPadding.left, widget.block.blockPadding.top, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                    child: BannerTitle(block: widget.block)
                ),
                Container(
                  height: widget.block.childHeight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {


                      double marginLast = (index + 1) == widget.block.children.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
                      double marginFirst = index == 0 ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;


                      return Container(
                        width: widget.block.childWidth,
                        margin: EdgeInsets.fromLTRB(marginFirst, 0, marginLast, 0),
                        child: Card(
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          elevation: widget.block.elevation,
                          margin: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(widget.block.borderRadius),
                          ),
                          child: InkWell(
                            radius: widget.block.borderRadius,
                            onTap: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            child: Container(
                              height: widget.block.childHeight,
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
                        ),
                      );
                    },
                    itemCount: widget.block.children.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
