import 'package:app/src/models/app_state_model.dart';
import 'package:app/src/ui/products/product_cards/grid/general_product_in_grid.dart';
import 'package:app/src/models/product_model.dart';
import 'package:app/src/ui/products/product_cards/grid/product_in_grid.dart';
import 'package:app/src/ui/products/product_cards/list/general_product_in_list.dart';
import 'package:app/src/ui/products/product_cards/list/product_in_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
      switch (model.blocks.settings.productCard) {
        case 'STYLE1':
          return ProductInGrid(product: product);
        case 'STYLE2':
          return GeneralProductInGrid(product: product);
        default:
          return ProductInGrid(product: product);
      }
    });
  }
}

class ProductList extends StatelessWidget {
  final Product product;
  const ProductList({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          switch (model.blocks.settings.productCard) {
            case 'STYLE1':
              return ProductInList(product: product);
            case 'STYLE2':
              return GeneralProductInList(product: product);
            default:
              return ProductInList(product: product);
          }
        });
  }
}
