import 'package:app/src/ui/products/product_cards/product_card.dart';
import './../../../models/blocks_model.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import 'package:flutter/material.dart';
import '../../../functions.dart';
import './../../../models/product_model.dart';

class ProductCardScroll extends StatefulWidget {
  final List<Product> products;
  final Block block;
  const ProductCardScroll({Key? key, required this.products, required this.block}) : super(key: key);
  @override
  _ProductCardScrollState createState() => _ProductCardScrollState();
}

class _ProductCardScrollState extends State<ProductCardScroll> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyText2!;
    final Color captionColor = theme.textTheme.caption!.color!;
    TextStyle subtitleTextStyle =
    style.copyWith(color: captionColor, fontSize: 12.0);

    //final tileTheme = ListTileTheme.of(context);
    //final Color color = tileTheme.textColor!;
    TextStyle titleStyle = Theme.of(context).textTheme.bodyText2!;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double padding = widget.block.mainAxisSpacing == 0 ? 16 : widget.block.mainAxisSpacing;

    double mainAxisSpacingTop = widget.block.mainAxisSpacing;
    if(widget.block.headerAlign != 'none') {
      mainAxisSpacingTop = 0;
    }

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
                  height: widget.block.childHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Widget title = Text(parseHtmlString(widget.products[index].name), maxLines: 2, style: titleStyle);

                      double marginLast = (index + 1) == widget.block.children.length ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;
                      double marginFirst = index == 0 ? widget.block.mainAxisSpacing : widget.block.mainAxisSpacing / 2;

                      int percentOff = 0;
                      if ((widget.products[index].salePrice != 0)) {
                        percentOff = (((widget.products[index].regularPrice - widget.products[index].salePrice) / widget.products[index].regularPrice) * 100).round();
                      }

                      final Widget titleText = AnimatedDefaultTextStyle(
                        style: titleStyle,
                        duration: kThemeChangeDuration,
                        maxLines: 2,
                        child: title,
                      );
                      return Container(
                          //margin: EdgeInsets.fromLTRB(marginFirst, mainAxisSpacingTop, marginLast, widget.block.mainAxisSpacing),
                          width: widget.block.childWidth,
                          child: ProductCard(product: widget.products[index]));
                    },
                    itemCount: widget.products.length,
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

