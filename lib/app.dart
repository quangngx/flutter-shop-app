// import 'package:flutter/material.dart';
// import 'package:flutter_shop_app/core/config/config.dart';
// import 'package:flutter_shop_app/core/provider/bloc_provider.dart';
// import 'package:flutter_shop_app/modules/auth/login/login_page.dart';
// import 'package:flutter_shop_app/modules/home/home_page.dart';
//
// import 'bloc/app_state_bloc.dart';
// import 'core/helper/helper.dart';
//
// class MyApp extends StatefulWidget {
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   static final GlobalKey<State> key = GlobalKey();
//   final appStateBloc = AppStateBloc();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         bloc: appStateBloc,
//         child: StreamBuilder<AppState>(
//           stream: appStateBloc.appState,
//           initialData: appStateBloc.initState,
//           builder: (context, snapshot) {
//             if (snapshot.data == AppState.loading) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: Container(
//                   color: Colors.white,
//                 ),
//               );
//             }
//             if (snapshot.data == AppState.unAuthorized) {
//               return BlocProvider(
//                   bloc: appStateBloc,
//                   child: MaterialApp(
//                     debugShowCheckedModeBanner: false,
//                     key: const ValueKey('UnAuthorized'),
//                     theme: ThemeData(
//                       primaryColor: LightTheme.primaryColor2,
//                       scaffoldBackgroundColor: LightTheme.white,
//                       appBarTheme: AppBarTheme(
//                         iconTheme: const IconThemeData(
//                           color: Colors.black, //change your color here
//                         ),
//                         shadowColor: Colors.transparent,
//                         backgroundColor: LightTheme.white,
//                         titleTextStyle:
//                             TextStyles.defaultStyle.medium.setTextSize(22),
//                       ),
//                     ),
//                     routes: unauthorizedRoutes,
//                     onGenerateRoute: generateRoutes,
//                     home: Builder(builder: (context) {
//                       SizeHelper.init(context);
//                       return const LoginPage();
//                     }),
//                   ));
//             }
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               key: key,
//               navigatorKey: MyApp.navigatorKey,
//               routes: authorizedRoutes,
//               onGenerateRoute: generateRoutes,
//               theme: ThemeData(
//                 primaryColor: LightTheme.primaryColor2,
//                 scaffoldBackgroundColor: LightTheme.white,
//                 appBarTheme: AppBarTheme(
//                   iconTheme: const IconThemeData(
//                     color: Colors.black, //change your color here
//                   ),
//                   shadowColor: Colors.transparent,
//                   backgroundColor: LightTheme.white,
//                   titleTextStyle:
//                       TextStyles.defaultStyle.medium.setTextSize(22),
//                 ),
//               ),
//               home: Builder(builder: (context) {
//                 SizeHelper.init(context);
//                 return const HomePage();
//               }),
//             );
//           },
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/authentication_bloc.dart';
import 'package:flutter_shop_app/modules/splash_screen.dart';

import 'core/config/router/routes.dart';
import 'core/config/theme/light_theme.dart';
import 'core/config/theme/textstyle_ext.dart';
import 'core/helper/size_helper.dart';
import 'modules/auth/authentication_repository.dart';
import 'modules/auth/login/login_page.dart';
import 'modules/auth/user_repository.dart';
import 'modules/home/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: _authenticationRepository,
            userRepository: _userRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: LightTheme.primaryColor2,
        scaffoldBackgroundColor: LightTheme.white,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          shadowColor: Colors.transparent,
          backgroundColor: LightTheme.white,
          titleTextStyle: TextStyles.defaultStyle.medium.setTextSize(22),
        ),
      ),
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        SizeHelper.init(context);
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
