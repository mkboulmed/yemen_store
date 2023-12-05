import 'package:app/src/ui/accounts/account/account_page.dart';
import 'package:app/src/ui/accounts/account/account_page2.dart';
import 'package:app/src/ui/accounts/account/account_page3.dart';
import 'package:app/src/ui/accounts/account/account_page4.dart';
import 'package:app/src/ui/accounts/account/account_page5.dart';
import 'package:app/src/ui/accounts/account/account_page6.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './../../../models/app_state_model.dart';
import 'account1.dart';
import 'account2.dart';
import 'account3.dart';
import 'account4.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          if (model.blocks.settings.customAccount) {
            if (model.blocks.settings.pageLayout.account == 'layout1') {
              return AccountPage();
            } else if (model.blocks.settings.pageLayout.account == 'layout2') {
              return AccountPage2();
            } else if (model.blocks.settings.pageLayout.account == 'layout3') {
              return AccountPage3();
            } else if (model.blocks.settings.pageLayout.account == 'layout4') {
              return AccountPage4();
            } else if (model.blocks.settings.pageLayout.account == 'layout5') {
              return AccountPage5();
            } else if (model.blocks.settings.pageLayout.account == 'layout6') {
              return AccountPage6();
            } else {
              return AccountPage();
            }
          } else if (model.blocks.settings.pageLayout.account == 'layout1') {
            return UserAccount1();
          } else if (model.blocks.settings.pageLayout.account == 'layout2') {
            return UserAccount2();
          } else if (model.blocks.settings.pageLayout.account == 'layout3') {
            return UserAccount3();
          } else if (model.blocks.settings.pageLayout.account == 'layout4') {
            return UserAccount4();
          } else {
            return UserAccount1();
          }
        });
  }
}


