import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sot/dialog_message/dialog_message_bloc.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';

class ButtonAccent extends StatelessWidget {
  ButtonAccent({
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final Function()? onPressed;

  final _disabledOpacity = .7;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: theme.accentColor,
      //onSurface: AppColors.ORANGE,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.BUTTON_PADDING_VERTICAL,
        horizontal: AppSizes.BUTTON_PADDING_HORIZONTAL,
      ),
      onPrimary: Color(AppColors.BUTTON_ACCENT_TEXT),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: AppSizes.BUTTON_FONT,
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
          case DialogMessageTypeEnum.loading:
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
                        color: AppColors.WHITE,
                        strokeWidth: 3,
                        backgroundColor: AppColors.ORANGE,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(state.message),
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
