import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screen/Authorization/authorization.dart';
import 'screen/Profile/profile.dart';
import 'utility/theme.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Васильев Сергей Demo',
      theme: theme(),
      debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings settings) {
          Map<dynamic, dynamic> map={};
          if(settings.arguments!=null){ map = settings.arguments as Map; }

          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(builder: (_) => const AuthorizationScreen());
            case '/profile':
              return CupertinoPageRoute( builder: (_) => const ProfileScreen());




          }
          return null;
        }
    );
  }
}
