import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class SearchBarField extends StatefulWidget {
  final Function onChanged;
  final Function onEditingComplete;
  final TextEditingController searchTextController;
  final String? hintText;
  const SearchBarField({Key? key, required this.onChanged, required this.searchTextController, this.hintText, required this.onEditingComplete}) : super(key: key);
  @override
  _SearchBarFieldState createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(0, 8, 32, 8),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              autofocus: true,
              controller: widget.searchTextController,
              onChanged: (value) {
                widget.onChanged(value);
              },
              onEditingComplete: () {
                widget.onEditingComplete();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                fillColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).inputDecorationTheme.fillColor : Colors.white,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                contentPadding: EdgeInsets.all(6),
                prefixIcon: Icon(
                  FlutterRemix.search_2_line,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}