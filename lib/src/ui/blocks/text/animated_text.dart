import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/src/ui/blocks/banners/on_click.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/blocks_model.dart';

class AnimatedTextList extends StatefulWidget {
  final Block block;
  const AnimatedTextList({Key? key, required this.block}) : super(key: key);
  @override
  _AnimatedTextListState createState() => _AnimatedTextListState();
}

class _AnimatedTextListState extends State<AnimatedTextList> {
  @override
  Widget build(BuildContext context) {


    bool isDark = Theme.of(context).brightness == Brightness.dark;
    int count = widget.block.children.length;

    if(widget.block.children.length > 0 && widget.block.headerAlign != 'none') {
      count = widget.block.children.length + 1;
    }

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(widget.block.blockMargin.left, widget.block.blockMargin.top, widget.block.blockMargin.right, widget.block.blockMargin.bottom),
      sliver: SliverToBoxAdapter(
        child: Container(
          color: isDark ? Colors.transparent : widget.block.backgroundColor,
          child: Container(
            margin: EdgeInsets.fromLTRB(widget.block.blockPadding.left, widget.block.blockPadding.top, widget.block.blockPadding.right, widget.block.blockPadding.bottom),
            child: Card(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              elevation: widget.block.elevation,
              margin: EdgeInsets.fromLTRB(widget.block.crossAxisSpacing, widget.block.crossAxisSpacing, widget.block.crossAxisSpacing, widget.block.crossAxisSpacing),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.block.borderRadius),
              ),
              child: Container(
                  width: double.infinity,
                  height: widget.block.childHeight,
                  child: InkWell(
                    radius: widget.block.borderRadius,
                    onTap: () {
                      onItemClick(widget.block.children.first, context);
                    },
                    child: IgnorePointer(
                      child: AnimatedTextKit(
                        onTap: () {
                          onItemClick(widget.block.children.first, context);
                        },
                        animatedTexts: widget.block.children.map((e) => animatedTextWidget(widget.block.children.indexOf(e))).toList(),
                        totalRepeatCount: widget.block.blockSettings?.totalRepeatCount != null ? widget.block.blockSettings!.totalRepeatCount : 4,
                        pause: widget.block.blockSettings?.autoplayDelay != null ? Duration(milliseconds: widget.block.blockSettings!.autoplayDelay) : const Duration(milliseconds: 1000),
                        displayFullTextOnTap: widget.block.blockSettings?.displayFullTextOnTap == false ? false : true,
                        stopPauseOnTap: widget.block.blockSettings?.stopPauseOnTap == false ? false : true,
                        repeatForever: widget.block.blockSettings?.repeatForever == false ? false : true,
                      ),
                    ),
                  )//Text(widget.block.children[index].description, style: widget.block.children[index].textStyle, textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : null),
              ),
            ),
          ),
        ),
      )
    );
  }

  AnimatedText animatedTextWidget(int index) {
    switch (widget.block.blockSettings?.textAnimationType) {
      case 'TypewriterAnimatedText':
        return TypewriterAnimatedText(
            widget.block.children[index].description,
            textStyle: widget.block.children[index].textStyle,
            speed: widget.block.blockSettings?.speed != null ? Duration(milliseconds: widget.block.blockSettings!.speed) : const Duration(milliseconds: 2000),
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left
        );
      case 'FadeAnimatedText':
        return FadeAnimatedText(
            widget.block.children[index].description,
            textStyle: widget.block.children[index].textStyle,
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left
        );
      case 'ScaleAnimatedText':
        return ScaleAnimatedText(
            widget.block.children[index].description,
            textStyle: widget.block.children[index].textStyle,
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left
        );
      case 'ColorizeAnimatedText':

        List<Color> colorizeColors;
        if (widget.block.blockSettings?.colorizeColors != null && widget.block.blockSettings!.colorizeColors.isNotEmpty) {
          colorizeColors = widget.block.blockSettings!.colorizeColors;
        } else {
          colorizeColors = [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ];
        }//widget.block.children.map((e) => e.textStyle?.color != null ? e.textStyle!.color! : Colors.purple).toList();
        /*[
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ];*/

        const colorizeTextStyle = TextStyle(
          fontSize: 50.0,
          fontFamily: 'Horizon',
        );

        return ColorizeAnimatedText(
            widget.block.children[index].description,
            speed: widget.block.blockSettings?.speed != null ? Duration(milliseconds: widget.block.blockSettings!.speed) : const Duration(milliseconds: 200),
            textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : colorizeTextStyle,
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
            colors: colorizeColors
        );

      case 'TyperAnimatedText':
        return TyperAnimatedText(
            widget.block.children[index].description,
            textStyle: widget.block.children[index].textStyle,
            speed: widget.block.blockSettings?.speed != null ? Duration(milliseconds: widget.block.blockSettings!.speed) : const Duration(milliseconds: 40),
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left
        );
      case 'FlickerAnimatedText':
        return FlickerAnimatedText(
          widget.block.children[index].description,
          speed: widget.block.blockSettings?.speed != null ? Duration(milliseconds: widget.block.blockSettings!.speed) : const Duration(milliseconds: 1600),
          textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : null,
          textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
        );
      case 'WavyAnimatedText':
        return WavyAnimatedText(
          widget.block.children[index].description,
          speed: widget.block.blockSettings?.speed != null ? Duration(milliseconds: widget.block.blockSettings!.speed) : const Duration(milliseconds: 1600),
          textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : null,
          textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
        );
      case 'ScaleAnimatedText':
        return ScaleAnimatedText(
          widget.block.children[index].description,
          textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : null,
          textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
        );
      case 'RotateAnimatedText':
        return RotateAnimatedText(
          widget.block.children[index].description,
          textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : null,
          textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
        );
      default:
        return FadeAnimatedText(
            widget.block.children[index].description,
            textStyle: widget.block.children[index].textStyle != null ? widget.block.children[index].textStyle! : null,
            textAlign: widget.block.headerAlign == 'top_center' ? TextAlign.center : TextAlign.left,
        );
    }
  }
}
