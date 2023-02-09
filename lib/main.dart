import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/firebase_options.dart';

import 'app.dart';
import 'core/common/blocs/chatty_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = ChattyBlocObserver();
  runApp(const MyApp());
}
