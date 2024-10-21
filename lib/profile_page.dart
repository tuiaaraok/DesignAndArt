import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/profile_model.dart';
import 'package:designer_and_artist/profile_page_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<ProfileModel>(HiveBoxes.profile_model).listenable(),
        builder: (context, Box<ProfileModel> box, _) {
          return Scaffold(
              body: Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Portfolio",
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 18.sp,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(fontSize: 16.sp),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  for (int i = box.values.length - 1; i >= 0; i--)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Container(
                        width: 300.w,
                        height: 110.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            color: Colors.black),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 5.h, left: 15.h, right: 5.h),
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    border: Border.all(
                                        color: Color(0xFF98DFD5), width: 2.h),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            MemoryImage(box.getAt(i)!.image!))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.h),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        box.getAt(i)!.name_of_the_picture!,
                                        style: TextStyle(
                                            color: Color(0xFF98DFD5),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: 182.w,
                                        height: 52.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            border: Border.all(
                                                color: Color(0xFF166056),
                                                width: 2.h)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h),
                                          child: Text(
                                            box.getAt(i)!.note!,
                                            style: TextStyle(
                                                color: Color(0xFF8D8D8D),
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  box.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Center(
                            child: Container(
                              width: 340.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  color: Color(0xFF5E7E7A)),
                              child: Column(
                                children: [
                                  Container(
                                    width: 300.h,
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: AssetImage(
                                                "assets/empty_profile.png"))),
                                  ),
                                  Container(
                                    width: 340.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.h,
                                          left: 20.h,
                                          bottom: 20.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "You don't have any\npaintings in your\nprotfolio yet",
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Color(0xFF98DFD5)),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Add your first\npainting",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Color(0xFF3C4C4A)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProfilePageAdd(),
                                                  ),
                                                );
                                              },
                                              child: CircleAvatar(
                                                radius: 26.r,
                                                backgroundColor:
                                                    Color(0xFF98DFD5),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 40.h,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ProfilePageAdd(),
                                ),
                              );
                            },
                            child: Container(
                              width: 200.w,
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(64.r),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "+Add picture",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ));
        });
  }
}
