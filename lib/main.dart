import 'package:flutter/material.dart';
import 'package:pkl_demeter_mobile/introduction/onboarding_screen.dart';
import 'package:pkl_demeter_mobile/routes.dart';
import 'package:provider/provider.dart';
import 'package:pkl_demeter_mobile/provider/user_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => UserProvider())],
      child: const HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => RootHome();
}

class RootHome extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoutes,
        home: const OnBoard());
  }
}
