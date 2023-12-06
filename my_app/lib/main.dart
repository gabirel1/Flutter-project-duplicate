import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Pages/home_page.dart';
import 'package:my_app/Store/Reducers/app_reducer.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/firebase_options.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: <Middleware<AppState>>[
      LoggingMiddleware<AppState>.printer().call,
    ],
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColor().myWhite),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
