import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ProfilePageAdd extends StatefulWidget {
  @override
  State<ProfilePageAdd> createState() => _ProfilePageAddState();
}

class _ProfilePageAddState extends State<ProfilePageAdd> {
  Uint8List? _image;
  TextEditingController nameOfThePictureController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  FocusNode _nodeText1 = FocusNode();
  Future getLostData() async {
    try {
      XFile? picker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      List<int> imageBytes = await picker.readAsBytes();
      _image = Uint8List.fromList(imageBytes);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  _updateFormCompletion() {
    bool isFilled = nameOfThePictureController.text.isNotEmpty &&
        noteController.text.isNotEmpty &&
        _image != null;

    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    nameOfThePictureController.addListener(_updateFormCompletion);
    noteController.addListener(_updateFormCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: KeyboardActions(
            config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                nextFocus: true,
                actions: [
                  KeyboardActionsItem(
                    focusNode: _nodeText1,
                  ),
                ]),
            child: SingleChildScrollView(
              child: Container(
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
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        getLostData();
                      },
                      child: Container(
                          height: 120.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: Color(0xFF166056).withOpacity(0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.25),
                                width: 2.h),
                            image: _image == null
                                ? null
                                : DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.cover),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Insert image",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: _image == null
                                        ? null
                                        : Color(0xFF166056)),
                              ),
                              CircleAvatar(
                                radius: 12.r,
                                backgroundColor: _image == null
                                    ? Colors.black
                                    : Color(0xFF166056),
                                child: Icon(
                                  Icons.add,
                                  size: 22.h,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Column(
                        children: [
                          Container(
                            width: 300.w,
                            child: Text(
                              "Name of the picture",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 50.h,
                            width: 300.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.25),
                                  width: 2.h),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              color: Color(0xFF166056).withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: TextField(
                                controller: nameOfThePictureController,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 18.sp,
                                  ),
                                ),
                                cursorColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300.w,
                          child: Text(
                            "Notes",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 240.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.25),
                                width: 2.h),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            color: Color(0xFF166056).withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              minLines: 1,
                              maxLines: 5, // Set a maximum number of lines
                              controller: noteController,
                              focusNode: _nodeText1,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Notes...',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.sp,
                                ),
                              ),
                              cursorColor: Colors.white,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),

                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_updateFormCompletion()) {
                          Box<ProfileModel> contactsBox =
                              Hive.box<ProfileModel>(HiveBoxes.profile_model);
                          ProfileModel addwishfriend = ProfileModel(
                            image: _image!,
                            name_of_the_picture:
                                nameOfThePictureController.text,
                            note: noteController.text,
                          );
                          contactsBox.add(addwishfriend);
                          Navigator.of(
                            context,
                          ).pop();
                        }
                      },
                      child: Container(
                        width: 200.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(46.r)),
                            color: Colors.black),
                        child: Center(
                            child: Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: _updateFormCompletion()
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
