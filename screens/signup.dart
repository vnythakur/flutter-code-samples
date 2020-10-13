import 'package:education_app/screens/home.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../providers/auth.dart';
import '../constants.dart';
import '../helper/functions.dart';

import '../screens/login.dart';

/**
 * IMPORTING COMPONENTS
 */
import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/appbar_flatbtn.dart';
import '../components/custom_appbar.dart';
import '../components/custom_input_form_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';

class SignupPage extends StatefulWidget {
  static const PAGEID = 'signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String emailErrorMsg;
  String passwordErrorMsg;
  String confirmPasswordErrorMsg;

  bool _isLoading = false;

  /**
   * EMAIL/PASSWORD BASED SIGNUP HANDLER
   */
  onSignup() async {
    if (_formKey.currentState.validate()) {
      final String emailVal = email.value.text.trim();
      final String paswordVal = password.value.text.trim();
      final String confirmPaswordVal = confirmPassword.value.text.trim();

      emailErrorMsg = emailValidator(emailVal);
      passwordErrorMsg = passwordValidator(paswordVal);
      confirmPasswordErrorMsg = passwordValidator(confirmPaswordVal);

      if (confirmPasswordErrorMsg == null && paswordVal != confirmPaswordVal) {
        confirmPasswordErrorMsg = 'Password not matched';
      }

      setState(() {});

      if (emailErrorMsg != null || passwordErrorMsg != null) {
        Toast.show("Invalid email or password", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      } else if (confirmPasswordErrorMsg != null) {
        Toast.show(confirmPasswordErrorMsg, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final response =
          await Provider.of<Auth>(context).signUp(emailVal, paswordVal);

      setState(() {
        _isLoading = false;
      });

      if (response) {
        /**
         * CLOSE SIGNUP SCREEN USING NAVIGATOR AS HOME SCREEN ROUTED IN BEHIND AS THE STATE CHANGED
         */
        Future.delayed(Duration(seconds: 1), () {
          Navigator.popUntil(context, (r) {
            print(r.toString());
            return r.isFirst;
          });
        });
      } else {
        Toast.show("User already exists", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
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
            text: "Sign Up",
            onPressed: () {},
          )
        ],
      ),
      body: ModalProgressHUD(
        child: buildWidget(),
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
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


  /**
   * RENDER SIGNUP FORM
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
              child: AppTitle(text: 'Sign Up'),
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
              hint: 'Email',
              errorMsg: emailErrorMsg,
              isSuffixEnable: true,
            ),
            SizedBox(height: 16.0),
            CustomInputFormField(
              isPassword: true,
              fieldCtrl: password,
              onChangeHandler: (_) {
                passwordErrorMsg = passwordValidator(password.value.text);
              },
              hint: 'Password',
              errorMsg: passwordErrorMsg,
              isSuffixEnable: true,
            ),
            SizedBox(height: 16.0),
            CustomInputFormField(
              isPassword: true,
              fieldCtrl: confirmPassword,
              onChangeHandler: (_) {
                confirmPasswordErrorMsg =
                    passwordValidator(confirmPassword.value.text);
                if (confirmPasswordErrorMsg == null) {
                  if (password.value.text != confirmPassword.value.text) {
                    confirmPasswordErrorMsg = 'Password not matched';
                  }
                }
              },
              hint: 'Confirm Password',
              errorMsg: confirmPasswordErrorMsg,
              isSuffixEnable: true,
            ),
            SizedBox(height: 24.0),
            PrimaryButton(
              text: 'Submit',
              handler: onSignup,
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
            text: 'Sign Up with Facebook',
            handler: () {},
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppText(
                    text: "Already have an account?",
                    size: 14.0,
                  ),
                  Text(
                    ' Log In',
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
              Navigator.of(context).pushNamed(LoginPage.PAGEID);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
