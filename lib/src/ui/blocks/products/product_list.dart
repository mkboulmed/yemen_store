import 'package:app/src/ui/products/product_cards/list/product_in_list.dart';
import './../../../models/blocks_model.dart';
import './../../../models/product_model.dart';
import './../../../ui/blocks/banners/banner_title.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;
  final Block block;
  const ProductList({Key? key, required this.products, required this.block}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyText2!;
    final Color captionColor = theme.textTheme.caption!.color!;
    TextStyle subtitleTextStyle =
    style.copyWith(color: captionColor, fontSize: 12.0);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    int count = widget.block.children.length;

    if(widget.block.products.length > 0 && widget.block.headerAlign != 'none') {
      count = widget.block.products.length + 1;
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {

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

            return ProductInList(product: widget.products[index]);
          },
          childCount: count,
        ),
      ),
    );
  }
}
