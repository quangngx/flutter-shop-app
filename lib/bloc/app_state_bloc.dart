import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/constants.dart';
import '../core/helper/log_helper.dart';
import '../core/provider/bloc_provider.dart';

enum AppState { loading, unAuthorized, authorized }

class AppStateBloc implements BlocBase {
  final _appState = BehaviorSubject<AppState>.seeded(AppState.loading);

  String langCode = 'en';

  AppStateBloc() {
    launchApp();
  }

  Stream<AppState> get appState => _appState.stream;

  AppState get appStateValue => _appState.stream.value;

  AppState get initState => AppState.loading;

  LogHelper get logger => const LogHelper('⚡️ AppStateBloc');

  Future<void> changeAppState(AppState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.authorLevel, state.index);
    logger.log('changeAppState $state');

    _appState.sink.add(state);
  }

  @override
  void dispose() {
    _appState.close();
  }

  Future<void> launchApp() async {
    final prefs = await SharedPreferences.getInstance();
    final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;
    logger.log('authorLevel $authorLevel');
    //langCode = prefs.getString('langCode') ?? 'vi';

    switch (authorLevel) {
      case 2:
        await changeAppState(AppState.authorized);
        break;
      default:
        await changeAppState(AppState.unAuthorized);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await changeAppState(AppState.unAuthorized);
  }
}
