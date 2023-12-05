import 'package:app/src/models/theme/hex_color.dart';
import 'package:dunes_font/dunes_font.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData flexThemeFromJson(Map<String, dynamic>? json, String themeMode) {
  return themeMode == 'light' ? json is Map<String, dynamic> ? FlexThemeData.light(
    scheme: json["useBuiltIn"] == true ? getFlexScheme(json["scheme"]) : null,
    colors: json["useBuiltIn"] != true ? flexThemesColorsfromJson(json["colors"]) : null,
    surfaceMode: getSurfaceMode(json["surfaceMode"]),
    blendLevel: isInt(json["blendLevel"].toString()) ? int.parse(json["blendLevel"].toString()) : 18,
    appBarStyle: getAppBarStyle(json["appBarStyle"]),
    appBarOpacity: isDouble(json["appBarOpacity"].toString()) ? double.parse(json["appBarOpacity"].toString()) : 0.95,
    appBarElevation: isDouble(json["appBarElevation"].toString()) ? double.parse(json["appBarElevation"].toString()) : 0.0,
    transparentStatusBar: json["transparentStatusBar"] == true ? true : false,
    tabBarStyle: getTabBarStyle(json["tabBarStyle"]),
    tooltipsMatchBackground: json["tooltipsMatchBackground"] == false ? false : true,
    swapColors: json["swapColors"] == false ? false : true,
    lightIsWhite: json["lightIsWhite"] == false ? false : true,
    //useSubThemes: json["useSubThemes"] == false ? false : true,
    visualDensity: getVisualDensity(json["visualDensity"]),
    fontFamily: getGoogleFont(json['fontFamily']).fontFamily,
    primaryTextTheme: getGoogleTextTheme(json['fontFamily']),
    //textTheme: getGoogleTextTheme(json['fontFamily']),
    useMaterial3: json["useMaterial3"] == false ? false : true,
    useMaterial3ErrorColors: json["useM3ErrorColors"] == true ? true : false,
    tones: json["usedFlexToneSetup"] != null ? getTones(json["usedFlexToneSetup"], Brightness.light) : null,
    keyColors: json["keyColors"] != null ? getKeyColors(json["keyColors"]) : null,

    subThemesData: json["subThemesData"] == null ? subThemesDataFromJson({}) : subThemesDataFromJson(json["subThemesData"]),
  ).copyWith(
      dividerColor: Colors.grey[200]
  ) : FlexThemeData.light(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.material,
    appBarOpacity: 0.95,
    appBarElevation: 0.0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forAppBar,
    tooltipsMatchBackground: true,
    swapColors: true,
    lightIsWhite: true,
    //useSubThemes: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use this font, add GoogleFonts package and uncomment:
    // fontFamily: GoogleFonts.notoSans().fontFamily,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: false,
      interactionEffects: true,
      bottomNavigationBarOpacity: 0.95,
      bottomNavigationBarElevation: 0.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  ) : json is Map<String, dynamic> ? FlexThemeData.dark(
    scheme: json["useBuiltIn"] == true ? getFlexScheme(json["scheme"]) : null,
    colors: json["useBuiltIn"] != true ? flexThemesColorsfromJson(json["colors"]) : null,
    surfaceMode: getSurfaceMode(json["surfaceMode"]),
    blendLevel: isInt(json["blendLevel"].toString()) ? int.parse(json["blendLevel"].toString()) : 18,
    appBarStyle: getAppBarStyle(json["appBarStyle"]),
    appBarOpacity: isDouble(json["appBarOpacity"].toString()) ? double.parse(json["appBarOpacity"].toString()) : 0.95,
    appBarElevation: isDouble(json["appBarElevation"].toString()) ? double.parse(json["appBarElevation"].toString()) : 0.0,
    transparentStatusBar: json["transparentStatusBar"] == false ? false : true,
    tabBarStyle: getTabBarStyle(json["tabBarStyle"]),
    tooltipsMatchBackground: json["tooltipsMatchBackground"] == false ? false : true,
    swapColors: json["swapColors"] == false ? false : true,
    //useSubThemes: json["useSubThemes"] == false ? false : true,
    visualDensity: getVisualDensity(json["visualDensity"]),
    fontFamily: getGoogleFont(json['fontFamily']).fontFamily,
    primaryTextTheme: getGoogleTextTheme(json['fontFamily']),
    textTheme: getGoogleTextTheme(json['fontFamily']),
    useMaterial3: json["useMaterial3"] == false ? false : true,
    useMaterial3ErrorColors: json["useM3ErrorColors"] == true ? true : false,
    tones: json["usedFlexToneSetup"] != null ? getTones(json["usedFlexToneSetup"], Brightness.dark) : null,
    keyColors: json["keyColors"] != null ? getKeyColors(json["keyColors"]) : null,

    subThemesData: json["subThemesData"] == null ? subThemesDataFromJson({}) : subThemesDataFromJson(json["subThemesData"]),
  ) : FlexThemeData.dark(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.material,
    appBarOpacity: 0.95,
    appBarElevation: 0.0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forAppBar,
    tooltipsMatchBackground: true,
    swapColors: true,
    //useSubThemes: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use this font, add GoogleFonts package and uncomment:
    // fontFamily: GoogleFonts.notoSans().fontFamily,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: false,
      interactionEffects: true,
      bottomNavigationBarOpacity: 0.95,
      bottomNavigationBarElevation: 0.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  );
}

