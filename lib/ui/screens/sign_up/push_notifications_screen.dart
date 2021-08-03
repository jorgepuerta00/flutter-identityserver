import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:revvy/ui/screens/sign_up/pronouns_screen.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/platform/platform_scaffold.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'terms_of_use_screen.dart';

class PushNotifications extends StatefulWidget {
  static const String Route = '/home/push_notifications_screen';

  const PushNotifications({Key? key}) : super(key: key);

  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  late List<Widget> _widgetList;

  final CarouselController _buttonCarouselController = CarouselController();

  int _current = 0;

  final _verticalMargin = 25.0;

  late double _deviceHeight;
  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);
    _signUpCubit = context.read<SignUpCubit>();
    var messages = AppLocalizations.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      body: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CupertinoNavigationBar(
          brightness: Brightness.dark,
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Back',
            color: appTheme.appBarTheme.textTheme?.headline6?.color,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_SWATCH,
                          ),
                          child: Image.asset(
                            'assets/images/first_carousell_image.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.1,
                                0.85,
                              ],
                              colors: <Color>[
                                AppColors.PRIMARY_SWATCH,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.1,
                                0.85,
                              ],
                              colors: <Color>[
                                Colors.transparent,
                                AppColors.PRIMARY_SWATCH,
                              ],
                            ),
                          ),
                          height: 500,
                        )
                      ],
                    ),
                    Positioned(
                      top: 120,
                      right: 120,
                      child: Image.asset('assets/icons/Revvy_icon.png'),
                    ),
                    Positioned(
                      top: 320,
                      left: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Header1(
                            title: '''Opportunities
Await You''',
                            signs: '.',
                          ),
                          SizedBox(
                            height: _verticalMargin,
                          ),
                          Center(
                            child: Text(
                              'Turn on push notifications',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    height: 1.5,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _pushNotificationsInput()
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.SCREEN_PADDING_HORIZONTAL,
                right: AppSizes.SCREEN_PADDING_HORIZONTAL,
                bottom: AppSizes.SCREEN_PADDING_TOP * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ButtonAccent(
                    child: Text('Finish'),
                    onPressed: () {
                      _signUpCubit.finishSignUp(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pushNotificationsInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.pushNotifications != current.pushNotifications,
      builder: (context, state) {
        return TopLabeledInput(
          label: '',
          widget: Container(
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.GREY_DARK,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Push Notifications',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16,
                          letterSpacing: .1,
                        ),
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: CupertinoSwitch(
                      value: state.pushNotifications,
                      onChanged: (bool value) {
                        _signUpCubit.setPushNotifications(value);
                      },
                      activeColor: AppColors.ORANGE,
                      trackColor: AppColors.GREY_DARK_3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
