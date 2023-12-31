import 'dart:ui';
import 'package:app/src/functions.dart';
import 'package:card_swiper/card_swiper.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/category_model.dart';
import '../banners/on_click.dart';
import '../../../../src/models/blocks_model.dart';

class CategorySlider extends StatefulWidget {
  final Block block;
  final List<Category> categories;
  final String? type;
  CategorySlider({Key? key, required this.block, required this.categories, this.type}) : super(key: key);
  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double padding = widget.block.mainAxisSpacing == 0 ? 16 : widget.block.mainAxisSpacing;
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              color: isDark ? Colors.transparent : widget.block.backgroundColor,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                      child: BannerTitle(block: widget.block)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, widget.block.blockPadding.top, 0, widget.block.blockPadding.bottom),
                    height: widget.block.childHeight + widget.block.blockPadding.top + widget.block.blockPadding.bottom,
                    child: Swiper(
                      containerHeight: widget.block.childHeight,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          splashColor: widget.block.backgroundColor,
                          onTap: () {
                            if(widget.type == 'brand') {
                              onBrandClick(widget.categories[index], context);
                            } else {
                              onCategoryClick(widget.categories[index], context);
                            }
                          },
                          child: ImageCard(block: widget.block, category: widget.categories[index]),/*Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
                            ),
                            margin: EdgeInsets.all(widget.block.mainAxisSpacing),
                            elevation: widget.block.elevation.toDouble(),
                            clipBehavior: Clip.antiAlias,
                            child:  CachedNetworkImage(
                              imageUrl: widget.categories[index].image != null ? widget.categories[index].image : '',
                              imageBuilder: (context, imageProvider) => Ink.image(
                                child: InkWell(
                                  splashColor: widget.block.backgroundColor.withOpacity(0.1),
                                  onTap: () {
                                    if(widget.type == 'brand') {
                                      onBrandClick(widget.categories[index], context);
                                    } else {
                                      onCategoryClick(widget.categories[index], context);
                                    }
                                  },
                                ),
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              placeholder: (context, url) =>
                                  Container(color: Colors.black12),
                              errorWidget: (context, url, error) => Container(color: Colors.black12),
                            ),
                          ),*/
                        );
                      },
                      itemCount: widget.categories.length,
                      pagination: new SwiperPagination(
                          margin: EdgeInsets.fromLTRB(0,0,0,widget.block.mainAxisSpacing + 10)
                      ),
                      autoplay: true,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatefulWidget {
  const ImageCard({
    Key? key,
    required this.block,
    required this.category, this.type
  }) : super(key: key);

  final Block block;
  final Category category;
  final String? type;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {

    switch(widget.block.style) {
      case 'STYLE1': {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
          ),
          margin: EdgeInsets.all(widget.block.mainAxisSpacing),
          elevation: widget.block.elevation.toDouble(),
          clipBehavior: Clip.antiAlias,
          child:  CachedNetworkImage(
            imageUrl: widget.category.image != null ? widget.category.image : '',
            imageBuilder: (context, imageProvider) => Ink.image(
              child: InkWell(
                splashColor: widget.block.backgroundColor.withOpacity(0.1),
                onTap: () {
                  if(widget.type == 'brand') {
                    onBrandClick(widget.category, context);
                  } else {
                    onCategoryClick(widget.category, context);
                  }
                },
              ),
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            placeholder: (context, url) => Container(color: Colors.black12),
            errorWidget: (context, url, error) => Container(color: Colors.black12),
          ),
        );
      }

      case 'STYLE2': {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
          ),
          margin: EdgeInsets.all(widget.block.mainAxisSpacing),
          elevation: widget.block.elevation.toDouble(),
          clipBehavior: Clip.antiAlias,
          child:  Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: widget.category.image != null ? widget.category.image : '',
                  imageBuilder: (context, imageProvider) => Ink.image(
                    child: InkWell(
                      splashColor: widget.block.backgroundColor.withOpacity(0.1),
                      onTap: () {
                        if(widget.type == 'brand') {
                          onBrandClick(widget.category, context);
                        } else {
                          onCategoryClick(widget.category, context);
                        }
                      },
                    ),
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Container(color: Colors.black12),
                  errorWidget: (context, url, error) => Container(color: Colors.black12),
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

      case 'STYLE3': {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
          ),
          margin: EdgeInsets.all(widget.block.mainAxisSpacing),
          elevation: widget.block.elevation.toDouble(),
          clipBehavior: Clip.antiAlias,
          child:  Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: widget.category.image != null ? widget.category.image : '',
                  imageBuilder: (context, imageProvider) => Ink.image(
                    child: InkWell(
                      splashColor: widget.block.backgroundColor.withOpacity(0.1),
                      onTap: () {
                        if(widget.type == 'brand') {
                          onBrandClick(widget.category, context);
                        } else {
                          onCategoryClick(widget.category, context);
                        }
                      },
                    ),
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Container(color: Colors.black12),
                  errorWidget: (context, url, error) => Container(color: Colors.black12),
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
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  //height: height,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(parseHtmlString(widget.category.name), style: widget.block.textStyle != null ? getTextStyle(widget.block.textStyle!, context) : null, maxLines: 2, textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      default: {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
          ),
          margin: EdgeInsets.all(widget.block.mainAxisSpacing),
          elevation: widget.block.elevation.toDouble(),
          clipBehavior: Clip.antiAlias,
          child:  CachedNetworkImage(
            imageUrl: widget.category.image != null ? widget.category.image : '',
            imageBuilder: (context, imageProvider) => Ink.image(
              child: InkWell(
                splashColor: widget.block.backgroundColor.withOpacity(0.1),
                onTap: () {
                  if(widget.type == 'brand') {
                    onBrandClick(widget.category, context);
                  } else {
                    onCategoryClick(widget.category, context);
                  }
                },
              ),
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            placeholder: (context, url) => Container(color: Colors.black12),
            errorWidget: (context, url, error) => Container(color: Colors.black12),
          ),
        );
      }
    }
  }
}
