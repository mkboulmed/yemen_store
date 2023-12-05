import 'package:app/src/functions.dart';
import 'package:app/src/ui/blocks/banners/count_down_time.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../src/models/blocks_model.dart';
import 'banner_title.dart';
import 'on_click.dart';

class BannerScroll extends StatefulWidget {
  final Block block;
  const BannerScroll({Key? key, required this.block}) : super(key: key);
  @override
  _BannerScrollState createState() => _BannerScrollState();
}

class _BannerScrollState extends State<BannerScroll> {
  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double padding = widget.block.mainAxisSpacing == 0 ? 16 : widget.block.mainAxisSpacing;

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: widget.block.blockPadding.top),
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          margin: EdgeInsets.all(0),
          child: widget.block.headerAlign == 'stack' ? Builder(
              builder: (context) {

                var dateTo = DateTime.parse(widget.block.saleEndDate);
                var dateFrom = DateTime.now();
                var difference = dateTo.difference(dateFrom).inSeconds;
                bool showCounter = !difference.isNegative && widget.block.flashSale == true;

                TextStyle titleStyle = Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light ? widget.block.titleColor : null
                );

                if(widget.block.titleStyle != null) {
                  titleStyle = getTextStyle(widget.block.titleStyle!, context);
                }

                return Stack(
                  children: [
                    Container(
                        height: widget.block.childHeight,
                        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.fromLTRB(0, 16, 0, widget.block.blockPadding.bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.block.showTitle == true ? SizedBox(width: 8) : SizedBox(width: 0),
                              widget.block.showTitle == true ? Text(
                                widget.block.title,
                                style: titleStyle,
                                textAlign: TextAlign.center,
                              ) : Container(),
                              if(showCounter)
                                CountDownTime(saleEndDate: widget.block.saleEndDate, block: widget.block),
                            ],
                          ),
                        )
                    ),
                    Container(
                      height: widget.block.childHeight,
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(widget.block.blockPadding.left, 0, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {


                          double marginLast = (index + 1) == widget.block.children.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
                          double marginFirst = index == 0 ? 160 : widget.block.mainAxisSpacing / 2;


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
                                  child: CachedNetworkImage(
                                    imageUrl: widget.block.children[index].image,
                                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                                    errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                                    fit: BoxFit.cover,
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
                );
              }
          ) : Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                  child: BannerTitle(block: widget.block)
              ),
              Container(
                height: widget.block.childHeight,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(widget.block.blockPadding.left, 0, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
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
                            child: CachedNetworkImage(
                              imageUrl: widget.block.children[index].image,
                              placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
                              errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
                              fit: BoxFit.cover,
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
    );
  }
}
