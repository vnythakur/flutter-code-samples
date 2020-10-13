import 'package:education_app/common-task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

import '../providers/auth.dart';
import '../helper/functions.dart';

/**
 * IMPORTING COMPONENTS
 */
import '../components/custom_appbar.dart';
import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/appbar_flatbtn.dart';
import '../components/custom_flat_button.dart';
import '../components/custom_input_form_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';
import '../components/app_loader.dart';

/**
 * IMPORTING PAGES
 */
import './signup.dart';
import './forget-password.dart';

class LoginPage extends StatefulWidget {
  static const PAGEID = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  String emailErrorMsg;
  String passwordErrorMsg;

  bool _isLoading = false;

  initState() {
    super.initState();
  }


  /**
   * EMAIL/PASSWORD BASED LOGIN HANDLER
   */
  onLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      final String emailVal = email.value.text.trim();
      final String paswordVal = password.value.text.trim();

      // VALIDATE EMAIL
      emailErrorMsg = emailValidator(emailVal);

      // VALIDATE PASSWORD
      passwordErrorMsg = passwordValidator(paswordVal);

      setState(() {});

      if (emailErrorMsg != null || passwordErrorMsg != null) {
        Toast.show("Invalid email or password", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final response = await Provider.of<Auth>(context).signIn(emailVal, paswordVal);

      setState(() {
        _isLoading = false;
      });

      if (!response) {
        Toast.show("Incorrect email or password", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.popUntil(context, (r) {
            print(r.toString());
            return r.isFirst;
          });
        });
      }
    }
  }


  /**
   * FACEBOOK LOGIN HANDLER
   */
  loginWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    print('Facebook login result : $result');

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Toast.show("Login success ${result.accessToken.token}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case FacebookLoginStatus.cancelledByUser:
        Toast.show("Cancelled by user", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case FacebookLoginStatus.error:
        Toast.show(result.errorMessage, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: null,
        appBarActions: <Widget>[
          AppBarFlatButton(
            text: "Sign In",
            onPressed: () {},
          )
        ],
      ),
      body: AppLoader(
        child: buildWidget(),
        inAsyncCall: _isLoading,
      ),
    );
  }

  /**
   * RENDER LOGIN FORM
   */
  Widget buildFormSection() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24),
              child: AppTitle(text: 'Log In'),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: AppText(
                  text:
                      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown.'),
            ),
            SizedBox(height: 24.0),
            CustomInputFormField(
              keyboardType: TextInputType.emailAddress,
              fieldCtrl: email,
              onChangeHandler: (_) {
                emailErrorMsg = emailValidator(email.value.text);
              },
              hint: 'Username or Email',
              errorMsg: emailErrorMsg,
            ),
            SizedBox(height: 16.0),
            Stack(
              children: <Widget>[
                CustomInputFormField(
                  fieldCtrl: password,
                  onChangeHandler: (_) {
                    passwordErrorMsg = passwordValidator(password.value.text);
                  },
                  hint: 'Password',
                  isPassword: true,
                  contentPadding: const EdgeInsets.only(
                    top: 12.0,
                    right: 90.0,
                    bottom: 12.0,
                    left: 12.0,
                  ),
                  errorMsg: passwordErrorMsg,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  // bottom: 0,
                  child: CustomFlatButton(
                    text: 'Forgot?',
                    handler: () {
                      Navigator.of(context)
                          .pushNamed(ForgetPasswordPage.PAGEID);
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 24.0),
            PrimaryButton(
              text: 'Submit',
              handler: onLogin,
            ),
          ],
        ),
      ),
    );
  }


  /**
   * RENDER BOTTOM SECTION OF THE SCREEN
   */
  Widget buildButtomNav() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          SecondaryButton(
            text: 'Log In with Facebook',
            handler: loginWithFacebook,
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppText(
                    text: "Don't have an account?",
                    size: 14.0,
                  ),
                  Text(
                    ' Sign Up',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(SignupPage.PAGEID);
            },
          ),
        ],
      ),
    );
  }


  /**
   * RENDER BODY OF THE SCREEN
   */
  Widget buildWidget() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: getMinHeight(height: viewportConstraints.maxHeight),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildFormSection(),
                buildButtomNav(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
