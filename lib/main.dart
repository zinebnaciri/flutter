import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/routes/app_routes.dart';
import 'package:project/firebase_options.dart';
import 'package:project/service/EventService.dart';
import 'package:provider/provider.dart';
 // Import your EventProvider class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventProvider()),
        // Add more providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AZA Sportive Event Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.firstScreen,
      routes: AppRoutes.routes,
    );
  }
}
