import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rickyshit/app_navigation.dart';
import 'package:rickyshit/firebase_options.dart';
import 'package:rickyshit/states/local_user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rick & Morty',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppNavigation.generateRoute,
      initialRoute: AppNavigation.home,
    );
  } 
}