getTones(int usedFlexToneSetup, Brightness brightness) {
  if (usedFlexToneSetup == 2) {
    return FlexTones.soft(brightness);
  }
  if (usedFlexToneSetup == 3) {
    return FlexTones.vivid(brightness);
  }
  if (usedFlexToneSetup == 4) {
    return FlexTones.vividSurfaces(brightness);
  }
  if (usedFlexToneSetup == 5) {
    return FlexTones.highContrast(brightness);
  } return null;
}

FlexKeyColors getKeyColors(Map<String, dynamic>? json) {
  return json is Map<String, dynamic> ? FlexKeyColors(
    useSecondary: json["useSecondary"] == true ? true : false,
    useTertiary: json["useTertiary"] == true ? true : false,
    keepPrimary: json["keepPrimary"] == true ? true : false,
    keepSecondary: json["keepSecondary"] == true ? true : false,
    keepTertiary: json["keepTertiary"] == true ? true : false,
    keepPrimaryContainer: json["keepPrimaryContainer"] == true ? true : false,
    keepSecondaryContainer: json["keepSecondaryContainer"] == true ? true : false,
    keepTertiaryContainer: json["keepTertiaryContainer"] == true ? true : false,
  ) : FlexKeyColors();
}

FlexSchemeColor flexThemesColorsfromJson(Map<String, dynamic>? json) {
  return json is Map<String, dynamic> ? FlexSchemeColor(
    primary: json['primary'] != null ? HexColor(json['primary']) : Colors.blue,
    secondary: json['primary'] != null ? HexColor(json['secondary']) : Colors.orange,
    appBarColor: json['appBarColor'] == null ? Colors.white : HexColor(
        json['appBarColor']),
    error: json['error'] == null ? null : HexColor(json['error']),
    primaryContainer: json['primaryContainer'] != null ? HexColor(json['primaryContainer']) : Colors.blue,
    secondaryContainer: json['secondaryContainer'] != null ? HexColor(json['secondaryContainer']) : Colors.blue,
    tertiary: json['tertiary'] != null ? HexColor(json['tertiary']) : Colors.blue,
    tertiaryContainer: json['tertiaryContainer'] != null ? HexColor(json['tertiaryContainer']) : Colors.blue,
  ) : FlexSchemeColor(primary: Colors.blue, secondary:Colors.orange);
}

