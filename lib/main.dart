import 'dart:developer';

import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/order_archive_model.dart';
import 'package:designer_and_artist/data/model/place_an_order_model.dart';
import 'package:designer_and_artist/data/model/profile_model.dart';
import 'package:designer_and_artist/firebase_options.dart';
import 'package:designer_and_artist/menu_page.dart';
import 'package:designer_and_artist/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(PlaceAnOrderModelAdapter());
  Hive.registerAdapter(OrderArchiveModelAdapter());
  await Hive.openBox<ProfileModel>(HiveBoxes.profileModel);
  await Hive.openBox<PlaceAnOrderModel>(HiveBoxes.placeAnOrderModel);
  await Hive.openBox<OrderArchiveModel>(HiveBoxes.orderArchiveModel);
  await Hive.openBox("privacyLink");
  await _initializeRemoteConfig().then((onValue) {
    runApp(MyApp(
      link: onValue,
    ));
  });
}

Future<String> _initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  var box = await Hive.openBox('privacyLink');
  String link = '';

  if (box.isEmpty) {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    // Defaults setup

    try {
      await remoteConfig.fetchAndActivate();

      link = remoteConfig.getString("link");
    } catch (e) {
      log("Failed to fetch remote config: $e");
    }
  } else {
    if (box.get('link').contains("showAgreebutton")) {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      try {
        await remoteConfig.fetchAndActivate();

        link = remoteConfig.getString("link");
      } catch (e) {
        log("Failed to fetch remote config: $e");
        log("up");
      }
      if (!link.contains("showAgreebutton")) {
        box.put('link', link);
      }
    } else {
      link = box.get('link');
    }
  }

  return link == ""
      ? "https://telegra.ph/ColorCode-Design-and-Art-Privacy-Policy-10-21?showAgreebutton"
      : link;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Color(0xFF98DFD5),
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
            home: Hive.box("privacyLink").isEmpty
                ? WebViewScreen(
                    link: link,
                  )
                : Hive.box("privacyLink")
                        .get('link')
                        .contains("showAgreebutton")
                    ? (Hive.box<ProfileModel>(HiveBoxes.profileModel)
                                .isNotEmpty ||
                            Hive.box<PlaceAnOrderModel>(
                                    HiveBoxes.placeAnOrderModel)
                                .isNotEmpty)
                        ? OnboardingPage()
                        : MenuPage()
                    : WebViewScreen(
                        link: link,
                      ),
          );
        });
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.link});
  final String link;

  @override
  State<WebViewScreen> createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool loadAgree = false;
  WebViewController controller = WebViewController();
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    super.initState();
    if (Hive.box("privacyLink").isEmpty) {
      Hive.box("privacyLink").put('link', widget.link);
    }

    _initializeWebView(widget.link); // Initialize WebViewController
  }

  void _initializeWebView(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              loadAgree = true;
              setState(() {});
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    setState(() {}); // Optional, if you want to trigger a rebuild elsewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Stack(children: [
          WebViewWidget(controller: controller),
          if (loadAgree)
            GestureDetector(
                onTap: () async {
                  await Hive.openBox('privacyLink').then((box) {
                    box.put('link', widget.link);
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => OnboardingPage(),
                      ),
                    );
                  });
                },
                child: widget.link.contains("showAgreebutton")
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 200,
                            height: 60,
                            color: Colors.amber,
                            child: Center(child: Text("AGREE")),
                          ),
                        ))
                    : null),
        ]),
      ),
    );
  }
}
