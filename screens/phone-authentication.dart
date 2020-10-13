import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:education_app/common-task.dart';
import 'package:education_app/helper/functions.dart';

import 'package:education_app/screens/email-pin-verification.dart';

import 'package:education_app/components/app_loader.dart';
import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/custom_flat_button.dart';
import 'package:education_app/components/custom_input_form_field.dart';
import 'package:education_app/components/primary_button.dart';


class PhoneAuthentication extends StatefulWidget {
  static final PAGEID = 'phone-auth';
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  final _formKey = GlobalKey<FormState>();
  final phone = TextEditingController();
  final countryCode = TextEditingController();

  String deviceID;
  String phoneErrorMsg;
  String countryCodeErr;
  bool _isLoading = false;

  @override
  void initState() {
    phone.text = "3103400070";
    countryCode.text = "+1";
    getDeviceToken();
    super.initState();
  }


  /**
   * RETRIVE DEVICE TOKEN
   */
  getDeviceToken() async {
    String deviceID = await getDeviceId();
    print(deviceID);
    deviceID = deviceID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLoader(
          inAsyncCall: _isLoading,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                // padding: EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        getMinHeight(height: viewportConstraints.maxHeight),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[phoneScreen(context)],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  
  /**
   * HANDLER TO LOGIN USING MOBILE No.
   */
  onLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      final String phoneVal = phone.value.text.trim();
      final String countryVal = countryCode.value.text.trim();

      phoneErrorMsg = phoneValidator(phoneVal);
      countryCodeErr = emptyValidator(countryVal);

      setState(() {});

      if (phoneErrorMsg != null || countryCodeErr != null) {
        Toast.show("Invalid phone number or country code", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      sendOTP(phoneVal, countryVal);
    }
  }


  /**
   * SEND OTP TO GIVEN NUMBER
   * PARAMS:
   *  phone: number
   *  countryCode: number
   */
  sendOTP(phone, countryCode) async {
    Map data = {
      'phone_number': phone,
      'country_code': countryCode,
      'device_id': deviceID
    };
    
    var res = await postRequest('devices', data);
    print(res.body);
    
    setState(() {
      _isLoading = false;
    });
    
    var response = json.decode(res.body);

    if (response['success']) {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pushNamed(EmailPinVerification.PAGEID, arguments: {
        'phone': phone,
        'countryCode': countryCode,
        'deviceID': deviceID
      });
    } else {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  /**
   * RENDER THE BODY OF THE SCREEN
   */
  Widget phoneScreen(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "http://hedong.info/wp-content/uploads/2019/09/small-library-ideas-room-decorating.jpg"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(top: 24),
              child: AppTitle(text: 'Welcome'),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(top: 16),
              child: AppText(
                  text:
                      'Welcome to Project Meta where you can learn, make and play for free. To get started, please enter your mobile phone to receive to receive your free activation code.'),
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.only(left:16.0, right: 16.0),
              child: CustomInputFormField(
                fieldCtrl: countryCode,
                keyboardType: TextInputType.phone,
                onChangeHandler: (_) {
                  countryCodeErr = emptyValidator(countryCode.value.text);
                },
                hint: 'Country Code',
                errorMsg: countryCodeErr,
                // textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomInputFormField(
                keyboardType: TextInputType.phone,
                fieldCtrl: phone,
                onChangeHandler: (_) {
                  phoneErrorMsg = phoneValidator(phone.value.text);
                },
                hint: 'Phone number',
                errorMsg: phoneErrorMsg,
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: PrimaryButton(
                text: 'Get Free Code',
                handler: onLogin,
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
