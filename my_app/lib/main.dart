import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Pages/home_page.dart';
import 'package:my_app/Store/app_state.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/firebase_options.dart';

// import 'Elements/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(store: store, child:
    WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColor().myWhite),
          useMaterial3: true,
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
    );
  }
}
