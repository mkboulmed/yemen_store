import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/category_model.dart';
import '../../../../src/functions.dart';
import '../../../../src/models/blocks_model.dart';
import '../banners/banner_title.dart';
import '../banners/on_click.dart';

class CategoryScroll extends StatefulWidget {
  final Block block;
  final List<Category> categories;
  final String? type;
  const CategoryScroll({Key? key, required this.block, required this.categories, this.type}) : super(key: key);
  @override
  _CategoryScrollState createState() => _CategoryScrollState();
}

class _CategoryScrollState extends State<CategoryScroll> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final Color captionColor = theme.textTheme.caption!.color!;

    //final tileTheme = ListTileTheme.of(context);
    //final Color color = tileTheme.textColor!;
    TextStyle titleStyle = theme.textTheme.subtitle1!.copyWith(fontSize: 12);
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
                    child: BannerTitle(block: widget.block)),
                Container(
                  height: widget.block.childHeight + 34,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {

                      Widget title = Text(parseHtmlString(widget.categories[index].name), maxLines: 1, style: titleStyle);

                      double marginLast = (index + 1) == widget.categories.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
                      double marginFirst = index == 0 ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;

                      final Widget titleText = AnimatedDefaultTextStyle(
                        style: titleStyle,
                        duration: kThemeChangeDuration,
                        maxLines: 2,
                        child: title,
                        textAlign: TextAlign.center,
                      );

                      return CategoryCardStyle(category: widget.categories[index], block: widget.block, marginLast: marginLast, marginFirst: marginFirst, type: widget.type);/*Container(
                        width: widget.block.childWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: Colors.transparent,
                              clipBehavior: Clip.antiAlias,
                              elevation: widget.block.elevation,
                              margin: EdgeInsets.fromLTRB(marginFirst, 0, marginLast, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.block.borderRadius),
                              ),
                              child: InkWell(
                                radius: widget.block.borderRadius,
                                onTap: () {
                                  if(widget.type == 'brand') {
                                    onBrandClick(widget.categories[index], context);
                                  } else {
                                    onCategoryClick(widget.categories[index], context);
                                  }
                                },
                                child: Container(
                                  height: widget.block.childHeight,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.categories[index].image,
                                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.05),),
                                    errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.05),),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: widget.block.childWidth,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                  child: titleText,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      );*/
                    },
                    itemCount: widget.categories.length,
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

class CategoryCardStyle extends StatefulWidget {
  final Block block;
  final Category category;
  final double marginLast;
  final double marginFirst;
  final String? type;
  const CategoryCardStyle({Key? key, required this.block, required this.category, required this.marginLast, required this.marginFirst, this.type}) : super(key: key);

  @override
  State<CategoryCardStyle> createState() => _CategoryCardStyleState();
}

class _CategoryCardStyleState extends State<CategoryCardStyle> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    final tileTheme = ListTileTheme.of(context);
    final Color? color = tileTheme.textColor;
    TextStyle titleStyle = widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : theme.textTheme.bodyText1!.copyWith(color: color, fontSize: 12);
    bool isDark = Theme.of(context).brightness == Brightness.dark;



    Widget title = Text(parseHtmlString(widget.category.name), maxLines: 2, style: titleStyle);

    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: title,
    );


    switch(widget.block.style) {
      case 'STYLE1': {
        return Container(
          width: widget.block.childWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                elevation: widget.block.elevation,
                margin: EdgeInsets.fromLTRB(widget.marginFirst, 0, widget.marginLast, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(widget.category, context);
                    } else {
                      onCategoryClick(widget.category, context);
                    }
                  },
                  child: Container(
                    height: widget.block.childHeight,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.category.image,
                      placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.05),),
                      errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.05),),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: titleText,
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        );
      }

      case 'STYLE2': {
        return Container(
          width: widget.block.childWidth,
          child: Card(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            elevation: widget.block.elevation,
            margin: EdgeInsets.fromLTRB(widget.marginFirst, widget.block.crossAxisSpacing, widget.marginLast, widget.block.crossAxisSpacing),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.block.borderRadius),
            ),
            child: InkWell(
              radius: widget.block.borderRadius,
              onTap: () async {
                if(widget.type == 'brand') {
                  onBrandClick(widget.category, context);
                } else {
                  onCategoryClick(widget.category, context);
                }
              },
              child: Container(
                height: widget.block.childHeight,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.category.image,
                  placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.05),),
                  errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.05),),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }

      case 'STYLE3': {
        return Container(
          width: widget.block.childWidth,
          child: Card(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.fromLTRB(widget.marginFirst, widget.block.crossAxisSpacing, widget.marginLast, widget.block.crossAxisSpacing),
            elevation: widget.block.elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.block.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    radius: widget.block.borderRadius,
                    onTap: () async {
                      if(widget.type == 'brand') {
                        onBrandClick(widget.category, context);
                      } else {
                        onCategoryClick(widget.category, context);
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.category.image,
                      placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                      errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  //height: height,
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [Colors.black54, Colors.black38],
                            begin: Alignment.bottomCenter,
                            end: new Alignment(0.0, 0.0),
                            tileMode: TileMode.clamp),
                      ),
                    ),
                  ),
                ),
                Container(
                  //height: height,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(parseHtmlString(widget.category.name), style: widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : null, maxLines: 2, textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }

      case 'STYLE4': {
        return Container(
          width: widget.block.childWidth,
          child: Card(
            //color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.fromLTRB(widget.marginFirst, widget.block.crossAxisSpacing, widget.marginLast, widget.block.crossAxisSpacing),
            elevation: widget.block.elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.block.borderRadius),
            ),
            child: InkWell(
              onTap: () async {
                if(widget.type == 'brand') {
                  onBrandClick(widget.category, context);
                } else {
                  onCategoryClick(widget.category, context);
                }
              },
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.category.image,
                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                    errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        child: Text(parseHtmlString(widget.category.name), style: widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : null, maxLines: 2, textAlign: TextAlign.center),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }

      default: {
        return Container(
          width: widget.block.childWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                elevation: widget.block.elevation,
                margin: EdgeInsets.fromLTRB(widget.marginFirst, 0, widget.marginLast, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(widget.category, context);
                    } else {
                      onCategoryClick(widget.category, context);
                    }
                  },
                  child: Container(
                    height: widget.block.childHeight,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.category.image,
                      placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.05),),
                      errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.05),),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: titleText,
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        );
      }
    }

  }
}
