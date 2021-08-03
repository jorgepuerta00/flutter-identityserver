import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/identity/reset_password_repository.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/sign_up/push_notifications_screen.dart';
import 'screens/sign_up/terms_of_use_screen.dart';

import '../repository/identity/sign_up_repository.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/forgot_password/reset_link_sent_screen.dart';
import 'screens/forgot_password/reset_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/sign_in/cubit/sign_in_cubit.dart';
import 'screens/sign_in/signin_email_screen.dart';
import 'screens/sign_in/signin_password_screen.dart';
import 'screens/sign_up/cubit/sign_up_cubit.dart';
import 'screens/sign_up/date_of_birth_screen.dart';
import 'screens/sign_up/email_code_verification_screen.dart';
import 'screens/sign_up/email_screen.dart';
import 'screens/sign_up/first_last_name_screen.dart';
import 'screens/sign_up/interests_screen.dart';
import 'screens/sign_up/location_screen.dart';
import 'screens/sign_up/password_screen.dart';
import 'screens/sign_up/pronouns_screen.dart';
import 'screens/sign_up/upload_profile_picture_screen.dart';
import 'services/dialog_message_service.dart';

class AppRouter {
  AppRouter({
    required this.signUpRepository,
    required this.resetPasswordRepository,
    required this.dialogMessageService,
  }) {
    _signUpCubit = new SignUpCubit(
      signUpRepository: signUpRepository,
      dialogMessageService: dialogMessageService,
    );
    _signInCubit = new SignInCubit(
      dialogMessageService: dialogMessageService,
    );
  }

  late SignUpRepository signUpRepository;
  late ResetPasswordRepository resetPasswordRepository;
  late SignUpCubit _signUpCubit;
  late SignInCubit _signInCubit;
  late DialogMessageService dialogMessageService;

  Route onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name!.contains("?")) {
      List<String> routeComponents = routeSettings.name!.split('?');

      if (routeComponents.length == 2) {
        routeComponents = routeComponents[1].split('=');

        if (routeComponents.length == 2) {
          return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
              args: ResetPasswordScreenArgs(email: routeComponents[1]),
            ),
          );
        }
      }
    }

    switch (routeSettings.name) {

// #region home
      case HomeScreen.Route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
// #endregion

// #region sign_up
      case EmailScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: EmailScreen(),
          ),
        );

      case PasswordScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: PasswordScreen(),
          ),
        );

      case EmailCodeVerificationScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: EmailCodeVerificationScreen(),
          ),
        );

      case FirstLastNameScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: FirstLastNameScreen(),
          ),
        );

      case DateOfBirthScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: DateOfBirthScreen(),
          ),
        );

      case InterestsScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: InterestsScreen(),
          ),
        );

      case LocationScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: LocationScreen(),
          ),
        );

      case UploadProfilePictureScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: UploadProfilePictureScreen(),
          ),
        );

      case PronounsScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: PronounsScreen(),
          ),
        );

      case PushNotifications.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: PushNotifications(),
          ),
        );

      case TermsOfUse.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signUpCubit,
            child: TermsOfUse(),
          ),
        );
// #endregion

// #region sign_in
      case SignInEmailScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signInCubit,
            child: SignInEmailScreen(),
          ),
        );

      case SignInPasswordScreen.Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _signInCubit,
            child: SignInPasswordScreen(),
          ),
        );
// #endregion

// #region forgot_password
      case ForgotPasswordScreen.Route:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(
            args: routeSettings.arguments as ForgotPasswordScreenArgs,
          ),
        );

      case ResetLinkSentScreen.Route:
        return MaterialPageRoute(
          builder: (_) => ResetLinkSentScreen(
            args: routeSettings.arguments as ResetLinkSentScreenArgs,
          ),
        );

      case ResetPasswordScreen.Route:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            args: routeSettings.arguments as ResetPasswordScreenArgs,
          ),
        );
// #endregion

// #region dashboard
      case DashboardScreen.Route:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(
                  args: routeSettings.arguments as DashboardScreenArgs,
                ));
// #endregion

      //TODO: fix this default route
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      // return MaterialPageRoute(
      //   builder: (_) => BlocProvider.value(
      //     value: _signUpCubit,
      //     child: PronounsScreen(),
      //   ),
      // );

      // return MaterialPageRoute(
      //   builder: (_) => BlocProvider.value(
      //     value: _signUpCubit,
      //     child: LocationScreen(),
      //   ),
      // );
    }
  }

  void dispose() {
    _signUpCubit.close();
    _signInCubit.close();
  }
}
