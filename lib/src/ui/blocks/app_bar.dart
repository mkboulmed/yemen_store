import 'dart:io';
import 'package:app/src/ui/accounts/login/login.dart';
import 'package:app/src/ui/accounts/wishlist.dart';
import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:app/src/ui/products/product_detail/cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import './../../models/app_state_model.dart';
import './../../models/blocks_model.dart';
import './../checkout/cart/cart4.dart';
import './../home/search.dart';
import './../products/barcode_products.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'header_logo.dart';

const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  width: 0.0,
);
const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

class CustomSliverAppBar extends StatefulWidget {
  final AppBarStyle appBarStyle;
  final Function onTapAddress;
  const CustomSliverAppBar({Key? key, required this.appBarStyle, required this.onTapAddress}) : super(key: key);
  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {

  Color? fillColor;

  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
        return Builder(
          builder: (context) {
            widget.appBarStyle.appBarType = 'STYLE5';
            switch (widget.appBarStyle.appBarType) {
              case 'STYLE1':
                return SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  stretch: false,
                  titleSpacing: 0,
                  leading: widget.appBarStyle.drawer ? null : widget.appBarStyle.logo ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HeaderLogo(),
                  ) : null, //Container(width: 8, child: HeaderLogo()),
                  title: Padding(
                    padding: widget.appBarStyle.drawer == false && widget.appBarStyle.logo == false ? EdgeInsetsDirectional.only(start: 32.0) : EdgeInsetsDirectional.all(0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          enableFeedback: false,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Search();
                            }));
                          },
                          child: CupertinoTextField(
                            enabled: false,
                            decoration: BoxDecoration(
                              color: CupertinoDynamicColor.withBrightness(
                                color: CupertinoColors.white,
                                darkColor: CupertinoColors.black,
                              ),
                              border: _kDefaultRoundedBorder,
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            prefix: Container(
                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: DunesIcon(iconString: model.blocks.settings.searchIcon, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : CupertinoColors.placeholderText),
                            ),
                            /*suffix: widget.appBarStyle.barcode ? Container(
                          height: 38,
                          child: IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ),
                        ) : Container(),*/
                            placeholder: model.blocks.localeText.search,
                            onChanged: (value) {

                            },
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 0,
                          child: widget.appBarStyle.barcode ? IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ) : Container(),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading, color: Theme.of(context).primaryIconTheme.color)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.wishListIcon ? IconButton(onPressed: () {
                      if(model.user.id == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WishList();
                        }));
                      }
                    }, icon: DunesIcon(iconString: model.blocks.settings.wishListIcon)) : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Search();
                      }));
                    }, icon: DunesIcon(iconString: model.blocks.settings.searchIcon)) : Container(width: 0),
                  ],
                );
              case 'STYLE2':
                return SliverAppBar(
                  expandedHeight: 100.0,
                  floating: true,
                  pinned: false,
                  snap: false,
                  stretch: false,
                  automaticallyImplyLeading: false,
                  title: HeaderLogo(),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(44.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Search();
                              }));
                            },
                            child: CupertinoTextField(
                              enabled: false,
                              decoration: BoxDecoration(
                                color: CupertinoDynamicColor.withBrightness(
                                  color: CupertinoColors.white,
                                  darkColor: CupertinoColors.black,
                                ),
                                border: _kDefaultRoundedBorder,
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefix: Container(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: DunesIcon(iconString: model.blocks.settings.searchIcon, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : CupertinoColors.placeholderText),
                              ),
                              /*suffix: widget.appBarStyle.barcode ? Container(
                          height: 38,
                          child: IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ),
                        ) : Container(),*/
                              placeholder: model.blocks.localeText.search,
                              onChanged: (value) {

                              },
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            child: widget.appBarStyle.barcode ? IgnorePointer(
                              ignoring: false,
                              child: IconButton(
                                  onPressed: () {
                                    _barCodeScan(context);
                                  },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                              ),
                            ) : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading/*, color: Theme.of(context).primaryIconTheme.color*/)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.wishListIcon ? IconButton(onPressed: () {
                      if(model.user.id == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WishList();
                        }));
                      }
                    }, icon: DunesIcon(iconString: model.blocks.settings.wishListIcon)) : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Search();
                      }));
                    }, icon: DunesIcon(iconString: model.blocks.settings.searchIcon)) : Container(width: 0),
                  ],
                );
              case 'STYLE3':
                return SliverAppBar(
                  expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  snap: false,
                  stretch: false,
                  automaticallyImplyLeading: false,
                  title: HeaderLogo(),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(44.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Search();
                              }));
                            },
                            child: CupertinoTextField(
                              enabled: false,
                              decoration: BoxDecoration(
                                color: CupertinoDynamicColor.withBrightness(
                                  color: CupertinoColors.white,
                                  darkColor: CupertinoColors.black,
                                ),
                                border: _kDefaultRoundedBorder,
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefix: Container(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: DunesIcon(iconString: model.blocks.settings.searchIcon, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : CupertinoColors.placeholderText),
                              ),
                              /*suffix: widget.appBarStyle.barcode ? Container(
                          height: 38,
                          child: IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ),
                        ) : Container(),*/
                              placeholder: model.blocks.localeText.search,
                              onChanged: (value) {

                              },
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            child: widget.appBarStyle.barcode ? IgnorePointer(
                              ignoring: false,
                              child: IconButton(
                                  onPressed: () {
                                    _barCodeScan(context);
                                  },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                              ),
                            ) : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading, color: Theme.of(context).primaryIconTheme.color)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.wishListIcon ? IconButton(onPressed: () {
                      if(model.user.id == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WishList();
                        }));
                      }
                    }, icon: DunesIcon(iconString: model.blocks.settings.wishListIcon)) : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Search();
                      }));
                    }, icon: DunesIcon(iconString: model.blocks.settings.searchIcon)) : Container(width: 0),
                  ],
                );
              case 'STYLE4':
                return SliverAppBar(
                  expandedHeight: 100.0,
                  floating: true,
                  pinned: true,
                  snap: false,
                  stretch: false,
                  automaticallyImplyLeading: false,
                  title: HeaderLogo(),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Search();
                              }));
                            },
                            child: CupertinoTextField(
                              enabled: false,
                              decoration: BoxDecoration(
                                color: CupertinoDynamicColor.withBrightness(
                                  color: CupertinoColors.white,
                                  darkColor: CupertinoColors.black,
                                ),
                                border: _kDefaultRoundedBorder,
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefix: Container(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: DunesIcon(iconString: model.blocks.settings.searchIcon, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : CupertinoColors.placeholderText),
                              ),
                              /*suffix: widget.appBarStyle.barcode ? Container(
                          height: 38,
                          child: IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ),
                        ) : Container(),*/
                              placeholder: model.blocks.localeText.search,
                              onChanged: (value) {

                              },
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            child: widget.appBarStyle.barcode ? IgnorePointer(
                              ignoring: false,
                              child: IconButton(
                                  onPressed: () {
                                    _barCodeScan(context);
                                  },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                              ),
                            ) : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading, color: Theme.of(context).primaryIconTheme.color)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.wishListIcon ? IconButton(onPressed: () {
                      if(model.user.id == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WishList();
                        }));
                      }
                    }, icon: DunesIcon(iconString: model.blocks.settings.wishListIcon)) : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Search();
                      }));
                    }, icon: DunesIcon(iconString: model.blocks.settings.searchIcon)) : Container(width: 0),
                  ],
                );
              case 'STYLE5':
                return SliverAppBar(
                  centerTitle: false,
                  //automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: widget.appBarStyle.drawer ? null : widget.appBarStyle.barcode ? Icon(CupertinoIcons.barcode_viewfinder) : null,
                  title: Padding(
                    padding: widget.appBarStyle.barcode || widget.appBarStyle.drawer ? EdgeInsetsDirectional.only(start: 0.0) : EdgeInsetsDirectional.only(start: 16.0),
                    child: widget.appBarStyle.logo ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: HeaderLogo(),
                    ) : buildHomeTitle(context),
                  ),
                  expandedHeight: !widget.appBarStyle.location ? null : 110,
                  flexibleSpace: widget.appBarStyle.location ? FlexibleSpaceBar(
                    background: Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: Container(
                              color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                                child: InkWell(
                                  onTap: () async {
                                    widget.onTapAddress();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.mapMarkerAlt),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Expanded(
                                          //width: MediaQuery.of(context).size.width - 110,
                                          child: Builder(
                                            builder: (context) {
                                              if (model.customerLocation['address'] != null)
                                                return Text(model.customerLocation['address'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                                                    fontSize: 14
                                                ));
                                              else
                                                return Text(model.blocks.localeText.selectLocation, style: TextStyle(
                                                    fontSize: 14
                                                ));
                                            }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : null,
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      icon: Icon(FlutterRemix.search_2_line),) : Container(width: 0),
                    (widget.appBarStyle.cart || widget.appBarStyle.searchIcon) ? Container() : Container(width: 16)
                  ],
                );
              case 'STYLE6':
                return SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: false,
                  titleSpacing: 0,
                  centerTitle: false,
                  expandedHeight: widget.appBarStyle.searchBar ? 110 : 0,
                  title: widget.appBarStyle.logo ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: HeaderLogo(),
                  ) : InkWell(
                    onTap: () async {
                      widget.onTapAddress();
                    },
                    child: model.blocks.settings.geoLocation ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.mapMarkerAlt),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            //width: MediaQuery.of(context).size.width - 110,
                              child: model.customerLocation['address'] != null ? Text(model.customerLocation['address'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                                  fontSize: 14
                              )) : Text(model.blocks.localeText.selectLocation, style: TextStyle(
                                  fontSize: 14
                              ))
                          ),
                        ],
                      ),
                    ) : Container(),
                  ),
                  flexibleSpace: widget.appBarStyle.searchBar ? FlexibleSpaceBar(
                    background: Column(
                      children: <Widget>[
                        SizedBox(height: Platform.isIOS ? 96.0 : 80.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {

                            },
                            child: buildHomeTitle(context),
                          ),
                        ),
                      ],
                    ),
                  ) : null,
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      icon: Icon(FlutterRemix.search_2_line),) : Container(width: 0),
                    (widget.appBarStyle.cart || widget.appBarStyle.searchIcon) ? Container() : Container(width: 16)
                  ],
                );
              case 'STYLE7':
                return SliverAppBar(
                  //automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  snap: false,
                  titleSpacing: 0,
                  //elevation: 1.0,
                  centerTitle: false,
                  expandedHeight: widget.appBarStyle.searchBar ? 110 : 0,
                  title: widget.appBarStyle.logo ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: HeaderLogo(),
                  ) : InkWell(
                    onTap: () async {
                      widget.onTapAddress();
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.mapMarkerAlt),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 155,
                            child: Builder(
                                builder: (context) {
                                  if (model.customerLocation['address'] != null)
                                    return Text(model.customerLocation['address'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                                        fontSize: 14
                                    ));
                                  else
                                    return Text(model.blocks.localeText.selectLocation, style: TextStyle(
                                        fontSize: 14
                                    ));
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  flexibleSpace: widget.appBarStyle.searchBar ? FlexibleSpaceBar(
                    background: Column(
                      children: <Widget>[
                        SizedBox(height: Platform.isIOS ? 96.0 : 80.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {

                            },
                            child: buildCupertinoSearchFiled(context),
                          ),
                        ),
                      ],
                    ),
                  ) : null,
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.searchIcon ?
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      icon: Icon(FlutterRemix.search_2_line),) : Container(width: 0),
                    (widget.appBarStyle.cart || widget.appBarStyle.searchIcon) ? Container() : Container(width: 16)
                  ],
                );
              case 'STYLE8':
                return SliverAppBar(
                  centerTitle: false,
                  pinned: true,
                  floating: true,
                  snap: false,
                  //automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: widget.appBarStyle.drawer ? null : widget.appBarStyle.barcode ? IconButton(
                      onPressed: () { _barCodeScan(context); },
                      icon: Icon(CupertinoIcons.barcode_viewfinder)) : null,
                  title: Padding(
                    padding: widget.appBarStyle.barcode || widget.appBarStyle.drawer ? EdgeInsetsDirectional.only(start: 0.0) : EdgeInsetsDirectional.only(start: 16.0),
                    child: widget.appBarStyle.logo ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: HeaderLogo(),
                    ) : InkWell(
                      borderRadius: BorderRadius.circular(15),
                      enableFeedback: false,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      child: InkWell(
                        borderRadius: BorderRadius.circular(0),
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Search();
                          }));
                        },
                        child: CupertinoTextField(
                          keyboardType: TextInputType.text,
                          placeholder: AppStateModel().blocks.localeText.searchProducts,
                          placeholderStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Theme.of(context).textTheme.caption!.color
                          ),
                          enabled: false,
                          prefix: Padding(
                            padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.6),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: widget.appBarStyle.location ? 110 : null,
                  flexibleSpace: widget.appBarStyle.location ? FlexibleSpaceBar(
                    background: Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                                child: InkWell(
                                  onTap: () async {
                                    widget.onTapAddress();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.mapMarkerAlt),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Expanded(
                                          //width: MediaQuery.of(context).size.width - 110,
                                          child: Builder(
                                              builder: (context) {
                                                if (model.customerLocation['address'] != null)
                                                  return Text(model.customerLocation['address'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                                                      fontSize: 14
                                                  ));
                                                else
                                                  return Text(model.blocks.localeText.selectLocation, style: TextStyle(
                                                      fontSize: 14
                                                  ));
                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : null,
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading)),
                    widget.appBarStyle.cart ?
                    CartIcon() : Container(width: 0),widget.appBarStyle.searchIcon ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      icon: Icon(FlutterRemix.search_2_line),) : Container(width: 0),
                    (widget.appBarStyle.cart || widget.appBarStyle.searchIcon) ? Container() : Container(width: 16)
                  ],
                );
              case 'STYLE9':
                return SliverAppBar(
                  centerTitle: false,
                  //automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  //leading: widget.appBarStyle.barcode ? Icon(CupertinoIcons.barcode_viewfinder) : null,
                  title: Padding(
                    padding: widget.appBarStyle.barcode || widget.appBarStyle.drawer ? EdgeInsetsDirectional.only(start: 0.0) : EdgeInsetsDirectional.only(start: 16.0),
                    child: widget.appBarStyle.logo ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: HeaderLogo(),
                    ) : InkWell(
                      borderRadius: BorderRadius.circular(15),
                      enableFeedback: false,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            enableFeedback: false,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Search();
                              }));
                            },
                            child: CupertinoTextField(
                              keyboardType: TextInputType.text,
                              placeholder: model.blocks.localeText.searchProducts,
                              placeholderStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Theme.of(context).textTheme.caption!.color
                              ),
                              enabled: false,
                              prefix: Padding(
                                padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                                child: Icon(
                                  Icons.search,
                                  color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.6),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            child: widget.appBarStyle.barcode ? IgnorePointer(
                              ignoring: false,
                              child: IconButton(
                                  onPressed: () {
                                    _barCodeScan(context);
                                  },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                              ),
                            ) : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  expandedHeight: widget.appBarStyle.location ? 110 : null,
                  flexibleSpace: widget.appBarStyle.location ? FlexibleSpaceBar(
                    background: Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            child: Container(
                              color: Theme.of(context).primaryColorLight,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                                child: InkWell(
                                  onTap: () async {
                                    widget.onTapAddress();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.mapMarkerAlt),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Expanded(
                                          //width: MediaQuery.of(context).size.width - 110,
                                          child: Builder(
                                              builder: (context) {
                                                if (model.customerLocation['address'] != null)
                                                  return Text(model.customerLocation['address'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                                                      fontSize: 14
                                                  ));
                                                else
                                                  return Text(model.blocks.localeText.selectLocation, style: TextStyle(
                                                      fontSize: 14
                                                  ));
                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : null,
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      icon: Icon(FlutterRemix.search_2_line),) : Container(width: 0),
                    (widget.appBarStyle.cart || widget.appBarStyle.searchIcon) ? Container() : Container(width: 16)
                  ],
                );
              default:
                return SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  stretch: false,
                  titleSpacing: 0,
                  leading: widget.appBarStyle.drawer ? null : widget.appBarStyle.logo ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HeaderLogo(),
                  ) : null, //Container(width: 8, child: HeaderLogo()),
                  title: Padding(
                    padding: widget.appBarStyle.drawer == false && widget.appBarStyle.logo == false ? EdgeInsetsDirectional.only(start: 32.0) : EdgeInsetsDirectional.all(0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          enableFeedback: false,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Search();
                            }));
                          },
                          child: CupertinoTextField(
                            enabled: false,
                            decoration: BoxDecoration(
                              color: CupertinoDynamicColor.withBrightness(
                                color: CupertinoColors.white,
                                darkColor: CupertinoColors.black,
                              ),
                              border: _kDefaultRoundedBorder,
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            prefix: Container(
                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: DunesIcon(iconString: model.blocks.settings.searchIcon, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : CupertinoColors.placeholderText),
                            ),
                            /*suffix: widget.appBarStyle.barcode ? Container(
                          height: 38,
                          child: IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ),
                        ) : Container(),*/
                            placeholder: model.blocks.localeText.search,
                            onChanged: (value) {

                            },
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 0,
                          child: widget.appBarStyle.barcode ? IgnorePointer(
                            ignoring: false,
                            child: IconButton(
                                onPressed: () {
                                  _barCodeScan(context);
                                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                            ),
                          ) : Container(),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    for (var i = 0; i < widget.appBarStyle.actions.length; i++)
                      IconButton(onPressed: () {
                        onItemClick(widget.appBarStyle.actions[i], context);
                      }, icon: DunesIcon(iconString: widget.appBarStyle.actions[i].leading, color: Theme.of(context).primaryIconTheme.color)),
                    widget.appBarStyle.cart ? CartIcon() : Container(width: 0),
                    widget.appBarStyle.wishListIcon ? IconButton(onPressed: () {
                      if(model.user.id == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WishList();
                        }));
                      }
                    }, icon: DunesIcon(iconString: model.blocks.settings.wishListIcon)) : Container(width: 0),
                    widget.appBarStyle.searchIcon ? IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Search();
                      }));
                    }, icon: DunesIcon(iconString: model.blocks.settings.searchIcon)) : Container(width: 0),
                  ],
                );
            }
          }
        );
      }
    );
  }

  Widget buildCupertinoSearchFiled(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(4.0),
          enableFeedback: false,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Search();
            }));
          },
          child: CupertinoTextField(
              keyboardType: TextInputType.text,
              placeholder: AppStateModel().blocks.localeText.searchProducts,
              placeholderStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).textTheme.caption!.color
              ),
              enabled: false,
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).textTheme.caption!.color!.withOpacity(0.6),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          end: 0,
          child: widget.appBarStyle.barcode ? IgnorePointer(
            ignoring: false,
            child: IconButton(
                onPressed: () {
                  _barCodeScan(context);
                },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
            ),
          ) : Container(),
        )
      ],
    );
  }

  Widget buildHomeTitle(BuildContext context) {

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.transparent));

    if(Theme.of(context).appBarTheme.backgroundColor != null) {
      fillColor = Theme.of(context).appBarTheme.backgroundColor.toString().substring(Theme.of(context).appBarTheme.backgroundColor.toString().length - 7) == 'ffffff)' ? null : Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;
    } else fillColor = Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black12;

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        enableFeedback: false,
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Search();
          }));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextField(
              showCursor: false,
              enabled: false,
              decoration: InputDecoration(
                hintText: AppStateModel().blocks.localeText.searchProducts,
                hintStyle: TextStyle(
                  fontSize: 16,
                ),
                fillColor: fillColor,
                filled: true,
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border,
                focusedErrorBorder: border,
                disabledBorder: border,
                contentPadding: EdgeInsets.all(4),
                prefixIcon: Icon(
                  FlutterRemix.search_2_line,
                ),
              ),
            ),
            Positioned.directional(
              textDirection:Directionality.of(context),
              end: 0,
              child: widget.appBarStyle.barcode ? IgnorePointer(
                ignoring: false,
                child: IconButton(
                    onPressed: () {
                      _barCodeScan(context);
                    },icon: Icon(CupertinoIcons.barcode_viewfinder, color: Theme.of(context).disabledColor,)
                ),
              ) : Container(),
            )
          ],
        ),
      ),
    );
  }

  _barCodeScan(BuildContext context) async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      if(result.type == ResultType.Barcode) {
        showDialog(builder: (context) => FindBarCodeProduct(result: result.rawContent, context: context), context: context);
      } else {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      }

    } on PlatformException catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  _onPressCartIcon(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CartPage(),
          fullscreenDialog: true,
        ));
  }
}
