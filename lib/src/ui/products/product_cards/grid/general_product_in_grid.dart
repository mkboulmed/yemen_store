import 'package:app/src/ui/blocks/products/percent_off.dart';
import 'package:app/src/ui/blocks/products/product_image.dart';
import 'package:app/src/ui/blocks/products/wishlist_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../blocks/products/product_ratting.dart';
import '../../product_detail/product_detail.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../../models/app_state_model.dart';
import '../../../../models/product_model.dart';
import '../../products_widgets/price_widget.dart';
import '../../../../functions.dart';
import '../../products/add_to_cart.dart';
import '../../products/product_label.dart';

class GeneralProductInGrid extends StatefulWidget {
  final Product product;
  const GeneralProductInGrid({Key? key, required this.product}) : super(key: key);
  @override
  _GeneralProductInGridState createState() => _GeneralProductInGridState();
}

class _GeneralProductInGridState extends State<GeneralProductInGrid> {

  AvailableVariation? _selectedVariation;
  int percentOff = 0;

  @override
  void initState() {
    if(widget.product.availableVariations.length > 0) {
      _selectedVariation = widget.product.availableVariations.first;
    }
    if ((widget.product.salePrice != 0)) {
      percentOff = (((widget.product.regularPrice - widget.product.salePrice) / widget.product.regularPrice) * 100).round();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScopedModelDescendant<AppStateModel>(
            builder: (context, child, model) {
              return Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onProductClick(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                                constraints: new BoxConstraints(
                                  minHeight: (MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width ~/ 180).toInt()) - ( 2 * 4),
                                ),
                                child: ProductCachedImage(imageUrl:  widget.product.images[0].src)
                            ),
                            Positioned(
                              left: 8,
                              top: 12,
                              child: ProductLabel(widget.product.tags),
                            ),
                            WishListIconPositioned(id: widget.product.id)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                          child: Text(parseHtmlString(widget.product.name), style: TextStyle(
                            fontSize: 13.5,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(alignment: AlignmentDirectional.centerStart, child: PriceWidget(product: widget.product)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(widget.product.tags.contains('express'))
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0),
                                ),
                                child: Container(
                                  width: 65,
                                  height: 20,
                                  color: Colors.yellow,
                                  child: Center(
                                    child: Text(
                                      'express',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.lightGreen.shade600,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.product.averageRating,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          (Icons.star),
                                          size: 13,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                      child: Text(
                                        '('+widget.product.ratingCount.toString()+')',
                                        style: TextStyle(color: Colors.grey),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ));
            }
        ),
      ],
    );
  }

  Future<Product?> _selectVariant(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            //backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            elevation: 4,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.product.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    //color: Colors.black,
                    fontWeight: FontWeight.w600,
                    //letterSpacing: 1
                  ),
                ),
              ],
            ),
            children: _buildVariationList(),
          );
        });
  }

  _buildVariationList() {
    List<Widget> list = [];
    widget.product.availableVariations.forEach((element) {
      list.add(
        element.isInStock ? buildSimpleDialog(context, element) : Container(),
      );
    });
    return list;
  }

  Widget buildSimpleDialog(BuildContext context, AvailableVariation? variation) {
    return variation != null ? Container(
      color: _selectedVariation == variation ? Theme.of(context).colorScheme.secondary : Colors.transparent,
      child: Center(
        child: SimpleDialogOption(
          onPressed: () {
            setState(() {
              _selectedVariation = variation;
            });
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(getTitle(variation) , style:TextStyle(
                        fontSize: 12,
                        color: _selectedVariation == variation ? Theme.of(context).colorScheme.onSecondary : null
                    ),),
                  ),
                  _variationPrice(variation),
                ]
            ),
          ),
        ),
      ),
    ) : Container();
  }

  getTitle(AvailableVariation? variation) {
    var name = '';
    if(variation != null)
      for (var value in variation.option) {
        if(value.value.isNotEmpty)
          name = name + value.value + ' ';
      }
    return name;
  }

  _variationPrice(AvailableVariation variation) {
    if(variation.formattedPrice != null && variation.formattedSalesPrice == null) {
      return Text(parseHtmlString(variation.formattedPrice!), style: TextStyle(
        fontWeight: FontWeight.bold,
        color: _selectedVariation == variation ? Theme.of(context).colorScheme.onSecondary : Colors.black38,
      ));
    } else if(variation.formattedPrice != null && variation.formattedSalesPrice != null) {
      return Row(
        children: [
          Text(parseHtmlString(variation.formattedSalesPrice!), style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _selectedVariation == variation ? Theme.of(context).colorScheme.onSecondary : Colors.black
          )),
          SizedBox(width: 4),
          Text(parseHtmlString(variation.formattedPrice!), style: TextStyle(
            fontSize: 10,
            decoration: TextDecoration.lineThrough,
            color: _selectedVariation == variation ? Theme.of(context).colorScheme.onSecondary.withOpacity(0.7) : Colors.black38,
          )),
        ],
      );
    } else return Container();
  }

  onProductClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDetail(product: widget.product);
    }));
  }
}

class PriceWidget extends StatelessWidget {
  PriceWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  int percentOff = 0;

  @override
  Widget build(BuildContext context) {

    if ((product.salePrice != 0)) {
      percentOff = (((product.regularPrice - product.salePrice) / product.regularPrice) * 100).round();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if(product.onSale && product.formattedSalesPrice != null && product.formattedSalesPrice!.isNotEmpty)
          Text(parseHtmlString(product.formattedSalesPrice!),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
        Row(
          children: [
            Text(parseHtmlString(product.formattedPrice!),
                style: product.onSale && product.formattedSalesPrice != null ? Theme.of(context).textTheme.bodyText1!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Theme.of(context).textTheme.caption!.color,
                    decorationColor: Theme.of(context).textTheme.caption!.color
                ) : Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )
            ),
            product.onSale && product.formattedSalesPrice != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                percentOff.toString() + '% ' + AppStateModel().blocks.localeText.off,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.green,
                ),
              ),
            ) : Container()
          ],
        ),
      ],
    );
  }
}

class ProductLabel extends StatelessWidget {
  ProductLabel(this.tags);
  final List<String> tags;
  @override
  Widget build(BuildContext context) {

    List<String> output = tags.where((element) => AppStateModel().blocks.settings.labels.contains(element.toString())).toList();
    return output.length > 0 ? Container(
        height: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              output[0],
              style: TextStyle(
                  color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black87.withOpacity(0.7),
        )) : Container();
  }
}