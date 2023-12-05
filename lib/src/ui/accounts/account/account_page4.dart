import 'package:app/src/models/app_state_model.dart';
import 'package:dunes_icons/dunes_icons.dart';
import 'package:app/src/ui/accounts/account/account_floating_button.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:app/src/ui/widgets/colored_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tinycolor2/tinycolor2.dart';

class AccountPage4 extends StatefulWidget {
  @override
  _AccountPage4State createState() => _AccountPage4State();
}

class _AccountPage4State extends State<AccountPage4> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
      return Scaffold(
          floatingActionButton: AccountFloatingButton(page: 'account'),
          body: CustomScrollView(slivers: _buildList(model)));
    });
  }

  _buildList(AppStateModel model) {


    TextStyle? titleStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16
    );
    Color iconColor = Color(0xffc5c5c6);
    Color trailingIconColor = Color(0xffc5c5c6);
    TextStyle? subtitleTextStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Color(0xff8a8a8d),
      letterSpacing: 0,
    );

    List<Widget> list = [];

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color headerColor = model.blocks.settings.accountTheme.light.disabledColor;

    list.add(SliverAppBar(
        //automaticallyImplyLeading: false,
        pinned: true,
        floating: false,
        expandedHeight:
            model.blocks.settings.accountBackgroundImage.isNotEmpty ? 150.0 : 0,
        stretch: true,
        elevation: 0,
        title: model.blocks.settings.accountBackgroundImage.isEmpty
            ? Text(model.blocks.localeText.account)
            : null,
        flexibleSpace: model.blocks.settings.accountBackgroundImage.isNotEmpty
            ? FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                background: CachedNetworkImage(
                  imageUrl: model.blocks.settings.accountBackgroundImage,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : null));

    model.blocks.settings.accountGroup.forEach((accountGroup) {
      if (accountGroup.showTitle) {
        list.add(SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              subtitle: Text(accountGroup.title.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey
                  )),
            ),
          ),
        ));
      } else
        list.add(SliverToBoxAdapter(child: SizedBox(height: 16)));

      list.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (['vendorProducts', 'vendorOrders', 'vendorWebView']
                    .contains(accountGroup.menuItems[index].linkType) &&
                !model.isVendor.contains(model.user.role)) {
              return Container();
            } else if (accountGroup.menuItems[index].linkType == 'login' &&
                model.user.id != 0) {
              return Container();
            } else if (accountGroup.menuItems[index].linkType == 'logout' &&
                model.user.id == 0) {
              return Container();
            } else
              return Container(
                margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      onTap: () {
                        onItemClick(accountGroup.menuItems[index], context);
                      },
                      trailing: DunesIcon(iconString: accountGroup.menuItems[index].leading, color: trailingIconColor),
                      title: Text(accountGroup.menuItems[index].title, style: titleStyle),
                      subtitle:
                          accountGroup.menuItems[index].description.isNotEmpty
                              ? Text(accountGroup.menuItems[index].description, style: subtitleTextStyle)
                              : null,
                    ),
                    Divider(thickness: 0),
                  ],
                ),
              );
          },
          childCount: accountGroup.menuItems.length,
        ),
      ));
    });

    if (model.blocks.settings.accountSocialLink) {
      list.add(SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          height: 60,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (model.blocks.settings.socialLink.facebook.isNotEmpty)
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

                /* if(model.blocks.settings.socialLink.facebook.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    icon: Icon(FontAwesomeIcons.facebookF),
                    iconSize: 15,
                    color: Color(0xff4267B2),
                    onPressed: (){
                      launchUrl(Uri.parse(model.blocks.settings.socialLink.facebook), mode: LaunchMode.externalApplication);
                    },
                  ),*/
                if (model.blocks.settings.socialLink.twitter.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    icon: Icon(FontAwesomeIcons.twitter),
                    iconSize: 15,
                    color: Color(0xff1DA1F2),
                    onPressed: () {
                      launchUrl(
                          Uri.parse(model.blocks.settings.socialLink.twitter),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                if (model.blocks.settings.socialLink.linkedIn.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    icon: Icon(FontAwesomeIcons.linkedinIn),
                    iconSize: 15,
                    color: Color(0xff0e76a8),
                    onPressed: () {
                      launchUrl(
                          Uri.parse(model.blocks.settings.socialLink.linkedIn),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                if (model.blocks.settings.socialLink.instagram.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    icon: Icon(FontAwesomeIcons.instagram),
                    iconSize: 15,
                    color: Color(0xfffb3958),
                    onPressed: () {
                      launchUrl(
                          Uri.parse(model.blocks.settings.socialLink.instagram),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                if (model.blocks.settings.socialLink.whatsapp.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    icon: Icon(FontAwesomeIcons.whatsapp),
                    iconSize: 15,
                    color: Color(0xff128C7E),
                    onPressed: () {
                      launchUrl(
                          Uri.parse(model.blocks.settings.socialLink.whatsapp),
                          mode: LaunchMode.externalApplication);
                    },
                  )
              ],
            ),
          ),
        ),
      ));
    } else {
      list.add(SliverToBoxAdapter(
        child: SizedBox(height: 16),
      ));
    }

    if (model.blocks.settings.socialLink.bottomText.isNotEmpty)
      list.add(SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: TextButton(
              child: Text(model.blocks.settings.socialLink.bottomText),
              onPressed: () async {
                if (model.blocks.settings.socialLink.bottomText.contains('@') &&
                    model.blocks.settings.socialLink.bottomText.contains('.'))
                  launchUrl(Uri.parse(
                      'mailto:' + model.blocks.settings.socialLink.bottomText));
                else {
                  await canLaunch(model.blocks.settings.socialLink.bottomText)
                      ? await launch(
                          model.blocks.settings.socialLink.bottomText)
                      : throw 'Could not launch ${model.blocks.settings.socialLink.bottomText}';
                }
              },
            ),
          ),
        ),
      ));

    list.add(SliverToBoxAdapter(
      child: SizedBox(height: 40),
    ));

    return list;
  }
}
