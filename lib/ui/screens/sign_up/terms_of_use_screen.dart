import 'package:flutter/material.dart';
import 'package:revvy/ui/constants/AppColors.dart';

import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';

class TermsOfUse extends StatefulWidget {
  static const String Route = '/forgot_password/reset_password_screen';

  TermsOfUse({Key? key}) : super(key: key);

  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  final _verticalSpacing = 25.0;

  @override
  Widget build(BuildContext context) {
    return AppTopPaddingScreen(
      child: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header1(
                    title: '''Terms of Use''',
                    signs: '.',
                  ),
                  SizedBox(
                    height: _verticalSpacing * 2,
                  ),
                  Text(
                    'Revvy Agreement to Terms',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: _verticalSpacing,
                  ),
                  Text(
                    '''These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and [business entity name] (“we,” “us” or “our”), concerning your access to and use of the [website name.com] website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, the “Site”).

You agree that by accessing the Site, you have read, understood, and agree to be bound by all of these.
                
These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on  by accessing the Site, you have read, understood, and agree to be bound by all of these.
                ''',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
              Container(
                height: 100,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
