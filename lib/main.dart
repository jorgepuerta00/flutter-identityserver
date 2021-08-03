import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'repository/identity/reset_password_repository.dart';
import 'repository/identity/sign_up_repository.dart';
import 'sot/dialog_message/dialog_message_bloc.dart';
import 'ui/AppRouter.dart';
import 'ui/services/dialog_message_service.dart';
import 'ui/themes/AppDarkTheme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouter _appRouter;

  late SignUpRepository _signUpRepository;
  late ResetPasswordRepository _resetPasswordRepository;

  late DialogMessageBloc _dialogMessageBloc;
  late DialogMessageService _dialogMessageService;

  final _navigatorKey = GlobalKey<NavigatorState>();
  //NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
    _initDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _signUpRepository,
        ),
        RepositoryProvider.value(
          value: _resetPasswordRepository,
        ),
        RepositoryProvider.value(
          value: _dialogMessageService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _dialogMessageBloc),
        ],
        child: BlocListener<DialogMessageBloc, DialogMessageState>(
          listener: (context, state) {
            _listenForDialogMessages(state);
          },
          child: GestureDetector(
            child: MaterialApp(
              title: 'Revvy',
              navigatorKey: _navigatorKey,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: _appRouter.onGenerateRoute,
              theme: buildAppDarkTheme(context),
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              //home: MyHomePage(title: 'Flutter Demo Home Page'),
            ),
            onTap: () {
              _closeKeyboardOnAppTap(context);
            },
          ),
        ),
      ),
    );
  }

  Future _initDependencies() async {
    _signUpRepository = SignUpRepository();
    _resetPasswordRepository = ResetPasswordRepository();

    _dialogMessageBloc = DialogMessageBloc();

    _dialogMessageService = DialogMessageService(
      dialogMessageBloc: _dialogMessageBloc,
    );

    _appRouter = AppRouter(
      signUpRepository: _signUpRepository,
      resetPasswordRepository: _resetPasswordRepository,
      dialogMessageService: _dialogMessageService,
    );
  }

  void _listenForDialogMessages(DialogMessageState state) {
    if (state is DialogMessageInfoState) {
      BuildContext? context = _navigatorKey.currentState?.overlay?.context;
      if (context != null && state.displayDialog) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                InkWell(
                  child: Text(
                    'x',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
            duration: Duration(seconds: 30),
          ),
        );
      }
    } else if (state is DialogMessageErrorState) {
      BuildContext? context = _navigatorKey.currentState?.overlay?.context;
      if (context != null && state.displayDialog) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          ),
        );
      }
    }
  }

  void _closeKeyboardOnAppTap(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _dialogMessageBloc.close();
    super.dispose();
  }
}
