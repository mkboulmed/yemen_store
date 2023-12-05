import 'package:card_swiper/card_swiper.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';

import 'on_click.dart';

class BannerSlider extends StatefulWidget {
  final Block block;
  BannerSlider({Key? key, required this.block}) : super(key: key);
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
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
                      child: BannerTitle(block: widget.block)
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, widget.block.blockPadding.top, 0, widget.block.blockPadding.bottom),
                    height: widget.block.childHeight + widget.block.blockPadding.top + widget.block.blockPadding.bottom,
                    child: Swiper(
                      containerHeight: widget.block.childHeight,
                        containerWidth: widget.block.childWidth,
                      itemWidth: widget.block.childWidth,
                        itemHeight: widget.block.childHeight,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          splashColor: widget.block.backgroundColor,
                          onTap: () {
                            onItemClick(widget.block.children[index], context);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
                            ),
                            margin: EdgeInsets.all(widget.block.mainAxisSpacing),
                            elevation: widget.block.elevation.toDouble(),
                            clipBehavior: Clip.antiAlias,
                            child:  CachedNetworkImage(
                              imageUrl: widget.block.children[index].image,
                              imageBuilder: (context, imageProvider) => Ink.image(
                                child: InkWell(
                                    splashColor: widget.block.backgroundColor.withOpacity(0.1),
                                    onTap: () {
                                      onItemClick(widget.block.children[index], context);
                                    }),
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              placeholder: (context, url) =>
                                  Container(color: Colors.black12),
                              errorWidget: (context, url, error) => Container(color: Colors.black12),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.block.children.length,
                        pagination: buildSwiperPagination(),
                        autoplay: widget.block.blockSettings?.autoplay == false ? false : true,
                        layout: widget.block.blockSettings != null ? widget.block.blockSettings!.swiperLayout : SwiperLayout.DEFAULT,
                        indicatorLayout: widget.block.blockSettings?.indicatorLayout != null ? widget.block.blockSettings!.indicatorLayout : PageIndicatorLayout.NONE,//PageIndicatorLayout.SCALE,
                        autoplayDelay: widget.block.blockSettings?.autoplayDelay != null ? widget.block.blockSettings!.autoplayDelay : 7000,
                        //loop: widget.block.blockSettings?.loop == false ? false : true,
                        control: widget.block.blockSettings?.control == false ? null : SwiperControl(),
                        fade: widget.block.blockSettings != null ? widget.block.blockSettings?.fade : 1,
                        viewportFraction: widget.block.blockSettings?.viewportFraction != null && widget.block.blockSettings?.viewportFraction != 0 ? widget.block.blockSettings!.viewportFraction : 1
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

  SwiperPagination buildSwiperPagination() {
    if(widget.block.blockSettings?.pagination == 'STYLE1') {
      return SwiperPagination(
          margin: EdgeInsets.fromLTRB(0,0,0,widget.block.mainAxisSpacing + 4),
          alignment: widget.block.blockSettings?.alignment == null ? Alignment.bottomCenter : widget.block.blockSettings?.alignment,
          builder: widget.block.blockSettings?.swiperPagination != null ? widget.block.blockSettings!.swiperPagination : SwiperPagination.dots
      );
    } else if(widget.block.blockSettings?.pagination == 'STYLE2') {
      return new SwiperPagination(
          margin: new EdgeInsets.all(0.0),
          builder: new SwiperCustomPagination(builder:
              (BuildContext context, SwiperPluginConfig config) {
            return new ConstrainedBox(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: new Align(
                        alignment: widget.block.blockSettings?.alignment == null ? Alignment.bottomCenter : widget.block.blockSettings!.alignment,
                        child: new DotSwiperPaginationBuilder(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12,
                            size: 8.0,
                            activeSize: 10.0)
                            .build(context, config),
                      ),
                    )
                  ],
                ),
              ),
              constraints: new BoxConstraints.expand(height: 24.0),
            );
          }));
    } else if(widget.block.blockSettings?.pagination == 'STYLE3') {
      return new SwiperPagination(
          margin: new EdgeInsets.all(4.0),
          builder: new SwiperCustomPagination(builder:
              (BuildContext context, SwiperPluginConfig config) {
            return new ConstrainedBox(
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: new Align(
                      alignment: widget.block.blockSettings?.alignment == null ? Alignment.bottomCenter : widget.block.blockSettings!.alignment,
                      child: new DotSwiperPaginationBuilder(
                          size: 6.0,
                          activeSize: 10.0)
                          .build(context, config),
                    ),
                  )
                ],
              ),
              constraints: new BoxConstraints.expand(height: 50.0),
            );
          }));
    } else return SwiperPagination(
        margin: EdgeInsets.fromLTRB(0,0,0,widget.block.mainAxisSpacing + 4),
        alignment: widget.block.blockSettings?.alignment == null ? Alignment.bottomCenter : widget.block.blockSettings?.alignment,
        builder: widget.block.blockSettings?.swiperPagination != null ? widget.block.blockSettings!.swiperPagination : SwiperPagination.dots
    );
  }
}
