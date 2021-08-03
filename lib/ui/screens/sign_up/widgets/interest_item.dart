import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oauth2/oauth2.dart';

import '../../../../models/interests/industry_info.dart';
import '../../../constants/AppColors.dart';
import '../../../constants/AppSizes.dart';
import '../cubit/sign_up_cubit.dart';

class InterestItem extends StatelessWidget {
  const InterestItem({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.id,
  }) : super(key: key);

  final String id;
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    bool selected;
    late SignUpCubit _signUpCubit = context.read<SignUpCubit>();
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          (previous.selectedIndustriesMap != current.selectedIndustriesMap),
      builder: (context, state) {
        selected = state.selectedIndustriesMap.containsKey(id);
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: InkWell(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: selected ? backgroundColor : AppColors.GREY,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        child: Icon(
                          icon,
                          color: AppColors.WHITE,
                          size: 40,
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: selected
                              ? Color(icon.codePoint)
                              : backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: AppColors.WHITE,
                                  fontSize: AppSizes.TEXT_HEADLINE2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              subtitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.WHITE,
                                fontSize: AppSizes.TEXT_BODYTEXT1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 100),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, right: 15),
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: AppColors.GREY_DARK_STRONG,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.transparent,
                                duration: Duration(days: 1),
                                content: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 10),
                                  constraints: BoxConstraints(
                                      minHeight: 150, minWidth: 260),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
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
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '''${title}''',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: 250,
                                        child: Text(
                                          subtitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          color: AppColors.BLUE_LIGHT,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              if (!selected) {
                IndustryInfo selectedIndustry = IndustryInfo(
                  name: title,
                  color: backgroundColor.toString(),
                  icon: icon.codePoint.toString(),
                  interests: subtitle,
                  id: id,
                );
                _signUpCubit.industryAdded(
                    selectedIndustry.id, selectedIndustry);
              } else {
                _signUpCubit.industryRemoved(id);
              }
            },
          ),
        );
      },
    );
  }
}
