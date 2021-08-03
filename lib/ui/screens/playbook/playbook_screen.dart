import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/email_validator.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/screen/app_appbar_screen.dart';
import '../sign_up/password_screen.dart';

class PlayBookScreen extends StatefulWidget {
  static const String Route = '/playbook/playbook_screen';

  const PlayBookScreen({Key? key}) : super(key: key);

  @override
  _PlayBookScreenState createState() => _PlayBookScreenState();
}

class _PlayBookScreenState extends State<PlayBookScreen> {
  EmailValidator _emailValidator = EmailValidator.pure(
    isRequired: true,
  );

  @override
  Widget build(BuildContext context) {
    var _verticalMargin = 10.0;
    var messages = AppLocalizations.of(context);

    return AppAppBarScreen(
      widget: Column(
        children: [
          _HeadLine1(),
          SizedBox(
            height: _verticalMargin,
          ),
          _BodyText1(),
          SizedBox(
            height: _verticalMargin,
          ),
          _topLabeledInput(),
          SizedBox(
            height: _verticalMargin * 2,
          ),
          _ButtonAccent(),
          SizedBox(
            height: _verticalMargin * 2,
          ),
          SizedBox(
            height: _verticalMargin,
          ),
          _ButtonPrimary()
        ],
      ),
    );
  }

  TopLabeledInput _topLabeledInput() {
    return TopLabeledInput(
      label: 'Email',
      widget: EmailInput(
        emailValidator: _emailValidator,
        onChanged: (String value) {
          setState(() {
            _emailValidator = EmailValidator.dirty(
              value: value,
            );
          });
        },
      ),
    );
  }
}

class _ButtonPrimary extends StatelessWidget {
  const _ButtonPrimary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ButtonPrimary(
          child: Row(
            children: <Widget>[
              Text(
                'Next',
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: AppSizes.BUTTON_PRIMARY_ICON_HEIGHT,
              ),
            ],
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 2,
        ),
      ],
    );
  }
}

class _ButtonAccent extends StatelessWidget {
  const _ButtonAccent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ButtonAccent(
          child: Text('Button Accent'),
          onPressed: () {
            Navigator.of(context).pushNamed(PasswordScreen.Route);
          },
        ),
      ],
    );
  }
}

class _BodyText1 extends StatelessWidget {
  const _BodyText1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Body text 1',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class _HeadLine1 extends StatelessWidget {
  const _HeadLine1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Head line 1',
        style: Theme.of(context).textTheme.headline1,
        children: <TextSpan>[
          TextSpan(
            text: '?',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: AppColors.ORANGE,
                ),
          )
        ],
      ),
    );
  }
}
