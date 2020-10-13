import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import './edit-profile.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/appbar_iconbtn.dart';
import '../components/circular_badge_progress.dart';
import '../components/custom_chip.dart';
import '../components/custom_circular_badge.dart';
import '../components/custom_progressbar.dart';


class UserProfile extends StatefulWidget {
  static const PAGEID = 'user-profile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

const kExpandedHeight = 360.0;

class _UserProfileState extends State<UserProfile> {
  ScrollController _scrollController;

  double linkedInTop;
  double linkedInOpacity = 1.0;


  @override
  void initState() {
    super.initState();

    linkedInTop = kExpandedHeight - 32;

    /**
     * LISTENING TO SCROLL EVENT SO THAT LINKEDIN BUTTON CAN BE SHOWN AND HIDE 
     * ACCORDINGLY
     */
    _scrollController = ScrollController()
      ..addListener(() {
        double top = kExpandedHeight - _scrollController.offset - 32;

        double newOpacity = ((top * 100) / (kExpandedHeight - 32)) / 100;

        linkedInOpacity =
            newOpacity > 1 ? 1 : (newOpacity < 0 ? 0 : newOpacity);

        if (top > 64) {
          linkedInTop = top;
        } else {
          linkedInTop = 0;
          linkedInOpacity = 0.0;
        }

        setState(() {});
      });
  }

  /**
   * RETURNS BOOLEAN SO THAT WE CAN SHOW/HIDE TITLE
   */
  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - 80;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                getSliverAppBar(),
                getSliverList(),
              ],
            ),
            getLinkedInBtn()
          ],
        ),
      ),
    );
  }

  Widget getFullTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppTitle(
          text: 'John Smith',
          color: const Color(kSecondaryBackgroundColor),
        ),
        AppText(
          text: '@cindyrocks',
          color: const Color(kSecondaryBackgroundColor),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget getShortTitle() {
    return AppText(
      text: 'John Smith',
      fontWeight: FontWeight.bold,
    );
  }

  Widget getLinkedInBtn() {
    return Positioned(
      top: linkedInTop,
      right: 24,
      child: Opacity(
        opacity: linkedInOpacity,
        child: InkWell(
          onTap: () {
            if (linkedInOpacity != 0.0) {
              print('Linkedin tap');
            }
          },
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: new BoxDecoration(
              color: const Color(0xff007AB9),
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/linkedin.png'),
          ),
        ),
      ),
    );
  }

  /**
   * CREATING APPBAR USING SliverAppBar
   */
  Widget getSliverAppBar() {
    return SliverAppBar(
      expandedHeight: kExpandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: _showTitle ? true : false,
        titlePadding: _showTitle ? null : EdgeInsets.only(left: 24.0, bottom: 24.0),
        title: _showTitle ? getShortTitle() : getFullTitle(),
        background: Image.network(
          "https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/avatar.png?alt=media&",
          fit: BoxFit.cover,
        ),
      ),
      leading: getBackButton(context),
      actions: <Widget>[
        AppBarIconButton(
          icon: Icons.edit,
          onPressed: () {
            Navigator.of(context).pushNamed(EditProfile.PAGEID);
          },
        )
      ],
    );
  }


  /**
   * CREATING LISTVIEW USING SliverList
   */
  Widget getSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        getPointsEarned(),
        getBadgesEarned(),
        getUpcomingBadges(),
        getTopInterests(),
        getTopPersonalValue(),
      ]),
    );
  }

  Widget getPointsEarned() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppText(
                text: 'Points Earned',
                fontWeight: FontWeight.w500,
                color: const Color(kChipTextColor),
              ),
              AppTitle(
                text: '20,000',
                fontWeight: FontWeight.w500,
                size: 24.0,
              )
            ],
          ),
          const SizedBox(height: 8.0),
          CustomProgressbar(
            inCompleteValue: MediaQuery.of(context).size.width,
            completeValue: MediaQuery.of(context).size.width * 0.25,
          )
        ],
      ),
    );
  }

  Widget getBadgesEarned() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTitle(text: 'Earned Badges', size: 18),
                  AppBarIconButton(
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0, left: 16.0),
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  CustomCircularBadge(
                    color: const Color(0xff2BB1F3),
                    image: 'assets/images/anchor.png',
                  ),
                  CustomCircularBadge(
                    color: const Color(0xffFEC22D),
                    image: 'assets/images/feather.png',
                  ),
                  CustomCircularBadge(
                    color: const Color(0xffA560EB),
                    image: 'assets/images/umbrella.png',
                  ),
                  CustomCircularBadge(
                    color: const Color(0xff7AC70C),
                    image: 'assets/images/box.png',
                  ),
                  CustomCircularBadge(
                    color: const Color(0xffE53B3B),
                    image: 'assets/images/anchor.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUpcomingBadges() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTitle(text: 'Upcoming Badges', size: 18),
                  AppBarIconButton(
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0, left: 16.0),
              height: 132,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  CircularBadgeProgress(
                    currentProgress: 10,
                    color: const Color(0xff2BB1F3),
                    image: 'assets/images/anchor.png',
                  ),
                  CircularBadgeProgress(
                    currentProgress: 20,
                    color: const Color(0xffFEC22D),
                    image: 'assets/images/feather.png',
                  ),
                  CircularBadgeProgress(
                    currentProgress: 30,
                    color: const Color(0xffA560EB),
                    image: 'assets/images/umbrella.png',
                  ),
                  CircularBadgeProgress(
                    currentProgress: 40,
                    color: const Color(0xff7AC70C),
                    image: 'assets/images/box.png',
                  ),
                  CircularBadgeProgress(
                    currentProgress: 50,
                    color: const Color(0xffE53B3B),
                    image: 'assets/images/anchor.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTopInterests() {
    List<String> interest = [
      'Blogging',
      'Sports',
      'Gaming',
      'Traveling',
      'Art',
    ];

    return buildTitleAndBadge('Top Personal Interests', interest);
  }

  Widget getTopPersonalValue() {
    List<String> personalVal = [
      'Blogging',
      'Sports',
      'Gaming',
      'Traveling',
      'Art',
    ];
    return buildTitleAndBadge('Top Six Personal Values', personalVal);
  }

  Widget buildTitleAndBadge(String title, List<String> badges) {
    return Container(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitle(text: title, size: 18),
          Wrap(
            spacing: 8.0,
            children: badges.map((value) => CustomChip(label: value)).toList(),
          )
        ],
      ),
    );
  }
}
