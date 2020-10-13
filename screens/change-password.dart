import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/custom_appbar.dart';
import 'package:education_app/components/custom_input_form_field.dart';
import 'package:education_app/components/primary_button.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';

import '../providers/auth.dart';
import '../helper/functions.dart';

class ChangePasswordPage extends StatefulWidget {
  static const PAGEID = 'change-password';

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  String oldPasswordErrorMsg;
  String passwordErrorMsg;
  String confirmPasswordErrorMsg;

  bool _isLoading = false;

  onPasswordChange() async {
    if (_formKey.currentState.validate()) {
      final oldPassword = _oldPassword.value.text;
      final newPassword = _newPassword.value.text;
      final confirmPassword = _confirmPassword.value.text;

      oldPasswordErrorMsg = passwordValidator(oldPassword);
      passwordErrorMsg = passwordValidator(newPassword);
      confirmPasswordErrorMsg = passwordValidator(confirmPassword);

      if (confirmPasswordErrorMsg == null && newPassword != confirmPassword) {
        confirmPasswordErrorMsg = 'Password not matched';
      }

      setState(() {});

      if (oldPasswordErrorMsg != null ||
          passwordErrorMsg != null ||
          confirmPasswordErrorMsg != null) {
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final response = await Provider.of<Auth>(context)
          .changePassword(oldPassword, newPassword);

      setState(() {
        _isLoading = false;
      });

      if (!response) {
        Toast.show("Incorrect Password", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Password updated successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
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
                buildFormSection(),
              ],
            ),
          ),
        );
      },
    );
  }


  /**
   * RENDER CHANGE PASSWORD FORM
   */
  Widget buildFormSection() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(top: 24),
              child: AppTitle(text: 'Reset Password'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(top: 16),
              child: AppText(
                  text:
                      'Create a new password. Then re-enter to confirm your new password.'),
            ),
            SizedBox(height: 32.0),
            CustomInputFormField(
              isPassword: true,
              fieldCtrl: _oldPassword,
              onChangeHandler: (_) {
                oldPasswordErrorMsg =
                    passwordValidator(_oldPassword.value.text);
              },
              hint: 'Old Password',
              errorMsg: oldPasswordErrorMsg,
            ),
            SizedBox(height: 24.0),
            CustomInputFormField(
              isPassword: true,
              fieldCtrl: _newPassword,
              onChangeHandler: (_) {
                passwordErrorMsg = passwordValidator(_newPassword.value.text);
              },
              hint: 'New Password',
              errorMsg: passwordErrorMsg,
            ),
            SizedBox(height: 16.0),
            CustomInputFormField(
              isPassword: true,
              fieldCtrl: _confirmPassword,
              onChangeHandler: (_) {
                confirmPasswordErrorMsg =
                    passwordValidator(_confirmPassword.value.text);
                if (confirmPasswordErrorMsg == null) {
                  if (_newPassword.value.text != _confirmPassword.value.text) {
                    confirmPasswordErrorMsg = 'Password not matched';
                  }
                }
              },
              hint: 'Confirm New Password',
              errorMsg: confirmPasswordErrorMsg,
            ),
            SizedBox(height: 32.0),
            PrimaryButton(
              text: 'Continue',
              handler: onPasswordChange,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();

    super.dispose();
  }
}
