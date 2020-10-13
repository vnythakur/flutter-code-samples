import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_appbar.dart';

class AboutApp extends StatelessWidget {
  static const PAGEID = 'about-app';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: const Text('About App'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 8.0),
              child: AppTitle(text: 'Our Goal is Satisfied Readers'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppTitle(
                            text:
                                'Great books are published every day with different levels of language, violence, and intimacy.',
                            size: 18.0,
                          ),
                          bodyText(
                              'With Book Cave and Book Cave Direct, readers choose their level of comfort, so they waste less time with books that don’t match their preferences, and they find greater satisfaction. Satisfied readers means happy readers—and that’s also great for authors. Think of our content ratings like movie ratings, only a bit more detailed. Everybody wins!'),
                          bodyText(
                              'We see a real need for book deals that allow readers an easy way to choose content ratings for each and every book they read. Because readers find authors and books though different methods, we use several to help you find great deals on great ebooks.'),
                          const SizedBox(height: 16.0)
                        ],
                      ),
                    ),
                    versionBuildNumber(
                      children: [
                        _appTitle('Version Number'),
                        _appTitle('4.6.45.4')
                      ],
                      isLast: false,
                    ),
                    versionBuildNumber(
                      children: [
                        _appTitle('Build Number'),
                        _appTitle('20190816A')
                      ],
                      isLast: true,
                    ),
                    const SizedBox(height: 40.0)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyText(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: AppText(noOpacity: true, text: text),
    );
  }

  Widget _appTitle(String text) {
    return AppTitle(
      text: text,
      size: 18.0,
      color: const Color(kPrimaryTextColorNoOpac),
    );
  }

  Widget versionBuildNumber({children, isLast}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: const Color(kAppBorderColor), width: isLast ? 0 : 1),
          bottom: const BorderSide(color: Color(kAppBorderColor), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
