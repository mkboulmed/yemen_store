import 'package:flex_color_scheme/src/flex_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';

class IntroScreen4 extends StatefulWidget {
  final Function onFinish;
  IntroScreen4({Key? key, required this.onFinish}) : super(key: key);

  @override
  IntroScreen4State createState() => new IntroScreen4State();
}

class IntroScreen4State extends State<IntroScreen4> {
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
    Color activeColor = Theme.of(context).colorScheme.onPrimary;
    Color inactiveColor = Theme.of(context).colorScheme.onPrimary.withOpacity(0.5);
    double sizeIndicator = 20;

    MaterialStateProperty<Color> buttonBackgroundColor = MaterialStateProperty.all(Colors.transparent);
    MaterialStateProperty<Color> buttonForegroundColor = MaterialStateProperty.all(Colors.white);

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
            backgroundColor: Theme.of(context).colorScheme.primary,
            //title: "Shop Online",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            //description: "Shop Electronics, Mobile, Men Clothing, Women Clothing, Home appliances & Kitchen appliances online now. Get amazing discounts on branded fashion apparel for men and women at unbeatable prices.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            backgroundImage: "assets/images/intro/intro1.gif",
            backgroundFilterOpacity: 0,
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            //title: "Get best offers",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            //description: "Take advantage of the latest offers on products ranging from electronics to household items, clothes and accessories. Enjoy discounts, promotional deals. Shop now for unbeatable deals",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            backgroundImage: "assets/images/intro/intro2.gif",
            backgroundFilterOpacity: 0,
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            //title: "Handpicked Products",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            //description: "With our pick of handpicked deals, you can find amazing savings every time you shop with us. Take advantage of these exclusive deals today and make sure you don’t miss out on the best discounts online!",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            backgroundImage: "assets/images/intro/intro3.gif",
            backgroundFilterOpacity: 0,
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            //title: "Great Discount",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            //description: "Our exclusive offers include amazing discounts on all of the top-rated products from leading brands. Whether you're looking for a new phone or just want to save some money on accessories, we've got it all.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            backgroundImage: "assets/images/intro/intro4.png",
            backgroundFilterOpacity: 0,
            maxLineTextDescription: 8,
          ),
        ],
        onDonePress: this.onDonePress,
      ),
    );
  }
}