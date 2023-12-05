import 'package:app/src/models/product_model.dart';
import 'package:app/src/ui/products/product_cards/product_card.dart';
import 'package:app/src/ui/products/product_cards/list/product_in_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  const ProductListPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return List of Booking Products
    //return BookingProductList(products: products);

    //return FoodProductList(products: products);

    //return GroceryProductGrid(products: products);

    return SliverPadding(
      padding: const EdgeInsets.all(4.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return ProductList(product: products[index]);
          },
          // 40 list items
          childCount: products.length,
        ),
      ),
    );

  }
}

class ProductGridPage extends StatelessWidget {
  final List<Product> products;
  const ProductGridPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Return List of Booking Products
    //return ServiceProductList(products: products);

    //Return List of Booking Products
    //return GroceryProductGrid(products: products);

    //return FoodProductList(products: products);

    //Return List of Booking Products
    //return BookingProductList(products: products);

    //Add More Product List Pages as necessary
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 180).toInt(),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(1);
        },
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        itemCount: products.length,
      ),
    );
  }
}
