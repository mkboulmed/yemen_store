import 'dart:ui';

import 'package:app/src/functions.dart';
import '../banners/on_click.dart';
import '../../../../src/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';
import '../banners/banner_title.dart';


class CategoryGrid extends StatefulWidget {
  final Block block;
  final List<Category> categories;
  final String? type;
  const CategoryGrid({Key? key, required this.block, required this.categories, this.type}) : super(key: key);
  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double mainAxisSpacingTop = widget.block.mainAxisSpacing;
    if(widget.block.headerAlign != 'none') {
      mainAxisSpacingTop = 0;
    }

    return widget.categories.length > 0 ? SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
        child: widget.block.horizontal ? Container(
          margin: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
          child: Container(
            color: isDark ? Colors.transparent : widget.block.backgroundColor,
            padding: EdgeInsets.only(top: widget.block.blockPadding.top),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: widget.block.blockPadding.left, right: widget.block.blockPadding.right),
                    child: BannerTitle(block: widget.block)),
                Container(
                  height: widget.block.childHeight,
                  child: CategoryCardHorizontal(categories: widget.categories, block: widget.block, type: widget.type),
                )
              ],
            ),
          ),
        ) : Container(
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          padding: EdgeInsets.fromLTRB(widget.block.mainAxisSpacing, mainAxisSpacingTop, widget.block.mainAxisSpacing, widget.block.mainAxisSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  itemCount: widget.categories.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return CategoryCardStyle(category: widget.categories[index], block: widget.block, type: widget.type);
                  }),
            ],
          ),
        ),
      ),
    ) : SliverToBoxAdapter();
  }
}

class CategoryCardHorizontal extends StatefulWidget {
  final Block block;
  final List<Category> categories;
  final String? type;
  const CategoryCardHorizontal({Key? key, required this.block, required this.categories, this.type}) : super(key: key);

  @override
  State<CategoryCardHorizontal> createState() => _CategoryCardHorizontalState();
}

class _CategoryCardHorizontalState extends State<CategoryCardHorizontal> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    final TextStyle? style = theme.textTheme.bodyText1;
    final Color? captionColor = theme.textTheme.bodyText1!.color;
    TextStyle subtitleTextStyle = style!.copyWith(color: captionColor, fontSize: 12.0);

    return GridView.count(
        primary: false,
        crossAxisSpacing: widget.block.crossAxisSpacing,
        mainAxisSpacing: widget.block.mainAxisSpacing,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        childAspectRatio: widget.block.childAspectRatio,
        padding: EdgeInsets.fromLTRB(widget.block.blockPadding.left, 0, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
        crossAxisCount: widget.block.crossAxisCount,
        children: widget.categories.map((element) {
          switch(widget.block.style) {
            case 'STYLE1': {
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(0),
                elevation: widget.block.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(element, context);
                    } else {
                      onCategoryClick(element, context);
                    }
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: element.image,
                        placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                        errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 4),
                      Text(parseHtmlString(element.name), maxLines: 3, style: subtitleTextStyle, textAlign: TextAlign.center,),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            }
            case 'STYLE2': {
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(0),
                elevation: widget.block.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(element, context);
                    } else {
                      onCategoryClick(element, context);
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: element.image,
                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                    errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
            case 'STYLE3': {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(0),
                      elevation: widget.block.elevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.block.borderRadius),
                      ),
                      child: InkWell(
                        radius: widget.block.borderRadius,
                        onTap: () async {
                          if(widget.type == 'brand') {
                            onBrandClick(element, context);
                          } else {
                            onCategoryClick(element, context);
                          }
                        },
                        child: CachedNetworkImage(
                          imageUrl: element.image,
                          placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                          errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      //height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.block.borderRadius),
                        //border: Border.all(width: 5.0, color: Colors.white),
                      ),
                      child: new BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.block.borderRadius),
                            gradient: new LinearGradient(
                                colors: [Colors.black54, Colors.black38],
                                begin: Alignment.bottomCenter,
                                end: new Alignment(0.0, 0.0),
                                tileMode: TileMode.clamp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.block.borderRadius),
                    ),
                    //height: height,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(parseHtmlString(element.name), style: widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : null, maxLines: 2, textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            case 'STYLE4': {
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(0),
                elevation: widget.block.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(element, context);
                    } else {
                      onCategoryClick(element, context);
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: element.image,
                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                    errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
            default: {
              return Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(0),
                elevation: widget.block.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.block.borderRadius),
                ),
                child: InkWell(
                  radius: widget.block.borderRadius,
                  onTap: () async {
                    if(widget.type == 'brand') {
                      onBrandClick(element, context);
                    } else {
                      onCategoryClick(element, context);
                    }
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: element.image,
                        placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                        errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 4),
                      Text(parseHtmlString(element.name), maxLines: 3, style: subtitleTextStyle, textAlign: TextAlign.center,),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            }
          }
        }).toList()//_buildBlockList(),
    );
  }
}

class CategoryCardStyle extends StatefulWidget {
  final Block block;
  final Category category;
  final String? type;
  const CategoryCardStyle({Key? key, required this.block, required this.category, this.type}) : super(key: key);

  @override
  State<CategoryCardStyle> createState() => _CategoryCardStyleState();
}

class _CategoryCardStyleState extends State<CategoryCardStyle> {
  @override
  Widget build(BuildContext context) {
    print(widget.block.style);
    switch(widget.block.style) {
      case 'STYLE1': {
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
        );
      }

      case 'STYLE2': {
        return Column(
          children: [
            Card(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  child: Text(parseHtmlString(widget.category.name), style: widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : null, maxLines: 2, textAlign: TextAlign.center),
                ),
              ),
            )
          ],
        );
      }

      case 'STYLE3': {
        return Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0),
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
        );
      }

      case 'STYLE4': {
        return Card(
          //color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0),
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
        );
      }

      default: {
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
        );
      }
    }

  }
}
