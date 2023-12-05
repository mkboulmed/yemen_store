import 'package:app/src/models/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          Color primaryColor = model.blocks.settings.progressIndicator.primaryColor != null ? model.blocks.settings.progressIndicator.primaryColor! : Theme.of(context).colorScheme.primary;
          Color secondaryColor = model.blocks.settings.progressIndicator.secondaryColor != null ? model.blocks.settings.progressIndicator.secondaryColor! : Theme.of(context).colorScheme.secondary;
          double size = model.blocks.settings.progressIndicator.size;
          double width = model.blocks.settings.progressIndicator.width;

          switch (model.blocks.settings.progressIndicator.type) {
            case 'waveDots':
              return LoadingAnimationWidget.waveDots(
                color: primaryColor,
                size: size,
              );
            case 'inkDrop':
              return LoadingAnimationWidget.inkDrop(
                color: primaryColor,
                size: size,
              );
            case 'twistingDots':
              return LoadingAnimationWidget.twistingDots(
                leftDotColor: primaryColor,
                rightDotColor: secondaryColor,
                size: size,
              );
            case 'threeRotatingDots':
              return LoadingAnimationWidget.threeRotatingDots(
                color: primaryColor,
                size: size,
              );
            case 'staggeredDotsWave':
              return LoadingAnimationWidget.staggeredDotsWave(
                color: primaryColor,
                size: size,
              );
            case 'fourRotatingDots':
              return LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: size,
              );
            case 'fallingDot':
              return LoadingAnimationWidget.fallingDot(
                color: primaryColor,
                size: size,
              );
            case 'prograssiveDots':
              return LoadingAnimationWidget.prograssiveDots(
                color: primaryColor,
                size: size,
              );
            case 'discreteCircle':
              return LoadingAnimationWidget.discreteCircle(
                color: primaryColor,
                size: size,
              );
            case 'threeArchedCircle':
              return LoadingAnimationWidget.threeArchedCircle(
                color: primaryColor,
                size: size,
              );
            case 'bouncingBall':
              return LoadingAnimationWidget.bouncingBall(
                color: primaryColor,
                size: size,
              );
            case 'flickr':
              return LoadingAnimationWidget.flickr(
                leftDotColor: primaryColor,
                rightDotColor: secondaryColor,
                size: size,
              );
            case 'hexagonDots':
              return LoadingAnimationWidget.hexagonDots(
                color: primaryColor,
                size: size,
              );
            case 'beat':
              return LoadingAnimationWidget.beat(
                color: primaryColor,
                size: size,
              );
            case 'twoRotatingArc':
              return LoadingAnimationWidget.twoRotatingArc(
                color: primaryColor,
                size: size,
              );
            case 'horizontalRotatingDots':
              return LoadingAnimationWidget.horizontalRotatingDots(
                color: primaryColor,
                size: size,
              );
            case 'newtonCradle':
              return LoadingAnimationWidget.newtonCradle(
                color: primaryColor,
                size: size,
              );
            case 'stretchedDots':
              return LoadingAnimationWidget.stretchedDots(
                color: primaryColor,
                size: size,
              );
            case 'halfTriangleDot':
              return LoadingAnimationWidget.halfTriangleDot(
                color: primaryColor,
                size: size,
              );
            case 'dotsTriangle':
              return LoadingAnimationWidget.dotsTriangle(
                color: primaryColor,
                size: size,
              );
            default:
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                backgroundColor: Colors.white,
                strokeWidth: width,
              );
          }

        /*return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          backgroundColor: Colors.white,
          strokeWidth: width,
        );*/
      }
    );
  }
}
