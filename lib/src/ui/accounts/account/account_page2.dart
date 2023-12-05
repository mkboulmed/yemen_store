import 'package:app/src/models/app_state_model.dart';
import 'package:app/src/ui/accounts/login/login.dart';
import 'package:app/src/ui/blocks/products/wishlist_icon.dart';
import 'package:app/src/ui/checkout/cart/shopping_cart.dart';
import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/accounts/account/account_floating_button.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:app/src/ui/widgets/colored_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tinycolor2/tinycolor2.dart';

class AccountPage2 extends StatefulWidget {
  @override
  _AccountPage2State createState() => _AccountPage2State();
}

class _AccountPage2State extends State<AccountPage2> {

  Color greyColor = Colors.grey[600]!;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          return Scaffold(
              floatingActionButton: AccountFloatingButton(page: 'account'),
              body: CustomScrollView(slivers: _buildList(model))
          );
        });
  }

  _buildList(AppStateModel model) {
    List<Widget> list = [];

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    //Color? iconColor = isDark ? Theme.of(context).iconTheme.color : model.blocks.settings.accountTheme.light.hintColor;
    Color headerColor = model.blocks.settings.accountTheme.light.disabledColor;


    list.add(SliverAppBar(
      //automaticallyImplyLeading: false,
        pinned: true,
        floating: false,
        expandedHeight: model.blocks.settings.accountBackgroundImage.isNotEmpty ? 150.0 : 0,
        stretch: true,
        elevation: 0,
        title: model.blocks.settings.accountBackgroundImage.isEmpty ? null : null,
        flexibleSpace: model.blocks.settings.accountBackgroundImage.isNotEmpty
            ? FlexibleSpaceBar(
          stretchModes: [StretchMode.zoomBackground],
          background: CachedNetworkImage(
            imageUrl: model.blocks.settings.accountBackgroundImage,
            placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.2),),
            errorWidget: (context, url, error) => Container(color: Colors.grey.withOpacity(0.2),),
            fit: BoxFit.cover,
          ),
        ) : null));

    list.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if(model.user.id != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      if(model.user.firstName.isNotEmpty)
                        Text(
                          model.user.firstName + ' ' + model.user.lastName,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Text(
                          model.blocks.localeText.welcome,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 4.0),
                      if(model.user.email.isNotEmpty)
                        Text(
                          model.user.email,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: greyColor,
                          ),
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 32.0,
                      backgroundImage: NetworkImage(model.user.avatarUrl),
                    ),
                  ),
                ],
              ) else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          model.blocks.localeText.welcome,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          model.blocks.localeText.signIn,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 32.0,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            Divider(),
          ],
        ),
      ),
    ));

    model.blocks.settings.accountGroup.forEach((accountGroup) {

      if(accountGroup.showTitle && model.blocks.settings.accountGroup.indexOf(accountGroup) != 2) {
        list.add(
            SliverToBoxAdapter(
              child: AccountGroupHeader(title: accountGroup.title),
            )
        );
      } else list.add(SliverToBoxAdapter(child: SizedBox(height: 0)));

      if(model.blocks.settings.accountGroup.indexOf(accountGroup) != 2)
        list.add(SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              if (['vendorProducts', 'vendorOrders', 'vendorWebView'].contains(accountGroup.menuItems[index].linkType) &&
                  !model.isVendor.contains(model.user.role)) {
                return Container();
              } else if (accountGroup.menuItems[index].linkType == 'login' &&
                  model.user.id != 0) {
                return Container();
              } else if (accountGroup.menuItems[index].linkType == 'logout' &&
                  model.user.id == 0) {
                return Container();
              } else
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onItemClick(accountGroup.menuItems[index], context);
                      },
                      child: AccountListTile(
                        title: accountGroup.menuItems[index].title,
                        subtitle: accountGroup.menuItems[index].description.isNotEmpty ? accountGroup.menuItems[index].description : null,
                        icon: accountGroup.menuItems[index].leading.isNotEmpty
                            ? accountGroup.menuItems[index].leading
                            : null,
                      ),
                    ),
                  ],
                );
            },
            childCount: accountGroup.menuItems.length,
          ),
        ));
    });

    if(model.blocks.settings.accountGroup.length == 3)
      list.add(SliverToBoxAdapter(
        child: Container(
          height: 460,
          color: Colors.black,
          child: Column(
            children: [
              GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 4,
                  children: List.generate(model.blocks.settings.accountGroup[2].menuItems.length, (index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Container(
                              height: 38,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black45,
                              ),
                              child: model.blocks.settings.accountGroup[2].menuItems[index].leading.isNotEmpty
                                  ? DunesIcon(iconString: model.blocks.settings.accountGroup[2].menuItems[index].leading, color: Colors.white)
                                  : null,),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(
                              model.blocks.settings.accountGroup[2].menuItems[index].title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              ),
              SizedBox(
                height: 50,
              ),
              if (model.user.id == 0)
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: OutlinedButton(
                      style: ButtonStyle(
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(.1);
                          }
                          return Colors.transparent;
                        }),
                        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
                          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
                        }),
                      ),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      }, child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )),
                ) else
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: OutlinedButton(
                      style: ButtonStyle(
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(.1);
                          }
                          return Colors.transparent;
                        }),
                        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
                          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
                        }),
                      ),
                      onPressed: () async {
                        await AppStateModel().logout();
                        context.read<Favourites>().clear();
                        context.read<ShoppingCart>().getCart();
                      }, child: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )),
                ),
              if(model.blocks.settings.accountGroup.length == 3)
                Container(
                  padding: EdgeInsets.fromLTRB(8, 48, 8, 24),
                  height: 60,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(model.blocks.settings.socialLink.facebook.isNotEmpty)
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: Icon(FontAwesomeIcons.facebookF),
                            iconSize: 15,
                            color: Color(0xff4267B2),
                            onPressed: (){
                              launchUrl(Uri.parse(model.blocks.settings.socialLink.facebook), mode: LaunchMode.externalApplication);
                            },
                          ),
                        if(model.blocks.settings.socialLink.twitter.isNotEmpty)
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: Icon(FontAwesomeIcons.twitter),
                            iconSize: 15,
                            color: Color(0xff1DA1F2),
                            onPressed: () {
                              launchUrl(Uri.parse(model.blocks.settings.socialLink.twitter), mode: LaunchMode.externalApplication);
                            },
                          ),
                        if(model.blocks.settings.socialLink.linkedIn.isNotEmpty)
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: Icon(FontAwesomeIcons.linkedinIn),
                            iconSize: 15,
                            color: Color(0xff0e76a8),
                            onPressed: () {
                              launchUrl(Uri.parse(model.blocks.settings.socialLink.linkedIn), mode: LaunchMode.externalApplication);
                            },
                          ),
                        if(model.blocks.settings.socialLink.instagram.isNotEmpty)
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: Icon(FontAwesomeIcons.instagram),
                            iconSize: 15,
                            color: Color(0xfffb3958),
                            onPressed: () {
                              launchUrl(Uri.parse(model.blocks.settings.socialLink.instagram), mode: LaunchMode.externalApplication);
                            },
                          ),
                        if(model.blocks.settings.socialLink.whatsapp.isNotEmpty)
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                            icon: Icon(FontAwesomeIcons.whatsapp),
                            iconSize: 15,
                            color: Color(0xff128C7E),
                            onPressed: () {
                              launchUrl(Uri.parse(model.blocks.settings.socialLink.whatsapp), mode: LaunchMode.externalApplication);
                            },
                          )
                      ],
                    ),
                  ) ,
                ),
              if(model.blocks.settings.socialLink.bottomText.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: TextButton(
                      child: Text(model.blocks.settings.socialLink.bottomText, style: TextStyle(color: Colors.white54),),
                      onPressed: () async {
                        if(model.blocks.settings.socialLink.bottomText.contains('@') && model.blocks.settings.socialLink.bottomText.contains('.'))
                          launchUrl(Uri.parse('mailto:' + model.blocks.settings.socialLink.bottomText));
                        else {
                          await canLaunch(model.blocks.settings.socialLink.bottomText) ? await launch(model.blocks.settings.socialLink.bottomText) : throw 'Could not launch ${model.blocks.settings.socialLink.bottomText}';
                        }
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ));
    else
      list.add(SliverToBoxAdapter(
        child: Column(

          children: [
            if(model.blocks.settings.accountSocialLink)
              Container(
                padding: EdgeInsets.fromLTRB(8, 48, 8, 24),
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(model.blocks.settings.socialLink.facebook.isNotEmpty)
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          icon: Icon(FontAwesomeIcons.facebookF),
                          iconSize: 15,
                          color: Color(0xff4267B2),
                          onPressed: (){
                            launchUrl(Uri.parse(model.blocks.settings.socialLink.facebook), mode: LaunchMode.externalApplication);
                          },
                        ),
                      if(model.blocks.settings.socialLink.twitter.isNotEmpty)
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          icon: Icon(FontAwesomeIcons.twitter),
                          iconSize: 15,
                          color: Color(0xff1DA1F2),
                          onPressed: () {
                            launchUrl(Uri.parse(model.blocks.settings.socialLink.twitter), mode: LaunchMode.externalApplication);
                          },
                        ),
                      if(model.blocks.settings.socialLink.linkedIn.isNotEmpty)
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          icon: Icon(FontAwesomeIcons.linkedinIn),
                          iconSize: 15,
                          color: Color(0xff0e76a8),
                          onPressed: () {
                            launchUrl(Uri.parse(model.blocks.settings.socialLink.linkedIn), mode: LaunchMode.externalApplication);
                          },
                        ),
                      if(model.blocks.settings.socialLink.instagram.isNotEmpty)
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          icon: Icon(FontAwesomeIcons.instagram),
                          iconSize: 15,
                          color: Color(0xfffb3958),
                          onPressed: () {
                            launchUrl(Uri.parse(model.blocks.settings.socialLink.instagram), mode: LaunchMode.externalApplication);
                          },
                        ),
                      if(model.blocks.settings.socialLink.whatsapp.isNotEmpty)
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          icon: Icon(FontAwesomeIcons.whatsapp),
                          iconSize: 15,
                          color: Color(0xff128C7E),
                          onPressed: () {
                            launchUrl(Uri.parse(model.blocks.settings.socialLink.whatsapp), mode: LaunchMode.externalApplication);
                          },
                        )
                    ],
                  ),
                ) ,
              ),
            if(model.blocks.settings.socialLink.bottomText.isNotEmpty)
              Container(
                height: 40,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: TextButton(
                      child: Text(model.blocks.settings.socialLink.bottomText, style: TextStyle(color: Colors.red),),
                      onPressed: () async {
                        if(model.blocks.settings.socialLink.bottomText.contains('@') && model.blocks.settings.socialLink.bottomText.contains('.'))
                          launchUrl(Uri.parse('mailto:' + model.blocks.settings.socialLink.bottomText));
                        else {
                          await canLaunch(model.blocks.settings.socialLink.bottomText) ? await launch(model.blocks.settings.socialLink.bottomText) : throw 'Could not launch ${model.blocks.settings.socialLink.bottomText}';
                        }
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
      ));
    print(model.blocks.settings.socialLink.bottomText);
    return list;
  }
}

class AccountGroupHeader extends StatelessWidget {
  const AccountGroupHeader({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.0),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              //letterSpacing: 0.7,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key, required this.title, required this.subtitle, required this.icon,
  });

  final String title;
  final String? subtitle;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Column(
        children: [
          SizedBox(height: 16.0),
          ListTile(
            splashColor: null,
            contentPadding: EdgeInsets.all(0),
            trailing: this.icon != null ? DunesIcon(iconString: this.icon!, color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black) : null,
            title: Text(this.title, style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              //letterSpacing: 0.5
            ),),
            subtitle: this.subtitle != null ? Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(this.subtitle!, style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black
              ),),
            ) : null,
          ),
          SizedBox(height: 16.0),
          Divider(height: 0),
        ],
      ),
    );
  }
}