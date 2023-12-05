import 'package:dunes_icons/dunes_icons.dart';
import 'package:dunes_font/dunes_font.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';
import 'banner_title.dart';

class ButtonGrid extends StatefulWidget {
  final Block block;
  const ButtonGrid({Key? key, required this.block}) : super(key: key);
  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
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
                  children: _buildBlockList(),
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
                    childAspectRatio: widget.block.childWidth/widget.block.childHeight > 0 ? widget.block.childWidth/widget.block.childHeight : 0.1,
                  ),
                  itemCount: widget.block.children.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Builder(
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _buildBlockList() {
    List<Widget> list = [];

    widget.block.children.forEach((element) {
      list.add(Builder(
          builder: (context) {
            if( widget.block.style == 'STYLE1') {
              return ElevatedButton(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                child: Text(element.title),
              );
            } else if( widget.block.style == 'STYLE2') {
              return OutlinedButton(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  //backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                child: Text(element.title),
              );
            } else if( widget.block.style == 'STYLE3') {
              return TextButton(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  //backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                child: Text(element.title),
              );
            } else if( widget.block.style == 'STYLE4') {
              return ElevatedButton.icon(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                label: Text(element.title),
                icon: DunesIcon(iconString: element.leading),
              );
            } else if( widget.block.style == 'STYLE5') {
              return OutlinedButton.icon(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  //backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                label: Text(element.title),
                icon: DunesIcon(iconString: element.leading),
              );
            } else if( widget.block.style == 'STYLE6') {
              return TextButton.icon(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  //backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                label: Text(element.title),
                icon: DunesIcon(iconString: element.leading),
              );
            } else {
              return ElevatedButton(
                style: element.buttonStyle != null ? ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(element.buttonStyle!.borderRadius), // <-- Radius
                  ),
                  padding: EdgeInsets.all(element.buttonStyle!.padding),
                  backgroundColor: element.buttonStyle!.backgroundColor,
                  foregroundColor: element.buttonStyle!.foregroundColor,
                  shadowColor: element.buttonStyle!.shadowColor,
                  surfaceTintColor: element.buttonStyle!.surfaceTintColor,
                  elevation: element.buttonStyle!.elevation,
                  textStyle: element.textStyle != null ? getGoogleFont(element.textStyle!.fontFamily).copyWith(
                    color: element.textStyle!.color,
                    letterSpacing: element.textStyle!.letterSpacing,
                    wordSpacing: element.textStyle!.wordSpacing,
                    fontWeight: element.textStyle!.fontWeight,
                    fontSize: element.textStyle!.fontSize,
                    fontStyle: element.textStyle!.fontStyle,
                    backgroundColor: element.textStyle!.backgroundColor,
                  ) : null,
                ) : null,
                onPressed: () async {
                  onItemClick(element, context);
                },
                child: Text(element.title),
              );
            }
          }
      ));
    });

    return list;
  }
}
