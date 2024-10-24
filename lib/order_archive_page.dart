import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/order_archive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderArchivePage extends StatefulWidget {
  const OrderArchivePage({super.key});

  @override
  State<OrderArchivePage> createState() => _OrderArchivePageState();
}

class _OrderArchivePageState extends State<OrderArchivePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<OrderArchiveModel>(HiveBoxes.orderArchiveModel)
                .listenable(),
        builder: (context, Box<OrderArchiveModel> box, _) {
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
                          "Order archive",
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
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5.h, left: 15.h, right: 5.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80.h,
                                      width: 80.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r)),
                                          border: Border.all(
                                              color: Color(0xFF98DFD5),
                                              width: 2.h),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: MemoryImage(
                                                  box.getAt(i)!.image!))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: SizedBox(
                                        height: 80.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              child: Text(
                                                box.getAt(i)!.nameOfThePicture!,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Color(0xFF98DFD5),
                                                    height: 1.h,
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              box.getAt(i)!.dateOfDelivery!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xFF8D8D8D),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 10.h,
                                child: Text(
                                  "Complete!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ),
                  if (box.isEmpty)
                    SizedBox(
                      height: 600.h,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You don't have any work\ncompleted yet\nFinish the first job, and he'll",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Color(0xFF166056),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Finish the first work,\nand it's about",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xFF5E7E7A),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
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
