import 'package:flutter/material.dart';
import 'package:kasettakorn/component/bottombar.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';
import 'package:provider/provider.dart';
import 'package:kasettakorn/screens/splash_page.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleNotifier()),
        ChangeNotifierProvider(create: (context) => PlantNotifier()),
        ChangeNotifierProvider(create: (context) => MyPlantNotifier())
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/splashScreen',
      // home: EditProfilePage(),
      routes: <String, WidgetBuilder>{
        '/splashScreen': (BuildContext context) => SplashPage(),
//        BottomBar.routeName: (context) => BottomBar(),
//        '/home': (BuildContext context) => MyHomePage(title: 'Home'),
//         '/bottombar.dart': (BuildContext context) => BottomBar(),
      },
    );
  }
}