FlexSubThemesData? subThemesDataFromJson(Map<String, dynamic> json) {
  return FlexSubThemesData(
    useTextTheme: json["useTextTheme"] == false ? false : true,
    fabUseShape: json["fabUseShape"] == true ? true : false,
    interactionEffects: json["interactionEffects"] == false ? false : true,
    bottomNavigationBarOpacity: isDouble(json["bottomNavigationBarOpacity"].toString()) ? double.parse(json["bottomNavigationBarOpacity"].toString()) : 0.95,
    bottomNavigationBarElevation: isDouble(json["bottomNavigationBarElevation"].toString()) ? double.parse(json["bottomNavigationBarElevation"].toString()) : 0.0,
    inputDecoratorIsFilled: json["inputDecoratorIsFilled"] == false ? false : true,
    inputDecoratorBorderType: getInputDecoratorBorderType(json["inputDecoratorBorderType"]),
    inputDecoratorUnfocusedHasBorder: json["inputDecoratorUnfocusedHasBorder"] == false ? false : true,
    blendOnColors: json["blendOnColors"] == false ? false : true,
    blendTextTheme: json["blendTextTheme"] == false ? false : true,
    popupMenuOpacity: isDouble(json["popupMenuOpacity"].toString()) ? double.parse(json["popupMenuOpacity"].toString()) : 0.95,
    blendOnLevel: isInt(json["blendOnLevel"].toString()) ? int.parse(json["blendOnLevel"].toString()) : 0,
    useFlutterDefaults: json["useFlutterDefaults"] == true ? true : false,
    defaultRadius: isDouble(json["defaultRadius"].toString()) ? double.parse(json["defaultRadius"].toString()) : null,
    inputDecoratorRadius: isDouble(json["inputDecoratorRadius"].toString()) ? double.parse(json["inputDecoratorRadius"].toString()) : null,
    inputDecoratorSchemeColor: json["inputDecoratorSchemeColor"] != null ? getSchemeColor(json["inputDecoratorSchemeColor"]) : null,
    inputDecoratorUnfocusedBorderIsColored: json["inputDecoratorUnfocusedBorderIsColored"] == false ? false : true,
    appBarBackgroundSchemeColor: json["appBarBackgroundSchemeColor"] != null ? getSchemeColor(json["appBarBackgroundSchemeColor"]) : null,
    tabBarIndicatorSchemeColor: json["tabBarIndicatorSchemeColor"] != null ? getSchemeColor(json["tabBarIndicatorSchemeColor"]) : null,
    tabBarItemSchemeColor: json["tabBarItemSchemeColor"] != null ? getSchemeColor(json["tabBarItemSchemeColor"]) : null,
    bottomNavigationBarSelectedLabelSchemeColor: json["bottomNavigationBarSelectedLabelSchemeColor"] != null ? getSchemeColor(json["bottomNavigationBarSelectedLabelSchemeColor"]) : null,
    bottomNavigationBarUnselectedLabelSchemeColor: json["bottomNavigationBarUnselectedLabelSchemeColor"] != null ? getSchemeColor(json["bottomNavigationBarUnselectedLabelSchemeColor"]) : null,
    bottomNavigationBarMutedUnselectedLabel: json["bottomNavigationBarMutedUnselectedLabel"] == false ? false : true,
    bottomNavigationBarSelectedIconSchemeColor: json["bottomNavigationBarSelectedIconSchemeColor"] != null ? getSchemeColor(json["bottomNavigationBarSelectedIconSchemeColor"]) : null,
    bottomNavigationBarUnselectedIconSchemeColor: json["bottomNavigationBarUnselectedIconSchemeColor"] != null ? getSchemeColor(json["bottomNavigationBarUnselectedIconSchemeColor"]) : null,
    bottomNavigationBarMutedUnselectedIcon: json["bottomNavigationBarMutedUnselectedIcon"] == false ? false : true,
    bottomNavigationBarBackgroundSchemeColor: json["bottomNavigationBarBackgroundSchemeColor"] != null ? getSchemeColor(json["bottomNavigationBarBackgroundSchemeColor"]) : null,
    bottomNavigationBarShowSelectedLabels: json["bottomNavigationBarShowSelectedLabels"] == false ? false : true,
    bottomNavigationBarShowUnselectedLabels: json["bottomNavigationBarShowUnselectedLabels"] == false ? false : true,
    navigationBarSelectedLabelSchemeColor: json["navigationBarSelectedLabelSchemeColor"] != null ? getSchemeColor(json["navigationBarSelectedLabelSchemeColor"]) : null,
    navigationBarUnselectedLabelSchemeColor: json["navigationBarUnselectedLabelSchemeColor"] != null ? getSchemeColor(json["navigationBarUnselectedLabelSchemeColor"]) : null,
    navigationBarMutedUnselectedLabel: json["navigationBarMutedUnselectedLabel"] == false ? false : true,
    navigationBarSelectedIconSchemeColor: json["navigationBarSelectedIconSchemeColor"] != null ? getSchemeColor(json["navigationBarSelectedIconSchemeColor"]) : null,
    navigationBarUnselectedIconSchemeColor: json["navigationBarUnselectedIconSchemeColor"] != null ? getSchemeColor(json["navigationBarUnselectedIconSchemeColor"]) : null,
    navigationBarMutedUnselectedIcon: json["navigationBarMutedUnselectedIcon"] == false ? false : true,
    navigationBarIndicatorSchemeColor: json["navigationBarIndicatorSchemeColor"] != null ? getSchemeColor(json["navigationBarIndicatorSchemeColor"]) : null,
    navigationBarIndicatorOpacity: isDouble(json["navigationBarIndicatorOpacity"].toString()) ? double.parse(json["navigationBarIndicatorOpacity"].toString()) : null,
    navigationBarBackgroundSchemeColor: json["navigationBarBackgroundSchemeColor"] != null ? getSchemeColor(json["navigationBarBackgroundSchemeColor"]) : null,
    navigationBarOpacity: isDouble(json["navigationBarOpacity"].toString()) ? double.parse(json["navigationBarOpacity"].toString()) : 1,
    navigationBarHeight: isDouble(json["navigationBarHeight"].toString()) ? double.parse(json["navigationBarHeight"].toString()) : null,
    navigationBarLabelBehavior: json["navigationBarLabelBehavior"] == "NavigationDestinationLabelBehavior.onlyShowSelected" ? NavigationDestinationLabelBehavior.onlyShowSelected : json["navigationBarLabelBehavior"] == "NavigationDestinationLabelBehavior.alwaysHide" ? NavigationDestinationLabelBehavior.alwaysHide : NavigationDestinationLabelBehavior.alwaysShow,
    textButtonRadius: isDouble(json["textButtonRadius"].toString()) ? double.parse(json["textButtonRadius"].toString()) : null,
    elevatedButtonRadius: isDouble(json["elevatedButtonRadius"].toString()) ? double.parse(json["elevatedButtonRadius"].toString()) : null,
    outlinedButtonRadius: isDouble(json["outlinedButtonRadius"].toString()) ? double.parse(json["outlinedButtonRadius"].toString()) : null,
    textButtonSchemeColor: json["textButtonSchemeColor"] != null ? getSchemeColor(json["textButtonSchemeColor"]) : null,
    elevatedButtonSchemeColor: json["elevatedButtonSchemeColor"] != null ? getSchemeColor(json["elevatedButtonSchemeColor"]) : null,
    outlinedButtonSchemeColor: json["outlinedButtonSchemeColor"] != null ? getSchemeColor(json["outlinedButtonSchemeColor"]) : null,
    toggleButtonsRadius: isDouble(json["toggleButtonsRadius"].toString()) ? double.parse(json["toggleButtonsRadius"].toString()) : null,
    toggleButtonsSchemeColor: json["toggleButtonsSchemeColor"] != null ? getSchemeColor(json["toggleButtonsSchemeColor"]) : null,
    switchSchemeColor: json["switchSchemeColor"] != null ? getSchemeColor(json["switchSchemeColor"]) : null,
    radioSchemeColor: json["radioSchemeColor"] != null ? getSchemeColor(json["radioSchemeColor"]) : null,
    fabRadius: isDouble(json["fabRadius"].toString()) ? double.parse(json["fabRadius"].toString()) : null,
    fabSchemeColor: json["fabSchemeColor"] != null ? getSchemeColor(json["fabSchemeColor"]) : null,
    chipSchemeColor: json["chipSchemeColor"] != null ? getSchemeColor(json["chipSchemeColor"]) : null,
    chipRadius: isDouble(json["chipRadius"].toString()) ? double.parse(json["chipRadius"].toString()) : null,
    popupMenuRadius: isDouble(json["popupMenuRadius"].toString()) ? double.parse(json["popupMenuRadius"].toString()) : null,
    checkboxSchemeColor: json["checkboxSchemeColor"] != null ? getSchemeColor(json["checkboxSchemeColor"]) : null,
    unselectedToggleIsColored: json["unselectedToggleIsColored"] == true ? true : false,
    dialogBackgroundSchemeColor: json["dialogBackgroundSchemeColor"] != null ? getSchemeColor(json["dialogBackgroundSchemeColor"]) : null,
    dialogRadius: isDouble(json["dialogRadius"].toString()) ? double.parse(json["dialogRadius"].toString()) : null,
    timePickerDialogRadius: isDouble(json["timePickerDialogRadius"].toString()) ? double.parse(json["timePickerDialogRadius"].toString()) : null,
    bottomSheetRadius: isDouble(json["bottomSheetRadius"].toString()) ? double.parse(json["bottomSheetRadius"].toString()) : null,
    snackBarBackgroundSchemeColor: json["snackBarBackgroundSchemeColor"] != null ? getSchemeColor(json["snackBarBackgroundSchemeColor"]) : null,
    cardRadius: isDouble(json["cardRadius"].toString()) ? double.parse(json["cardRadius"].toString()) : null,

    tintedDisabledControls: json["tintedDisabledControls"] == false ? false : true,
    useM2StyleDividerInM3: json["useM2StyleDividerInM3"] == false ? false : true,
    sliderValueTinted: json["sliderValueTinted"] == true ? true : false,
    inputDecoratorFocusedHasBorder: json["inputDecoratorFocusedHasBorder"] == false ? false : true,
    fabAlwaysCircular: json["fabAlwaysCircular"] == true ? true : false,
    useInputDecoratorThemeInDialogs: json["useInputDecoratorThemeInDialogs"] == true ? true : false,
    navigationRailMutedUnselectedIcon: json["navigationRailMutedUnselectedIcon"] == false ? false : true,
    navigationRailUseIndicator: json["navigationRailUseIndicator"] == false ? false : true,
    tooltipOpacity: isDouble(json["tooltipOpacity"].toString()) ? double.parse(json["tooltipOpacity"].toString()) : 1.0,
    navigationRailOpacity: isDouble(json["navigationRailOpacity"].toString()) ? double.parse(json["navigationRailOpacity"].toString()) : 1.0,
    thinBorderWidth: isDouble(json["thinBorderWidth"].toString()) ? double.parse(json["thinBorderWidth"].toString()) : null,
    thickBorderWidth: isDouble(json["thickBorderWidth"].toString()) ? double.parse(json["thickBorderWidth"].toString()) : null,
    defaultRadiusAdaptive: isDouble(json["defaultRadiusAdaptive"].toString()) ? double.parse(json["defaultRadiusAdaptive"].toString()) : null,
    filledButtonRadius: isDouble(json["filledButtonRadius"].toString()) ? double.parse(json["filledButtonRadius"].toString()) : null,
    outlinedButtonBorderWidth: isDouble(json["outlinedButtonBorderWidth"].toString()) ? double.parse(json["outlinedButtonBorderWidth"].toString()) : null,
    outlinedButtonPressedBorderWidth: isDouble(json["outlinedButtonPressedBorderWidth"].toString()) ? double.parse(json["outlinedButtonPressedBorderWidth"].toString()) : null,
    toggleButtonsBorderWidth: isDouble(json["toggleButtonsBorderWidth"].toString()) ? double.parse(json["toggleButtonsBorderWidth"].toString()) : null,
    segmentedButtonRadius: isDouble(json["segmentedButtonRadius"].toString()) ? double.parse(json["segmentedButtonRadius"].toString()) : null,
    segmentedButtonBorderWidth: isDouble(json["segmentedButtonBorderWidth"].toString()) ? double.parse(json["segmentedButtonBorderWidth"].toString()) : null,
    sliderTrackHeight: isDouble(json["sliderTrackHeight"].toString()) ? double.parse(json["sliderTrackHeight"].toString()) : null,
    inputDecoratorBorderWidth: isDouble(json["inputDecoratorBorderWidth"].toString()) ? double.parse(json["inputDecoratorBorderWidth"].toString()) : null,
    inputDecoratorFocusedBorderWidth: isDouble(json["inputDecoratorFocusedBorderWidth"].toString()) ? double.parse(json["inputDecoratorFocusedBorderWidth"].toString()) : null,
    popupMenuElevation: isDouble(json["popupMenuElevation"].toString()) ? double.parse(json["popupMenuElevation"].toString()) : null,
    tooltipRadius: isDouble(json["tooltipRadius"].toString()) ? double.parse(json["tooltipRadius"].toString()) : null,
    timePickerElementRadius: isDouble(json["timePickerElementRadius"].toString()) ? double.parse(json["timePickerElementRadius"].toString()) : null,
    dialogElevation: isDouble(json["dialogElevation"].toString()) ? double.parse(json["dialogElevation"].toString()) : null,
    snackBarRadius: isDouble(json["snackBarRadius"].toString()) ? double.parse(json["snackBarRadius"].toString()) : null,
    snackBarElevation: isDouble(json["snackBarElevation"].toString()) ? double.parse(json["snackBarElevation"].toString()) : null,
    appBarScrolledUnderElevation: isDouble(json["appBarScrolledUnderElevation"].toString()) ? double.parse(json["appBarScrolledUnderElevation"].toString()) : null,
    tabBarUnselectedItemOpacity: isDouble(json["tabBarUnselectedItemOpacity"].toString()) ? double.parse(json["tabBarUnselectedItemOpacity"].toString()) : null,
    tabBarIndicatorWeight: isDouble(json["tabBarIndicatorWeight"].toString()) ? double.parse(json["tabBarIndicatorWeight"].toString()) : null,
    tabBarIndicatorTopRadius: isDouble(json["tabBarIndicatorTopRadius"].toString()) ? double.parse(json["tabBarIndicatorTopRadius"].toString()) : null,
    drawerRadius: isDouble(json["drawerRadius"].toString()) ? double.parse(json["drawerRadius"].toString()) : null,
    drawerElevation: isDouble(json["drawerElevation"].toString()) ? double.parse(json["drawerElevation"].toString()) : null,
    drawerWidth: isDouble(json["drawerWidth"].toString()) ? double.parse(json["drawerWidth"].toString()) : null,
    drawerIndicatorWidth: isDouble(json["drawerIndicatorWidth"].toString()) ? double.parse(json["drawerIndicatorWidth"].toString()) : null,
    drawerIndicatorRadius: isDouble(json["drawerIndicatorRadius"].toString()) ? double.parse(json["drawerIndicatorRadius"].toString()) : null,
    drawerIndicatorOpacity: isDouble(json["drawerIndicatorOpacity"].toString()) ? double.parse(json["drawerIndicatorOpacity"].toString()) : null,
    bottomSheetElevation: isDouble(json["bottomSheetElevation"].toString()) ? double.parse(json["bottomSheetElevation"].toString()) : null,
    bottomSheetModalElevation: isDouble(json["bottomSheetModalElevation"].toString()) ? double.parse(json["bottomSheetModalElevation"].toString()) : null,
    bottomSheetBackgroundColor: json["bottomSheetBackgroundColor"] != null ? getSchemeColor(json["bottomSheetBackgroundColor"]) : null,
    bottomSheetModalBackgroundColor: json["bottomSheetModalBackgroundColor"] != null ? getSchemeColor(json["bottomSheetModalBackgroundColor"]) : null,
    menuRadius: isDouble(json["menuRadius"].toString()) ? double.parse(json["menuRadius"].toString()) : null,
    menuElevation: isDouble(json["menuElevation"].toString()) ? double.parse(json["menuElevation"].toString()) : null,
    menuOpacity: isDouble(json["menuOpacity"].toString()) ? double.parse(json["menuOpacity"].toString()) : null,
    menuPadding: isDouble(json["menuPadding"].toString()) ? EdgeInsets.all(double.parse(json["menuPadding"].toString())) : null,
    menuBarRadius: isDouble(json["menuBarRadius"].toString()) ? double.parse(json["menuBarRadius"].toString()) : null,
    menuBarElevation: isDouble(json["menuBarElevation"].toString()) ? double.parse(json["menuBarElevation"].toString()) : null,
    menuIndicatorRadius: isDouble(json["menuIndicatorRadius"].toString()) ? double.parse(json["menuIndicatorRadius"].toString()) : null,
    navigationBarIndicatorRadius: isDouble(json["navigationBarIndicatorRadius"].toString()) ? double.parse(json["navigationBarIndicatorRadius"].toString()) : null,
    navigationBarElevation: isDouble(json["navigationBarElevation"].toString()) ? double.parse(json["navigationBarElevation"].toString()) : null,

    navigationRailIndicatorOpacity: isDouble(json["navigationRailIndicatorOpacity"].toString()) ? double.parse(json["navigationRailIndicatorOpacity"].toString()) : null,
    navigationRailIndicatorRadius: isDouble(json["navigationRailIndicatorRadius"].toString()) ? double.parse(json["navigationRailIndicatorRadius"].toString()) : null,
    navigationRailElevation: isDouble(json["navigationRailElevation"].toString()) ? double.parse(json["navigationRailElevation"].toString()) : null,

    filledButtonSchemeColor: json["filledButtonSchemeColor"] != null ? getSchemeColor(json["filledButtonSchemeColor"]) : null,
    elevatedButtonSecondarySchemeColor: json["elevatedButtonSecondarySchemeColor"] != null ? getSchemeColor(json["elevatedButtonSecondarySchemeColor"]) : null,
    outlinedButtonOutlineSchemeColor: json["outlinedButtonOutlineSchemeColor"] != null ? getSchemeColor(json["outlinedButtonOutlineSchemeColor"]) : null,
    toggleButtonsUnselectedSchemeColor: json["toggleButtonsUnselectedSchemeColor"] != null ? getSchemeColor(json["toggleButtonsUnselectedSchemeColor"]) : null,
    toggleButtonsBorderSchemeColor: json["toggleButtonsBorderSchemeColor"] != null ? getSchemeColor(json["toggleButtonsBorderSchemeColor"]) : null,
    segmentedButtonSchemeColor: json["segmentedButtonSchemeColor"] != null ? getSchemeColor(json["segmentedButtonSchemeColor"]) : null,
    segmentedButtonUnselectedSchemeColor: json["segmentedButtonUnselectedSchemeColor"] != null ? getSchemeColor(json["segmentedButtonUnselectedSchemeColor"]) : null,
    segmentedButtonUnselectedForegroundSchemeColor: json["segmentedButtonUnselectedForegroundSchemeColor"] != null ? getSchemeColor(json["segmentedButtonUnselectedForegroundSchemeColor"]) : null,
    segmentedButtonBorderSchemeColor: json["segmentedButtonBorderSchemeColor"] != null ? getSchemeColor(json["segmentedButtonBorderSchemeColor"]) : null,
    switchThumbSchemeColor: json["switchThumbSchemeColor"] != null ? getSchemeColor(json["switchThumbSchemeColor"]) : null,
    sliderBaseSchemeColor: json["sliderBaseSchemeColor"] != null ? getSchemeColor(json["sliderBaseSchemeColor"]) : null,
    sliderIndicatorSchemeColor: json["sliderIndicatorSchemeColor"] != null ? getSchemeColor(json["sliderIndicatorSchemeColor"]) : null,
    inputDecoratorBorderSchemeColor: json["inputDecoratorBorderSchemeColor"] != null ? getSchemeColor(json["inputDecoratorBorderSchemeColor"]) : null,
    inputDecoratorPrefixIconSchemeColor: json["inputDecoratorPrefixIconSchemeColor"] != null ? getSchemeColor(json["inputDecoratorPrefixIconSchemeColor"]) : null,
    chipSelectedSchemeColor: json["chipSelectedSchemeColor"] != null ? getSchemeColor(json["chipSelectedSchemeColor"]) : null,
    chipDeleteIconSchemeColor: json["chipDeleteIconSchemeColor"] != null ? getSchemeColor(json["chipDeleteIconSchemeColor"]) : null,
    popupMenuSchemeColor: json["popupMenuSchemeColor"] != null ? getSchemeColor(json["popupMenuSchemeColor"]) : null,
    tooltipSchemeColor: json["tooltipSchemeColor"] != null ? getSchemeColor(json["tooltipSchemeColor"]) : null,
    snackBarActionSchemeColor: json["snackBarActionSchemeColor"] != null ? getSchemeColor(json["snackBarActionSchemeColor"]) : null,
    bottomAppBarSchemeColor: json["bottomAppBarSchemeColor"] != null ? getSchemeColor(json["bottomAppBarSchemeColor"]) : null,
    tabBarUnselectedItemSchemeColor: json["tabBarUnselectedItemSchemeColor"] != null ? getSchemeColor(json["tabBarUnselectedItemSchemeColor"]) : null,
    tabBarDividerColor: json["tabBarDividerColor"] != null ? HexColor(json['tabBarDividerColor']) : null,
    drawerBackgroundSchemeColor: json["drawerBackgroundSchemeColor"] != null ? getSchemeColor(json["drawerBackgroundSchemeColor"]) : null,
    drawerIndicatorSchemeColor: json["drawerIndicatorSchemeColor"] != null ? getSchemeColor(json["drawerIndicatorSchemeColor"]) : null,
    drawerSelectedItemSchemeColor: json["drawerSelectedItemSchemeColor"] != null ? getSchemeColor(json["drawerSelectedItemSchemeColor"]) : null,
    drawerUnselectedItemSchemeColor: json["drawerUnselectedItemSchemeColor"] != null ? getSchemeColor(json["drawerUnselectedItemSchemeColor"]) : null,
    menuSchemeColor: json["menuSchemeColor"] != null ? getSchemeColor(json["menuSchemeColor"]) : null,
    menuBarBackgroundSchemeColor: json["menuBarBackgroundSchemeColor"] != null ? getSchemeColor(json["menuBarBackgroundSchemeColor"]) : null,
    menuBarShadowColor: json["menuBarShadowColor"] != null ? HexColor(json['menuBarShadowColor']) : null,
    menuItemBackgroundSchemeColor: json["menuItemBackgroundSchemeColor"] != null ? getSchemeColor(json["menuItemBackgroundSchemeColor"]) : null,
    menuItemForegroundSchemeColor: json["menuItemForegroundSchemeColor"] != null ? getSchemeColor(json["menuItemForegroundSchemeColor"]) : null,
    menuIndicatorBackgroundSchemeColor: json["menuIndicatorBackgroundSchemeColor"] != null ? getSchemeColor(json["menuIndicatorBackgroundSchemeColor"]) : null,
    menuIndicatorForegroundSchemeColor: json["menuIndicatorForegroundSchemeColor"] != null ? getSchemeColor(json["menuIndicatorForegroundSchemeColor"]) : null,
    navigationRailSelectedLabelSchemeColor: json["navigationRailSelectedLabelSchemeColor"] != null ? getSchemeColor(json["navigationRailSelectedLabelSchemeColor"]) : null,
    navigationRailUnselectedLabelSchemeColor: json["navigationRailUnselectedLabelSchemeColor"] != null ? getSchemeColor(json["navigationRailUnselectedLabelSchemeColor"]) : null,
    navigationRailSelectedIconSchemeColor: json["navigationRailSelectedIconSchemeColor"] != null ? getSchemeColor(json["navigationRailSelectedIconSchemeColor"]) : null,
    navigationRailUnselectedIconSchemeColor: json["navigationRailUnselectedIconSchemeColor"] != null ? getSchemeColor(json["navigationRailUnselectedIconSchemeColor"]) : null,
    navigationRailIndicatorSchemeColor: json["navigationRailIndicatorSchemeColor"] != null ? getSchemeColor(json["navigationRailIndicatorSchemeColor"]) : null,
    navigationRailBackgroundSchemeColor: json["navigationRailBackgroundSchemeColor"] != null ? getSchemeColor(json["navigationRailBackgroundSchemeColor"]) : null,

    inputDecoratorBackgroundAlpha: isInt(json["inputDecoratorBackgroundAlpha"].toString()) ? int.parse(json["inputDecoratorBackgroundAlpha"].toString()) : null,
    tooltipWaitDuration: isInt(json["tooltipWaitDuration"].toString()) ? Duration(milliseconds: int.parse(json["tooltipWaitDuration"].toString())) : null,
    tooltipShowDuration: isInt(json["tooltipShowDuration"].toString()) ? Duration(milliseconds: int.parse(json["tooltipShowDuration"].toString())) : null,

    navigationRailLabelType: json["navigationRailLabelType"] != null ? getNavigationRailLabelType(json["navigationRailLabelType"]) : null,
    sliderValueIndicatorType: json["sliderValueIndicatorType"] == 'FlexSliderIndicatorType.drop' ? FlexSliderIndicatorType.drop : FlexSliderIndicatorType.rectangular,
    tabBarIndicatorSize: json["tabBarIndicatorSize"] == 'TabBarIndicatorSize.tab' ? TabBarIndicatorSize.tab : TabBarIndicatorSize.label,
    sliderShowValueIndicator: json["sliderShowValueIndicator"] != null ? getSliderShowValueIndicator(json["sliderShowValueIndicator"]) : null,
  );
}

