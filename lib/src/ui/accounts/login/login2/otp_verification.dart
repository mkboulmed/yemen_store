import 'dart:async';
import 'package:app/src/ui/accounts/login/logo.dart';
import 'package:app/src/ui/widgets/buttons/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import './../../../../ui/accounts/login/login2/bezierContainer.dart';
import './../../../../models/app_state_model.dart';

class OTPVerification extends StatefulWidget {
  OTPVerification({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  late String verificationId;
  final String phoneNumber;

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final appStateModel = AppStateModel();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  TextEditingController otpController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /*final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();*/
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Builder(
      builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Builder(
            builder: (context) => Stack(
              children: [
                Positioned(
                  top: height * -.16,
                  //means -150 of total height; i.e above the screen
                  right: MediaQuery.of(context).size.width * -.45,
                  //means -40% of total width; i.e more than  right the screen
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.all(32),
                  child: new Form(
                    key: _formKey,
                    child: new ListView(
                      children: <Widget>[
                        /*Lottie.asset(
                          'assets/images/intro/lottie3.json',
                          width: 220,
                          height: 220,
                        ),*/
                        Logo(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(appStateModel.blocks.localeText.enterOtp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 15,
                                            )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text('${widget.phoneNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    obscureText: false,
                                    animationType: AnimationType.fade,
                                    /*validator: (v) {
                                      if (v.length < 6) {
                                        showSnackBar(context, 'Invalid Code');
                                        return null;
                                      } else {
                                        return null;
                                      }
                                    },*/
                                    pinTheme: PinTheme(
                                      inactiveColor:
                                          Colors.grey.withOpacity(.2),
                                      inactiveFillColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      selectedColor: Colors.blue,
                                      activeColor: Colors.black,
                                      selectedFillColor: Colors.white,
                                      shape: PinCodeFieldShape.box,
                                      borderWidth: 2,
                                      borderRadius: BorderRadius.circular(3),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: Colors.white,
                                    ),
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    backgroundColor: Colors.transparent,
                                    // backgroundColor: Colors.transparent,
                                    enableActiveFill: true,
                                    errorAnimationController: errorController,
                                    controller: otpController,
                                    keyboardType: TextInputType.number,
                                    onCompleted: (v) {
                                      //
                                    },
                                    onChanged: (value) {
                                      //print(value);
                                    },
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 30.0),
                        AccentButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              verifyOTP(context);
                            }
                          },
                          text: appStateModel.blocks.localeText.signIn,
                          showProgress: isLoading,
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                            onPressed: () {
                              sendOTP(context);
                            },
                            child: Text(
                                appStateModel.blocks.localeText.resendOTP,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                      .primaryColor,
                                    ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyOTP(BuildContext context) async {
    //_btnController.start();
    setState(() {
      isLoading = true;
    });

    //Server end verification
    var data = new Map<String, dynamic>();
    data["smsOTP"] = otpController.text;
    data["verificationId"] = widget.verificationId;
    data["phoneNumber"] = widget.phoneNumber;
    bool status = await appStateModel.phoneLogin(data, context);
    if (status) {
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
    }

    //Local verification. Do not use this, Use server end verification instead
    /*PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text);
    try {
      await _auth.signInWithCredential(phoneAuthCredential);
      //Wordpress Login user with
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'The SMS verification code used is invalid.');
    }*/

    setState(() {
      isLoading = false;
    });
  }

  showSnackBar(BuildContext context, String message) {
    //Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);

    final snackBar =
        SnackBar(backgroundColor: Colors.red, content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> sendOTP(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          codeAutoRetrievalTimeout: (String verId) {
            widget.verificationId = verId;
          },
          codeSent: (String? verId, [int? forceCodeResend]) {
            setState(() {
              isLoading = false;
            });
            widget.verificationId = verId!;
          },
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            onVerificationCompleted(phoneAuthCredential);
            await _auth.signInWithCredential(phoneAuthCredential);
            setState(() {
              isLoading = false;
            });
          },
          verificationFailed: (exception) {
            handlePhoneNumberError(exception, context);
            setState(() {
              isLoading = false;
            });
          });
    } catch (e) {
      handleOtpError(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  handleOtpError(error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        showSnackBar(context, appStateModel.blocks.localeText.inValidCode);
        break;
      default:
        showSnackBar(context, appStateModel.blocks.localeText.inValidCode);
        break;
    }
  }

  handlePhoneNumberError(FirebaseAuthException error, BuildContext context) {
    switch (error.code) {
      case 'TOO_LONG':
        FocusScope.of(context).requestFocus(new FocusNode());
        showSnackBar(context, appStateModel.blocks.localeText.inValidNumber);
        break;
      case 'TOO_SHORT':
        FocusScope.of(context).requestFocus(new FocusNode());
        showSnackBar(context, appStateModel.blocks.localeText.inValidNumber);
        Navigator.of(context).pop();
        break;
      case 'SESSION_EXPIRED':
        break;
      case 'INVALID_SESSION_INFO':
        break;
      default:

        String errorMessage = error.message != null ? error.code + ': ' + error.message! : appStateModel.blocks.localeText.inValidNumber;
        showSnackBar(context, errorMessage);
        break;
    }
  }

  onVerificationCompleted(AuthCredential phoneAuthCredential) {
    //TODO Wordpress Login User
  }
}
