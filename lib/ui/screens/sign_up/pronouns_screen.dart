import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'push_notifications_screen.dart';

class PronounsScreen extends StatelessWidget {
  static const String Route = '/sign_up/pronouns_screen';
  final TextEditingController _autocompleteController = TextEditingController();

  static List<String> PronounsOptions = [
    'co / cos',
    'e / ey / em / eir',
    'fae / faer',
    'he / him / his',
    'she / her / hers',
    'mer / mers',
    'ne / nir / nirs',
  ];

  PronounsScreen({Key? key}) : super(key: key);

  final _verticalSpacing = 25.0;
  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();

    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header1(
                  title: '''What Are Your 
      Pronouns?''',
                  signs: '.',
                ),
                SizedBox(
                  height: _verticalSpacing,
                ),
                Text(
                  '''Let people know how to 
      address you correctly. 
      You can edit or hide your 
      pronouns anytime.''',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Pronouns',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              color: AppColors.WHITE,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                _detailsSnackbar(context),
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _searchLocationInput(context),
                    SizedBox(
                      height: _verticalSpacing - 5,
                    ),
                    _pronounVisibilityInput(),
                  ],
                ),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
              ],
            ),
            _nextButton(context),
          ],
          //                     onPressed: () async {
          //                       await Flushbar(
          //                         borderRadius: BorderRadius.circular(30),
          //                         titleText: Padding(
          //                           padding: const EdgeInsets.only(left: 7),
          //                           child: Column(
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: [
          //                               Stack(
          //                                 children: [
          //                                   Container(
          //                                     width: 800,
          //                                     child: Image.asset(
          //                                       'assets/images/flasbar_image.png',
          //                                       fit: BoxFit.fill,
          //                                     ),
          //                                   ),
          //                                   Positioned(
          //                                     right: 10,
          //                                     top: 10,
          //                                     child: IconButton(
          //                                       icon: Icon(Icons.close_outlined),
          //                                       onPressed: () {
          //                                         Navigator.pop(context);
          //                                       },
          //                                     ),
          //                                   )
          //                                 ],
          //                               ),
          //                               SizedBox(height: _verticalSpacing),
          //                               Text(
          //                                 'Pronouns',
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .headline1!
          //                                     .copyWith(
          //                                         fontSize: 22,
          //                                         fontFamily: AppFonts.SFProText,
          //                                         fontWeight: FontWeight.w800),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         messageText: Padding(
          //                           padding: const EdgeInsets.only(left: 7),
          //                           child: Text(
          //                             '''Pronouns are the words used to refer to you. Your pronouns may or may not relate to your sex assignedat birth or gender identity.

          // Some examples for pronouns are: she/her, he/him, they/them, ze/zir, she/they, they/she...''',
          //                             style: Theme.of(context)
          //                                 .textTheme
          //                                 .bodyText1!
          //                                 .copyWith(
          //                                     fontSize: 12,
          //                                     fontFamily: AppFonts.SFProText,
          //                                     fontWeight: FontWeight.w400,
          //                                     color: AppColors.GREY_DARK_STRONG),
          //                           ),
          //                         ),
          //                         duration: Duration(seconds: 9),
          //                       ).show(context);
          //                     },
          //                   )
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               _searchLocationInput(context),
          //               SizedBox(
          //                 height: _verticalSpacing - 5,
          //               ),
          //               _pronounVisibilityInput(),
          //             ],
          //           ),
          //           SizedBox(
          //             height: _verticalSpacing * 2,
          //           ),
          //         ],
          //       ),
          //       _nextButton(context),
          //     ],
        ),
      ),
    );
  }

  SnackBar _detailsSnackbar(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      duration: Duration(days: 1),
      content: Container(
        padding: EdgeInsets.only(left: 18, right: 20),
        width: 100,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    'assets/images/flasbar_image.png',
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 20,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.GREY,
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.WHITE,
                          size: 20,
                        ),
                        color: AppColors.GREY,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: AppColors.GREY_DARK_2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Pronouns',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            Container(
              height: 125,
              decoration: BoxDecoration(
                color: AppColors.GREY_DARK_2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 12),
                child: Text(
                  '''\nPronouns are the words used to refer to you. Your pronouns may or may not relate to your sex assigned at birth or gender identity.

Some examples for pronouns are: 
she/her, he/him, they/them, ze/zir, she/they, 
they/she...''',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.GREY_DARK_STRONG),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchLocationInput(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.pronouns != current.pronouns,
      builder: (context, state) {
        _autocompleteController.text = state.pronouns;
        final errorText = _autocompleteController.text.length == 0
            ? null
            : state.pronouns.length > 0
                ? null
                : '';
        return TypeAheadField(
          errorBuilder: (context, error) => Container(
            color: AppColors.PRIMARY_COLOR,
            child: Text(''),
          ),
          hideOnLoading: true,
          hideOnEmpty: true,
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            controller: _autocompleteController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.GREY_DARK_STRONG,
                ),
              ),
              //floatingLabelBehavior: FloatingLabelBehavior.never,
              errorText: errorText,
            ),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length > 0) {
              return PronounsOptions.where(
                  (element) => element.contains(pattern)).toList();
            }
            return PronounsOptions;
          },
          itemBuilder: (context, suggestion) {
            String pronouns = suggestion as String;

            return Column(
              children: [
                ListTile(
                  tileColor: AppColors.GREY_DARK_2,
                  title: Text(pronouns),
                ),
                Divider(
                  color: AppColors.GREY_DARK,
                  height: .1,
                )
              ],
            );
          },
          onSuggestionSelected: (suggestion) {
            if (suggestion == null) {
              return;
            }
            _signUpCubit.pronounsChanged(suggestion as String);
          },
        );
      },
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.pronouns != current.pronouns,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 6 of 7",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.PRIMARY_SWATCH[200],
                      fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
                ),
                ButtonPrimary(
                  onPressed: state.pronouns.length > 0
                      ? () {
                          Navigator.of(context).pushNamed(
                            PushNotifications.Route,
                          );
                        }
                      : null,
                  child: Row(
                    children: [
                      Text(
                        'Next',
                      ),
                      Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  Widget _pronounVisibilityInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TopLabeledInput(
          label: 'Visibility',
          widget: Container(
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
                    state.isPronounsPublic ? 'Public' : 'Just for you',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16,
                          letterSpacing: .1,
                        ),
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: CupertinoSwitch(
                      value: state.isPronounsPublic,
                      onChanged: (bool value) {
                        _signUpCubit.isPronounsPublicChanged(value);
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

class LocationWithFilterInfo {
  final String name;
  final String id;
  final String filter;
  LocationWithFilterInfo({
    required this.name,
    required this.id,
    required this.filter,
  });
}
