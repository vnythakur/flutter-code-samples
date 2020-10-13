
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/media/rating.dart';

import './constants.dart';

import './providers/auth.dart';
import './providers/rss_service.dart';

import './screens/home.dart';
import './screens/forget-password.dart';
import './screens/login.dart';
import './screens/signup.dart';
import './screens/change-password.dart';
import './screens/webview-container.dart';
import './screens/email-password-confirmation.dart';
import './screens/welcome.dart';
import './screens/email-pin-verification.dart';
import './screens/faq/faq-categories.dart';
import './screens/faq/faq-list.dart';
import './screens/faq/faq-details.dart';
import './screens/feed-list.dart';
import './screens/about-app.dart';
import './screens/privacy.dart';
import './screens/terms-of-service.dart';
import './screens/course-browse.dart';
import './screens/course-detail.dart';
import './screens/course-lesson.dart';
import './screens/course-group-discussion.dart';
import './screens/edit-profile.dart';
import './screens/user-profile.dart';
import './screens/personal_interest_value.dart';
import './screens/course_welcome.dart';
import './screens/library-read.dart';

import './screens/games/browse-categories.dart';
import './screens/games/create-game.dart';
import './screens/games/main-screen.dart';
import './screens/games/add-quiz.dart';
import './screens/games/add-true-false.dart';
import './screens/games/answers-graph.dart';
import './screens/games/connect-game.dart';
import './screens/games/correct-answer.dart';
import './screens/games/countdown.dart';
import './screens/games/details-credit.dart';
import './screens/games/game-over.dart';
import './screens/games/incorrect-answer.dart';
import './screens/games/multi-questions.dart';
import './screens/games/nickname.dart';
import './screens/games/quiz-get-ready.dart';
import './screens/games/rating.dart';
import './screens/games/settings.dart';
import './screens/games/sub-categories.dart';
import './screens/games/subscription-plan.dart';
import './screens/games/summary.dart';
import './screens/games/waiting-player.dart';
import './screens/phone-authentication.dart';

import './components/image_crop_screen.dart';

