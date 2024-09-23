import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/order_archive_model.dart';
import 'package:designer_and_artist/data/model/place_an_order_model.dart';
import 'package:designer_and_artist/order_archive_page.dart';
import 'package:designer_and_artist/place_an_order_add_page.dart';
import 'package:designer_and_artist/profile_page.dart';
import 'package:designer_and_artist/profile_page_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = -1;
  String _buildDateOfDeliveryText(String dateStr) {
    // Разбить строку на части (день, месяц, год)
    List<String> parts = dateStr.split('.');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    DateTime deliveryDate = DateTime(year, month, day);

    // Получить текущую дату
    DateTime now = DateTime.now();

    // Вычислить разницу в днях
    Duration difference = deliveryDate.difference(now);
    int daysLeft = difference.inDays;

    return "Date of delivery: $daysLeft";
  }

  Color _getDateTextColor(String dateStr) {
    // Разбить строку на части (день, месяц, год)
    List<String> parts = dateStr.split('.');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    DateTime deliveryDate = DateTime(year, month, day);

    // Получить текущую дату
    DateTime now = DateTime.now();

    // Вычислить разницу в днях
    Duration difference = deliveryDate.difference(now);
    int daysLeft = difference.inDays;

    // Вернуть цвет в зависимости от разницы
    return (daysLeft < 0) ? Colors.red : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<PlaceAnOrderModel>(HiveBoxes.place_an_order_model)
                .listenable(),
        builder: (context, Box<PlaceAnOrderModel> box, _) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ProfilePage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 200.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(64.r))),
                            child: Center(
                                child: Text(
                              "Portfolio",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    OrderArchivePage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 200.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(64.r))),
                            child: Center(
                                child: Text(
                              "Order archive",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PlaceAnOrderAddPage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 26.r,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.add,
                              size: 25.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Container(
                          width: 340.w,
                          child: Text("Your paintings",
                              style: GoogleFonts.purplePurse(
                                textStyle: TextStyle(
                                    fontSize: 24.sp,
                                    color: Color(0xFF5E7E7A),
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                      ),
                      for (int i = 0; i < box.values.length; i++)
                        currentIndex == i
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  height: 331.h,
                                  width: 300.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF80B0AA),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r))),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 300.w,
                                        height: 110.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            color: Colors.black),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5.h,
                                              left: 15.h,
                                              right: 5.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 80.h,
                                                width: 80.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF98DFD5),
                                                        width: 2.h),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: MemoryImage(box
                                                            .getAt(i)!
                                                            .image!))),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.h),
                                                child: Container(
                                                  height: 80.h,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        box
                                                            .getAt(i)!
                                                            .name_of_the_picture!,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF98DFD5),
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // Обработка даты доставки
                                                      Text(
                                                        box.getAt(i)!.isComlete!
                                                            ? "Complete!"
                                                            : _buildDateOfDeliveryText(box
                                                                .getAt(i)!
                                                                .date_of_delivery!),
                                                        style: TextStyle(
                                                          color: box
                                                                  .getAt(i)!
                                                                  .isComlete!
                                                              ? Colors.white
                                                              : _getDateTextColor(box
                                                                  .getAt(i)!
                                                                  .date_of_delivery!),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        box
                                                            .getAt(i)!
                                                            .date_of_delivery!,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF8D8D8D),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndex = -1;
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 16.r,
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.25),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.keyboard_arrow_up,
                                                        color:
                                                            Color(0xFF98DFD5),
                                                        size: 30.h,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Notes",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Color(0xFF5E7E7A),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 240.w,
                                              height: 160.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: Color(0xFF678A85),
                                                  border: Border.all(
                                                      color: Color(0xFF166056),
                                                      width: 2.h)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 10.h),
                                                child: Text(
                                                  box.getAt(i)!.note!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  width: 300.w,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
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
                                          child: Container(
                                            height: 80.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  box
                                                      .getAt(i)!
                                                      .name_of_the_picture!,
                                                  style: TextStyle(
                                                      color: Color(0xFF98DFD5),
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  box.getAt(i)!.isComlete!
                                                      ? "Complete!"
                                                      : _buildDateOfDeliveryText(
                                                          box
                                                              .getAt(i)!
                                                              .date_of_delivery!),
                                                  style: TextStyle(
                                                    color: box
                                                            .getAt(i)!
                                                            .isComlete!
                                                        ? Colors.white
                                                        : _getDateTextColor(box
                                                            .getAt(i)!
                                                            .date_of_delivery!),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  box
                                                      .getAt(i)!
                                                      .date_of_delivery!,
                                                  style: TextStyle(
                                                      color: Color(0xFF8D8D8D),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        box.getAt(i)!.isComlete!
                                            ? Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndex = i;
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 16.r,
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.25),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0xFF98DFD5),
                                                        size: 30.h,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.h, top: 10.h),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          OrderArchiveModel
                                                              addOrderDone =
                                                              OrderArchiveModel(
                                                            image: box
                                                                .getAt(i)!
                                                                .image,
                                                            name_of_the_picture: box
                                                                .getAt(i)!
                                                                .name_of_the_picture,
                                                            date_of_delivery: box
                                                                .getAt(i)!
                                                                .date_of_delivery,
                                                          );
                                                          Box<OrderArchiveModel>
                                                              contactsBox =
                                                              Hive.box<
                                                                      OrderArchiveModel>(
                                                                  HiveBoxes
                                                                      .order_archive_model);
                                                          contactsBox.add(
                                                              addOrderDone);
                                                          PlaceAnOrderModel
                                                              addwishfriend =
                                                              PlaceAnOrderModel(
                                                                  image: box
                                                                      .getAt(i)!
                                                                      .image,
                                                                  name_of_the_picture: box
                                                                      .getAt(i)!
                                                                      .name_of_the_picture,
                                                                  date_of_delivery:
                                                                      DateFormat(
                                                                              "dd.MM.y")
                                                                          .format(DateTime
                                                                              .now()),
                                                                  note: box
                                                                      .getAt(i)!
                                                                      .note,
                                                                  isComlete:
                                                                      true);
                                                          box.putAt(
                                                              i, addwishfriend);
                                                        },
                                                        child: Container(
                                                          width: 30.h,
                                                          height: 30.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.r)),
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .check_circle_outlined,
                                                              size: 25.h,
                                                              color: Color(
                                                                  0xFF98DFD5),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          currentIndex = i;
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 16.r,
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.25),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Color(
                                                                0xFF98DFD5),
                                                            size: 30.h,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      if (box.isEmpty)
                        Container(
                          width: 340.w,
                          height: 440.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              color: Color(0xFF5E7E7A)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Column(
                              children: [
                                Container(
                                  width: 280.h,
                                  height: 280.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/empty_paiting.png"))),
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "You don't have any\npaintings yet",
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF98DFD5)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Add your first works",
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: Color(0xFF3C4C4A)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25.h,
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
                                              builder: (BuildContext context) =>
                                                  PlaceAnOrderAddPage(),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 26.r,
                                          backgroundColor: Color(0xFF98DFD5),
                                          child: Icon(
                                            Icons.add,
                                            size: 25.h,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
