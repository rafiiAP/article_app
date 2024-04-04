import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:article_app/common/navigation.dart';
import 'package:article_app/data/db/database_helper.dart';
import 'package:article_app/provider/database_provider.dart';
import 'package:article_app/provider/scheduling_provider.dart';
import 'package:article_app/utils/permission_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api.dart/api_service.dart';
import 'data/model/article.dart';
import 'data/preferences/preferences_helper.dart';
import 'provider/news_provider.dart';
import 'provider/preferences_provider.dart';
import 'ui/article_detail_page.dart';
import 'ui/article_web_view.dart';
import 'ui/home_page.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  final MyPermission _permisssion = MyPermission();

  _permisssion.init();
  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'News App',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                    article:
                        ModalRoute.of(context)?.settings.arguments as Article,
                  ),
              ArticleWebView.routeName: (context) => ArticleWebView(
                    url: ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
