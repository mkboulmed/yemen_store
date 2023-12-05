import 'package:dunes_icons/dunes_icons.dart';
import 'package:dunes_font/dunes_font.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';
import 'banner_title.dart';

class ButtonList extends StatefulWidget {
  final Block block;
  const ButtonList({Key? key, required this.block}) : super(key: key);
  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  @override
  Widget build(BuildContext context) {


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

              double paddingTop = index == 0 ? widget.block.blockPadding.top : 0;
              double paddingBottom = (index + 1) == widget.block.children.length ? widget.block.blockPadding.bottom : 0;

              double marginLast = (index + 1) == widget.block.children.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
              double marginFirst = index == 0 ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;

              if(widget.block.headerAlign != 'none') {
                marginLast = index == widget.block.children.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
                marginFirst = index == 1 ? widget.block.mainAxisSpacing / 2 : widget.block.mainAxisSpacing / 2;
                paddingTop = index == 1 ? widget.block.blockPadding.top : 0;
                paddingBottom = index == widget.block.children.length ? widget.block.blockPadding.bottom : 0;
              }

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


              return Container(
                color: isDark ? Colors.transparent : widget.block.backgroundColor,
                child: Container(
                  margin: EdgeInsets.fromLTRB(widget.block.blockPadding.left, paddingTop, widget.block.blockPadding.right, paddingBottom),
                  child: Card(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    elevation: widget.block.elevation,
                    margin: EdgeInsets.fromLTRB(widget.block.crossAxisSpacing, marginFirst, widget.block.crossAxisSpacing, marginLast),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.block.borderRadius),
                    ),
                    child: Builder(
                      builder: (context) {
                        if( widget.block.style == 'STYLE1') {
                          return ElevatedButton(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            child: Text(widget.block.children[index].title),
                          );
                        } else if( widget.block.style == 'STYLE2') {
                          return OutlinedButton(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              //backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            child: Text(widget.block.children[index].title),
                          );
                        } else if( widget.block.style == 'STYLE3') {
                          return TextButton(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              //backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            child: Text(widget.block.children[index].title),
                          );
                        } else if( widget.block.style == 'STYLE4') {
                          return ElevatedButton.icon(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            label: Text(widget.block.children[index].title),
                            icon: DunesIcon(iconString: widget.block.children[index].leading),
                          );
                        } else if( widget.block.style == 'STYLE5') {
                          return OutlinedButton.icon(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              //backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            label: Text(widget.block.children[index].title),
                            icon: DunesIcon(iconString: widget.block.children[index].leading),
                          );
                        } else if( widget.block.style == 'STYLE6') {
                          return TextButton.icon(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              //backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            label: Text(widget.block.children[index].title),
                            icon: DunesIcon(iconString: widget.block.children[index].leading),
                          );
                        } else {
                          return ElevatedButton(
                            style: widget.block.children[index].buttonStyle != null ? ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.children[index].buttonStyle!.borderRadius), // <-- Radius
                              ),
                              padding: EdgeInsets.all(widget.block.children[index].buttonStyle!.padding),
                              backgroundColor: widget.block.children[index].buttonStyle!.backgroundColor,
                              foregroundColor: widget.block.children[index].buttonStyle!.foregroundColor,
                              shadowColor: widget.block.children[index].buttonStyle!.shadowColor,
                              surfaceTintColor: widget.block.children[index].buttonStyle!.surfaceTintColor,
                              elevation: widget.block.children[index].buttonStyle!.elevation,
                              textStyle: widget.block.children[index].textStyle != null ? getGoogleFont(widget.block.children[index].textStyle!.fontFamily).copyWith(
                                color: widget.block.children[index].textStyle!.color,
                                letterSpacing: widget.block.children[index].textStyle!.letterSpacing,
                                wordSpacing: widget.block.children[index].textStyle!.wordSpacing,
                                fontWeight: widget.block.children[index].textStyle!.fontWeight,
                                fontSize: widget.block.children[index].textStyle!.fontSize,
                                fontStyle: widget.block.children[index].textStyle!.fontStyle,
                                backgroundColor: widget.block.children[index].textStyle!.backgroundColor,
                              ) : null,
                            ) : null,
                            onPressed: () async {
                              onItemClick(widget.block.children[index], context);
                            },
                            child: Text(widget.block.children[index].title),
                          );
                        }
                      }
                    ),
                  ),
                ),
              );
            },
           childCount: count,
          ),
        ),
    );
  }
}