import './testing/components.dart';
import './testing/components_second.dart';
import './testing/compoments_third.dart';
import './testing/components_fourth.dart';
import './testing/rss_feed_list.dart';
import './testing/components_fifth.dart';
import './testing/components_sixth.dart';
import './testing/audio_player_example.dart';
import './testing/video_player_example.dart';
import './testing/google_map_example.dart';
import './testing/geolocation_example.dart';
import './testing/reusable_downloader.dart';
import './testing/firebase_storage_test.dart';
import './testing/test_backblaze.dart';
import './testing/test_aws_s3.dart';
import './testing/test_azure.dart';
import './testing/cache-testing.dart';
import './testing/data-table-example.dart';
import './testing/demo-sqlite.dart';
import './testing/dialog-flow.dart';
import './testing/firebase_chat.dart';
import './testing/native-code-tester.dart';
import './testing/signature-pad.dart';
import './testing/view-pdf.dart';
import './testing/web_socket.dart';
import './testing/components_seventh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TextStyle defaultTextStyle = TextStyle(
    color: Color(kPrimaryTextColor),
    fontSize: 18.0,
  );

  // CREATING APPBAR THEME. WILL BE USED IN THEMEDATA
  final AppBarTheme getLightAppbarTheme = AppBarTheme(
    brightness: Brightness.light,
    color: Color(kAppBackgroundColor),
    elevation: 0,
    textTheme: TextTheme(
      title: TextStyle(
        color: Color(kNavbarTitleColor),
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        fontFamily: 'Inter',
      ),
    ),
    actionsIconTheme: IconThemeData(color: Color(kNavbarIconColor)),
    iconTheme: IconThemeData(color: Color(kNavbarIconColor)),
  );

  // CREATING LIGHT THEMEDATA
  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(kPrimaryColor),
      accentColor: Color(kAccentColor),
      fontFamily: 'Inter',
      appBarTheme: getLightAppbarTheme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth.instance(),
        ),
        ChangeNotifierProvider.value(
          value: RssFeedService(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Education App',
          theme: getLightThemeData(),

          /**
           * AUTHPROVIDER authentication checking.
           */
          home: auth.status == Status.Unauthenticated ? WelcomePage() : HomePage(),

          /**
           * Defining Routes
           */
          routes: {
            /**
             * App Screens
             */
            HomePage.PAGEID: (ctx) => HomePage(),
            WelcomePage.PAGEID: (ctx) => WelcomePage(),
            LoginPage.PAGEID: (ctx) => LoginPage(),
            SignupPage.PAGEID: (ctx) => SignupPage(),
            ForgetPasswordPage.PAGEID: (ctx) => ForgetPasswordPage(),
            ChangePasswordPage.PAGEID: (ctx) => ChangePasswordPage(),
            EmailPasswordRecoveryConfirmation.PAGEID: (ctx) => EmailPasswordRecoveryConfirmation(),
            EmailPinVerification.PAGEID: (ctx) => EmailPinVerification(),
            FaqCategories.PAGEID: (ctx) => FaqCategories(),
            FaqList.PAGEID: (ctx) => FaqList(),
            FaqDetails.PAGEID: (ctx) => FaqDetails(),
            FeedList.PAGEID: (ctx) => FeedList(),
            AboutApp.PAGEID: (ctx) => AboutApp(),
            PrivacyPage.PAGEID: (ctx) => PrivacyPage(),
            TermsOfService.PAGEID: (ctx) => TermsOfService(),
            CourseDetail.PAGEID: (ctx) => CourseDetail(),
            CourseBrowse.PAGEID: (ctx) => CourseBrowse(),
            CourseLessonPage.PAGEID: (ctx) => CourseLessonPage(),
            CourseGroupDiscussion.PAGEID: (ctx) => CourseGroupDiscussion(),
            UserProfile.PAGEID: (ctx) => UserProfile(),
            EditProfile.PAGEID: (ctx) => EditProfile(),
            PersonalInterestValue.PAGEID: (ctx) => PersonalInterestValue(),
            CourseWelcomePage.PAGEID: (ctx) => CourseWelcomePage(),
            ImageCropScreen.PAGEID: (ctx) => ImageCropScreen(),
            LibraryReadScreen.PAGEID: (ctx) => LibraryReadScreen(),
            PhoneAuthentication.PAGEID: (ctx) => PhoneAuthentication(),

            /** 
            *Games pages
            */
            MainScreen.PAGEID: (ctx) => MainScreen(),
            BrowserCategories.PAGEID: (ctx) => BrowserCategories(),
            CreateGame.PAGEID: (ctx) => CreateGame(),
            AddQuiz.PAGEID: (ctx) => AddQuiz(),
            AddQuizTrueFalse.PAGEID: (ctx) => AddQuizTrueFalse(),
            SubCategories.PAGEID: (ctx) => SubCategories(),
            DetailsCredit.PAGEID: (ctx) => DetailsCredit(),
            SubscriptionPlan.PAGEID: (ctx) => SubscriptionPlan(),
            Settings.PAGEID: (ctx) => Settings(),
            QuizGetReady.PAGEID: (ctx) => QuizGetReady(),
            MultiQuestions.PAGEID: (ctx) => MultiQuestions(),
            RatingPage.PAGEID: (ctx) => RatingPage(),
            SummaryQuiz.PAGEID: (ctx) => SummaryQuiz(),
            NickNamePage.PAGEID: (ctx) => NickNamePage(),
            WaitingPlayer.PAGEID: (ctx) => WaitingPlayer(),
            ConnectGame.PAGEID: (ctx) => ConnectGame(),
            CountDown.PAGEID: (ctx) => CountDown(),
            CorrectAnswer.PAGEID: (ctx) => CorrectAnswer(),
            IncorrectAnswer.PAGEID: (ctx) => IncorrectAnswer(),
            AnswerGraph.PAGEID: (ctx) => AnswerGraph(),
            GameOver.PAGEID: (ctx) => GameOver(),

            /**
             * Testing Components
             */
            ComponentSecondPage.PAGEID: (ctx) => ComponentSecondPage(),
            ComponentThirdPage.PAGEID: (ctx) => ComponentThirdPage(),
            ComponentFourthPage.PAGEID: (ctx) => ComponentFourthPage(),
            ComponentFifthPage.PAGEID: (ctx) => ComponentFifthPage(),
            ComponentSixthPage.PAGEID: (ctx) => ComponentSixthPage(),
            ComponentSevenPage.PAGEID: (ctx) => ComponentSevenPage(),
            RssFeedListPage.PAGEID: (ctx) => RssFeedListPage(),
            WebViewContainer.PAGEID: (ctx) => WebViewContainer(),
            AudioPlayerExample.PAGEID: (ctx) => AudioPlayerExample(),
            VideoPlayerExample.PAGEID: (ctx) => VideoPlayerExample(),
            GoogleMapExample.PAGEID: (ctx) => GoogleMapExample(),
            GeolocationExample.PAGEID: (ctx) => GeolocationExample(),
            ReusableDownloaderPage.PAGEID: (ctx) => ReusableDownloaderPage(),
            FireStorageTest.PAGEID: (ctx) => FireStorageTest(),
            TestBackBlaze.PAGEID: (ctx) => TestBackBlaze(),
            TestAwsS3.PAGEID: (ctx) => TestAwsS3(),
            TestAzure.PAGEID: (ctx) => TestAzure(),
            NativeCodeTester.PAGEID: (ctx) => NativeCodeTester(),
            WebSocket.PAGEID: (ctx) => WebSocket(),
            FirebaseChat.PAGEID: (ctx) => FirebaseChat(),
            DialogFlow.PAGEID: (ctx) => DialogFlow(),
            SignaturePad.PAGEID: (ctx)=> SignaturePad(),
            DataTableExample.PAGEID:(ctx)=> DataTableExample(),
            ViewPdf.PAGEID:(ctx)=> ViewPdf(),
            CacheTesting.PAGEID:(ctx)=> CacheTesting(),
            DemoSqlite.PAGEID: (ctx)=> DemoSqlite(),
          },
        ),
      ),
    );
  }
}
