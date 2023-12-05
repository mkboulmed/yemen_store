import 'package:flex_color_scheme/src/flex_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';

class IntroScreen3 extends StatefulWidget {
  final Function onFinish;
  IntroScreen3({Key? key, required this.onFinish}) : super(key: key);

  @override
  IntroScreen3State createState() => new IntroScreen3State();
}

class IntroScreen3State extends State<IntroScreen3> {
  //List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {
    widget.onFinish();
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
      MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
    );
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      size: 25,
    );
  }

  Widget renderPrevBtn() {
    return const Icon(
      Icons.navigate_before,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      size: 25,
    );
  }

  @override
  Widget build(BuildContext context) {

    List<ContentConfig> listContentConfig = [];
    Color activeColor = Colors.black;
    Color inactiveColor = Colors.black.withOpacity(0.2);
    double sizeIndicator = 20;
    Color backgroundColor = Colors.white;
    Color onBackgroundColor = Colors.black;

    MaterialStateProperty<Color> buttonBackgroundColor = MaterialStateProperty.all(Colors.transparent);
    MaterialStateProperty<Color> buttonForegroundColor = MaterialStateProperty.all(Colors.black);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).colorScheme.primary.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: new IntroSlider(
        //backgroundColorAllSlides: Theme.of(context).colorScheme.primary,
        //colorDot: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        //colorActiveDot: Theme.of(context).colorScheme.onPrimary,
        indicatorConfig: IndicatorConfig(
          sizeIndicator: sizeIndicator,
          indicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: inactiveColor),
          ),
          activeIndicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: activeColor),
          ),
          spaceBetweenIndicator: 10,
          typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
        ),

        renderNextBtn: renderNextBtn(),
        renderPrevBtn: renderPrevBtn(),
        renderSkipBtn: renderSkipBtn(),
        //onNextPress: onNextPress,
        //nextButtonStyle: myButtonStyle(),

        doneButtonStyle: ButtonStyle(
          backgroundColor: buttonBackgroundColor,
          foregroundColor: buttonForegroundColor,
        ),
        nextButtonStyle: ButtonStyle(
          backgroundColor: buttonBackgroundColor,
          foregroundColor: buttonForegroundColor,
        ),
        skipButtonStyle: ButtonStyle(
          backgroundColor: buttonBackgroundColor,
          foregroundColor: buttonForegroundColor,
        ),
        prevButtonStyle: ButtonStyle(
          backgroundColor: buttonBackgroundColor,
          foregroundColor: buttonForegroundColor,
        ),
        listContentConfig: [
          ContentConfig(
            backgroundColor: backgroundColor,
            title: "Delicious Delivered",
            styleTitle: TextStyle(
              color: onBackgroundColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              //fontFamily: 'RobotoMono',
            ),
            description: "Savor the flavors of your favorite restaurants from the comfort of your home. Get ready for a culinary journey like never before with our food delivery app.",
            styleDescription: TextStyle(
              color: onBackgroundColor,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              //fontFamily: 'Raleway',
            ),
            centerWidget: Lottie.asset(height: 300, 'assets/images/intro/delivery.json'),
            //pathImage: "assets/images/intro/intro1.png",
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: backgroundColor,
            title: "Satisfying Cravings",
            styleTitle: TextStyle(
              color: onBackgroundColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              //fontFamily: 'RobotoMono',
            ),
            description: "Hungry? With our food delivery app, you're just a few taps away from a feast. Explore a world of cuisine options and have your cravings satisfied in no time.",
            styleDescription: TextStyle(
              color: onBackgroundColor,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              //fontFamily: 'Raleway',
            ),
            centerWidget: Lottie.asset(height: 300, 'assets/images/intro/delivery_road.json'),
            //pathImage: "assets/images/intro/intro2.png",
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: backgroundColor,
            title: "Effortless Feasting",
            styleTitle: TextStyle(
              color: onBackgroundColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              //fontFamily: 'RobotoMono',
            ),
            description: "Experience the perfect blend of convenience and culinary excellence with our food delivery app. Enjoy restaurant-quality meals delivered straight to your doorstep.",
            styleDescription: TextStyle(
              color: onBackgroundColor,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              //fontFamily: 'Raleway',
            ),
            //pathImage: "assets/images/intro/intro3.png",
            centerWidget: Lottie.asset(height: 300, 'assets/images/intro/food_cooking.json'),
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: backgroundColor,
            title: "Instant Satisfaction",
            styleTitle: TextStyle(
              color: onBackgroundColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              //fontFamily: 'RobotoMono',
            ),
            description: "Elevate your dining experience with our food delivery app. Discover a diverse range of dishes, elevate your taste buds, and indulge in gastronomic delights, all from your phone.",
            styleDescription: TextStyle(
              color: onBackgroundColor,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              //fontFamily: 'Raleway',
            ),
            //pathImage: "assets/images/intro/intro4.png",
            centerWidget: Lottie.asset(height: 300, 'assets/images/intro/food_cooking.json'),
            maxLineTextDescription: 8,
          ),
        ],
        onDonePress: this.onDonePress,
      ),
    );
  }
}