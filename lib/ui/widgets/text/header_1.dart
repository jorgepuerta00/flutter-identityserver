import 'package:flutter/material.dart';
import 'package:revvy/ui/constants/AppFonts.dart';
import '../../constants/AppColors.dart';

class Header1 extends StatelessWidget {
  const Header1({
    Key? key,
    required this.title,
    required this.signs,
  }) : super(key: key);

  final String title;
  final String signs;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.headline1,
          children: <TextSpan>[
            TextSpan(
              text: signs,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: AppColors.ORANGE,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
