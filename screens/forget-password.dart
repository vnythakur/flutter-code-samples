import 'package:education_app/screens/email-password-confirmation.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../providers/auth.dart';
import '../helper/functions.dart';
import '../constants.dart';

/**
 * IMPORTING COMPONENTS
 */
import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_appbar.dart';
import '../components/custom_input_form_field.dart';
import '../components/custom_radio_list_tile.dart';
import '../components/primary_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const PAGEID = 'forget-password';

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final emailPhone = TextEditingController();
  String emailPhoneErrorMsg;

  final String _emailInstruction =
      'We will send you an email with instructions on how to rest your password.';
  final String _smsInstruction =
      'We will send you an sms with instructions on how to rest your password.';

  bool _isLoading = false;

  String _passwordRecoveryMethod = 'email';


  /**
   * RESET PASSWORD VIA EMAIL HANDLER
   */
  void sendResetPasswordMail() async {
    if (_formKey.currentState.validate()) {
      final String emailVal = emailPhone.value.text.trim();

      emailPhoneErrorMsg = emailValidator(emailVal);

      setState(() {});

      if (emailPhoneErrorMsg != null) {
        Toast.show("Please enter email id", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<Auth>(context).forgetPassword(emailVal);

        setState(() {
          _isLoading = false;
        });

        // REDIRECTING TO SUCCESS PAGE
        Navigator.of(context).pushNamed(
            EmailPasswordRecoveryConfirmation.PAGEID,
            arguments: emailVal);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        Toast.show("User does not exists", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }


  /**
   * RESET PASSWORD VIA SMS HANDLER
   * THIS SECTION IS UNDER DEVELOPMENT
   */
  void sendResetPasswordSMS() {
    Toast.show("Functionality under development", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: null,
        appBarActions: <Widget>[],
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...topSection(),
                      SizedBox(height: 24.0),
                      radioSection(),
                      SizedBox(height: 16.0),
                      formSection()
                    ],
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Text(
                      'I don\'t remember my email or phone',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  /**
   * RENDER TOP SECTION OF THE SCREEN
   */
  List<Widget> topSection() {
    return [
      Container(
        margin: EdgeInsets.only(top: 24),
        child: AppTitle(text: 'Forgot Password?'),
      ),
      Container(
        margin: EdgeInsets.only(top: 16),
        child: AppText(text: 'How would you like to reset your password?'),
      ),
    ];
  }


  /**
   * RADIO BUTTON - CHOOSE BETWEEN EMAIL AND SMS
   */
  Widget radioSection() {
    return Container(
      child: Column(
        children: <Widget>[
          CustomRadioListTile(
            title: AppText(text: 'Email', noOpacity: true),
            isLeading: true,
            value: 'email',
            groupValue: _passwordRecoveryMethod,
            onChangeHandler: (String value) {
              setState(() {
                _passwordRecoveryMethod = value;
              });
            },
          ),
          CustomRadioListTile(
            title: AppText(text: 'Text Message', noOpacity: true),
            isLeading: true,
            value: 'sms',
            groupValue: _passwordRecoveryMethod,
            onChangeHandler: (String value) {
              setState(() {
                _passwordRecoveryMethod = value;
              });
            },
          ),
        ],
      ),
    );
  }


  /**
   * RENDER FORM OF THE SCREEN
   */
  Widget formSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppText(
              text: _passwordRecoveryMethod == 'email'
                  ? _emailInstruction
                  : _smsInstruction),
          SizedBox(height: 16.0),
          CustomInputFormField(
            fieldCtrl: emailPhone,
            hint: _passwordRecoveryMethod == 'email'
                ? 'name@example.com'
                : '9876543210',
            onChangeHandler: (_) {
              emailPhoneErrorMsg = _passwordRecoveryMethod == 'email'
                  ? emailValidator(emailPhone.value.text)
                  : phoneValidator(emailPhone.value.text);
            },
            errorMsg: emailPhoneErrorMsg,
          ),
          SizedBox(height: 24.0),
          PrimaryButton(
            text: _passwordRecoveryMethod == 'email' ? 'Email Me' : 'SMS Me',
            handler: () {
              _passwordRecoveryMethod == 'email'
                  ? sendResetPasswordMail()
                  : sendResetPasswordSMS();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailPhone.dispose();
    super.dispose();
  }
}
