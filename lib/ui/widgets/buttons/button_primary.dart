import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sot/dialog_message/dialog_message_bloc.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../constants/AppSizes.dart';

class ButtonPrimary extends StatelessWidget {
  ButtonPrimary({
    required this.child,
    this.onPressed,
    this.icon,
  });

  final Widget child;
  final Function()? onPressed;
  final Widget? icon;

  final _disabledOpacity = .7;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: theme.primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.BUTTON_PADDING_VERTICAL / 1.5,
        horizontal: AppSizes.BUTTON_PADDING_HORIZONTAL,
      ),
      onPrimary: Colors.black,
      textStyle: TextStyle(
        fontFamily: AppFonts.SFProText,
        fontWeight: FontWeight.w600,
        fontSize: AppSizes.BUTTON_FONT,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSizes.BUTTON_BORDER_RADIUS,
          ),
        ),
      ),
    );

    Widget btnWidget = BlocBuilder<DialogMessageBloc, DialogMessageState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        switch (state.status) {
          case DialogMessageTypeEnum.warning:
            return Opacity(
              opacity: _disabledOpacity,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: AppColors.GREY_DARK,
                        strokeWidth: 3,
                        backgroundColor: AppColors.WHITE,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(state.message),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.chevron_right_outlined)
                  ],
                ),
                style: buttonStyle,
              ),
            );

          default: //Not loading state
            final btn = ElevatedButton(
              onPressed: this.onPressed == null ? () {} : this.onPressed,
              child: this.child,
              style: buttonStyle,
            );

            if (this.onPressed == null) {
              return Opacity(
                opacity: _disabledOpacity,
                child: btn,
              );
            }

            return btn;
        }
      },
    );

    return btnWidget;
  }
}
