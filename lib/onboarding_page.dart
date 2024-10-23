import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:designer_and_artist/menu_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemData {
  final String title;
  final Color color;
  final String image;
  final String text1;
  final String text2;

  ItemData(
    this.title,
    this.color,
    this.image,
    this.text1,
    this.text2,
  );
}

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int page = 0;

  final int _numPages = 3;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == page ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 10.0.h : 10.h,
      width: isActive ? 10.w : 10.h,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF4F4F4F) : Colors.transparent,
        border: Border.all(color: Color(0xFF4F4F4F), width: 1.5.h),
        borderRadius: BorderRadius.all(Radius.circular(2.r)),
      ),
    );
  }

  LiquidController liquidController = LiquidController();
  bool push = true;

  List<ItemData> data = [
    ItemData(
        "Order",
        Color(0xFF98DFD5),
        "assets/onboarding1.png",
        "Add Orders For\nYour Convenience",
        "Add Paintings To Your Orders, It's\nEasier To Work, Don't Keep\nEverything In Your Head"),
    ItemData(
      "Portfolio",
      Colors.white,
      "assets/onboarding2.png",
      "Add Your Personal\nPortfolio",
      "Add Your Interesting Work To\nyour Portfolio, Don't Forget\nYour Work",
    ),
    ItemData(
      "Archive",
      Color(0xFFDB445C),
      "assets/onboarding3.png",
      "Completed Work Will\nBe In The Archive",
      "The Pictures You Drew Will\nBe In The Archive So You\nNever Forget.",
    ),
    ItemData(
      "",
      Color(0xFF98DFD5),
      "",
      "Do",
      "try it",
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (index == 3) {
                if (push) {
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => MenuPage(),
                      ),
                    );
                  });
                  push = false;
                }

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome to our app",
                            style: GoogleFonts.purplePurse(
                              textStyle: TextStyle(
                                  fontSize: 32.sp,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w700),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Enjoy using it!",
                            style: GoogleFonts.purplePurse(
                              textStyle: TextStyle(
                                  fontSize: 32.sp,
                                  color: Color(0xFF5E7E7A),
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.paddingOf(context).top,
                            bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Text(data[index].title,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 21.sp,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          MenuPage(),
                                    ),
                                  );
                                },
                                child: Text("Skip",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xFF333333),
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Image.asset(data[index].image,
                          height: 300.h, fit: BoxFit.contain),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(data[index].text1,
                                  style: GoogleFonts.purplePurse(
                                      textStyle: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 29.sp,
                                          fontWeight: FontWeight.w500))),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Text(data[index].text2,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 14.sp))),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _buildPageIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.paddingOf(context).bottom),
                        child: GestureDetector(
                          onTap: () async {
                            final Uri _url = Uri.parse(
                                'https://docs.google.com/document/d/1532C6AqXYJTchuObCw0d5XQMtTx_31k95stEN5ZwCco/mobilebasic');
                            if (!await launchUrl(_url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Terms of use",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.sp),
                                child: Container(
                                  width: 1.5.h,
                                  height: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            positionSlideIcon: 0.55.h,
            slideIconWidget: page != 3
                ? Padding(
                    padding:
                        EdgeInsets.only(top: 33.h, right: 15.w, bottom: 18.h),
                    child: Container(
                      width: 46.r,
                      height: 46.r,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.h, color: data[page].color),
                          borderRadius:
                              BorderRadius.all(Radius.circular(46.r))),
                      child: Icon(Icons.arrow_forward_ios,
                          size: 20.h, color: data[page].color.withOpacity(0.8)),
                    ),
                  )
                : null,
            onPageChangeCallback: (index) {
              setState(() {
                if (index != 3) {
                  page = index;
                } else {
                  liquidController.shouldDisableGestures(disable: true);

                  page = index;
                }
              });
            },
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: page != 2 ? 880.h : 0,
            enableSideReveal: page != 3,
            preferDragFromRevealedArea: page != 3,
            enableLoop: false,
            ignoreUserGestureWhileAnimating: true,
          ),
        ],
      ),
    );
  }
}