getNavigationRailLabelType(json) {
  switch (json) {
    case 'NavigationRailLabelType.none':
      return NavigationRailLabelType.none;
    case 'NavigationRailLabelType.selected':
      return NavigationRailLabelType.selected;
    default:
      return NavigationRailLabelType.all;
  }
}

getSliderShowValueIndicator(json) {
  switch (json) {
    case 'ShowValueIndicator.onlyForDiscrete':
      return ShowValueIndicator.onlyForDiscrete;
    case 'ShowValueIndicator.onlyForContinuous':
      return ShowValueIndicator.onlyForContinuous;
    case 'ShowValueIndicator.never':
      return ShowValueIndicator.never;
    default:
      return ShowValueIndicator.always;
  }
}

bool isDouble(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isInt(String? s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

SchemeColor? getSchemeColor(String value) {
  switch (value) {
    case "SchemeColor.primary":
      return SchemeColor.primary;
    case "SchemeColor.onPrimary":
      return SchemeColor.onPrimary;
    case "SchemeColor.primaryContainer":
      return SchemeColor.primaryContainer;
    case "SchemeColor.onPrimaryContainer":
      return SchemeColor.onPrimaryContainer;
    case "SchemeColor.secondary":
      return SchemeColor.secondary;
    case "SchemeColor.onSecondary":
      return SchemeColor.onSecondary;
    case "SchemeColor.secondaryContainer":
      return SchemeColor.secondaryContainer;
    case "SchemeColor.onSecondaryContainer":
      return SchemeColor.onSecondaryContainer;
    case "SchemeColor.tertiary":
      return SchemeColor.tertiary;
    case "SchemeColor.onTertiary":
      return SchemeColor.onTertiary;
    case "SchemeColor.tertiaryContainer":
      return SchemeColor.tertiaryContainer;
    case "SchemeColor.onTertiaryContainer":
      return SchemeColor.onTertiaryContainer;
    case "SchemeColor.error":
      return SchemeColor.error;
    case "SchemeColor.onError":
      return SchemeColor.onError;
    case "SchemeColor.errorContainer":
      return SchemeColor.errorContainer;
    case "SchemeColor.onErrorContainer":
      return SchemeColor.onErrorContainer;
    case "SchemeColor.background":
      return SchemeColor.background;
    case "SchemeColor.onBackground":
      return SchemeColor.onBackground;
    case "SchemeColor.surface":
      return SchemeColor.surface;
    case "SchemeColor.onSurface":
      return SchemeColor.onSurface;
    case "SchemeColor.surfaceVariant":
      return SchemeColor.surfaceVariant;
    case "SchemeColor.onSurfaceVariant":
      return SchemeColor.onSurfaceVariant;
    case "SchemeColor.outline":
      return SchemeColor.outline;
    case "SchemeColor.shadow":
      return SchemeColor.shadow;
    case "SchemeColor.inverseSurface":
      return SchemeColor.inverseSurface;
    case "SchemeColor.onInverseSurface":
      return SchemeColor.onInverseSurface;
    case "SchemeColor.inversePrimary":
      return SchemeColor.inversePrimary;
    case "SchemeColor.primaryVariant":
      return SchemeColor.primaryContainer;
    case "SchemeColor.secondaryVariant":
      return SchemeColor.secondaryContainer;
    default: return null;
  }
}

getFlexScheme(flexScheme) {
  switch (flexScheme) {
    case "FlexScheme.material": return FlexScheme.material;
    case "FlexScheme.materialHc": return FlexScheme.materialHc;
    case "FlexScheme.blue": return FlexScheme.blue;
    case "FlexScheme.indigo": return FlexScheme.indigo;
    case "FlexScheme.hippieBlue": return FlexScheme.hippieBlue;
    case "FlexScheme.aquaBlue": return FlexScheme.aquaBlue;
    case "FlexScheme.brandBlue": return FlexScheme.brandBlue;
    case "FlexScheme.deepBlue": return FlexScheme.deepBlue;
    case "FlexScheme.sakura": return FlexScheme.sakura;
    case "FlexScheme.mandyRed": return FlexScheme.mandyRed;
    case "FlexScheme.red": return FlexScheme.red;
    case "FlexScheme.redWine": return FlexScheme.redWine;
    case "FlexScheme.purpleBrown": return FlexScheme.purpleBrown;
    case "FlexScheme.green": return FlexScheme.green;
    case "FlexScheme.money": return FlexScheme.money;
    case "FlexScheme.jungle": return FlexScheme.jungle;
    case "FlexScheme.greyLaw": return FlexScheme.greyLaw;
    case "FlexScheme.wasabi": return FlexScheme.wasabi;
    case "FlexScheme.gold": return FlexScheme.gold;
    case "FlexScheme.mango": return FlexScheme.mango;
    case "FlexScheme.amber": return FlexScheme.amber;
    case "FlexScheme.vesuviusBurn": return FlexScheme.vesuviusBurn;
    case "FlexScheme.deepPurple": return FlexScheme.deepPurple;
    case "FlexScheme.ebonyClay": return FlexScheme.ebonyClay;
    case "FlexScheme.barossa": return FlexScheme.barossa;
    case "FlexScheme.shark": return FlexScheme.shark;
    case "FlexScheme.bigStone": return FlexScheme.bigStone;
    case "FlexScheme.damask": return FlexScheme.damask;
    case "FlexScheme.bahamaBlue": return FlexScheme.bahamaBlue;
    case "FlexScheme.mallardGreen": return FlexScheme.mallardGreen;
    case "FlexScheme.espresso": return FlexScheme.espresso;
    case "FlexScheme.outerSpace": return FlexScheme.outerSpace;
    case "FlexScheme.blueWhale": return FlexScheme.blueWhale;
    case "FlexScheme.sanJuanBlue": return FlexScheme.sanJuanBlue;
    case "FlexScheme.rosewood": return FlexScheme.rosewood;
    case "FlexScheme.blumineBlue": return FlexScheme.blumineBlue;
    case "FlexScheme.flutterDash": return FlexScheme.flutterDash;
    case "FlexScheme.materialBaseline": return FlexScheme.materialBaseline;
    case "FlexScheme.verdunHemlock": return FlexScheme.verdunHemlock;
    case "FlexScheme.dellGenoa": return FlexScheme.dellGenoa;
    case "FlexScheme.redM3": return FlexScheme.redM3;
    case "FlexScheme.pinkM3": return FlexScheme.pinkM3;
    case "FlexScheme.purpleM3": return FlexScheme.purpleM3;
    case "FlexScheme.indigoM3": return FlexScheme.indigoM3;
    case "FlexScheme.blueM3": return FlexScheme.blueM3;
    case "FlexScheme.cyanM3": return FlexScheme.cyanM3;
    case "FlexScheme.tealM3": return FlexScheme.tealM3;
    case "FlexScheme.greenM3": return FlexScheme.greenM3;
    case "FlexScheme.limeM3": return FlexScheme.limeM3;
    case "FlexScheme.yellowM3": return FlexScheme.yellowM3;
    case "FlexScheme.orangeM3": return FlexScheme.orangeM3;
    case "FlexScheme.deepOrangeM3": return FlexScheme.deepOrangeM3;
    case "FlexScheme.custom": return FlexScheme.custom;
    default:
      return FlexScheme.blumineBlue;
  }
}

getSurfaceMode(json) {
  switch (json) {
    case 'custom':
      return FlexSurfaceMode.custom;
    case 'highBackgroundLowScaffold':
      return FlexSurfaceMode.highBackgroundLowScaffold;
    case 'highScaffoldLevelSurface':
      return FlexSurfaceMode.highScaffoldLevelSurface;
    case 'highScaffoldLowSurface':
      return FlexSurfaceMode.highScaffoldLowSurface;
    case 'highScaffoldLowSurfaces':
      return FlexSurfaceMode.highScaffoldLowSurfaces;
    case 'levelSurfacesLowScaffoldVariantDialog':
      return FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog;
    case 'levelSurfacesLowScaffold':
      return FlexSurfaceMode.levelSurfacesLowScaffold;
    case 'level':
      return FlexSurfaceMode.level;
    case 'highSurfaceLowScaffold':
      return FlexSurfaceMode.highSurfaceLowScaffold;
    case 'highScaffoldLowSurfacesVariantDialog':
      return FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog;
    default:
      return FlexSurfaceMode.highScaffoldLowSurface;
  }
}

getAppBarStyle(json) {
  switch (json) {
    case 'FlexAppBarStyle.custom':
      return FlexAppBarStyle.custom;
    case 'FlexAppBarStyle.primary':
      return FlexAppBarStyle.primary;
    case 'FlexAppBarStyle.surface':
      return FlexAppBarStyle.surface;
    case 'FlexAppBarStyle.background':
      return FlexAppBarStyle.background;
    case 'FlexAppBarStyle.scaffoldBackground':
      return FlexAppBarStyle.scaffoldBackground;
    case 'FlexAppBarStyle.material':
      return FlexAppBarStyle.material;
    default:
      return null;
  }
}

getTabBarStyle(json) {
  switch (json) {
    case 'FlexTabBarStyle.flutterDefault':
      return FlexTabBarStyle.flutterDefault;
    case 'FlexTabBarStyle.forBackground':
      return FlexTabBarStyle.forBackground;
    case 'FlexTabBarStyle.universal':
      return FlexTabBarStyle.universal;
    case 'FlexTabBarStyle.forAppBar':
      return FlexTabBarStyle.forAppBar;
    default:
      return FlexTabBarStyle.flutterDefault;
  }
}

getVisualDensity(json) {
  switch (json) {
    case 'FlexColorScheme.comfortablePlatformDensity':
      return FlexColorScheme.comfortablePlatformDensity;
    default:
      return FlexColorScheme.comfortablePlatformDensity;
  }
}

getInputDecoratorBorderType(json) {
  switch (json) {
    case 'FlexInputBorderType.outline':
      return FlexInputBorderType.outline;
    default:
      return FlexInputBorderType.underline;
  }
}
