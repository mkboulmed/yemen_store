import 'package:app/src/ui/products/product_cards/product_card.dart';
import './../../../models/blocks_model.dart';
import './../../../models/product_model.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import 'package:flutter/material.dart';

class ProductBlockGrid extends StatefulWidget {
  final Block block;
  final List<Product> products;
  const ProductBlockGrid({Key? key, required this.block, required this.products}) : super(key: key);
  @override
  _ProductBlockGridState createState() => _ProductBlockGridState();
}

class _ProductBlockGridState extends State<ProductBlockGrid> {
  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    double mainAxisSpacingTop = widget.block.mainAxisSpacing;
    if(widget.block.headerAlign != 'none') {
      mainAxisSpacingTop = 0;
    }

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
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
                    padding: EdgeInsets.only(left: widget.block.blockPadding.left, right: widget.block.blockPadding.right),
                    crossAxisCount: widget.block.crossAxisCount,
                    children: widget.products.map((e) => ProductCard(product: e)).toList(),//widget.products//_buildBlockList(),
                  ),
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
                  itemCount: widget.products.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ProductCard(product: widget.products[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
