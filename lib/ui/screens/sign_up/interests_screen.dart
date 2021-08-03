import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/interests/industry_info.dart';
import '../../../repository/identity/sign_up_repository.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'location_screen.dart';
import 'widgets/interest_item.dart';

class InterestsScreen extends StatefulWidget {
  static const String Route = '/sign_up/interests_screen';
  final TextEditingController _searchInputController = TextEditingController();

  InterestsScreen({Key? key}) : super(key: key);

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<IndustryInfo>? interests = [];
  ScrollController _scrollController = new ScrollController();
  final _verticalSpacing = 25.0;
  int page_number = 1;
  int records_per_page = 100;

  @override
  void initState() {
    super.initState();
    _getInterestItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getInterestItems();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          (previous.selectedIndustriesMap != current.selectedIndustriesMap),
      builder: (context, state) {
        return AppTopPaddingScreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Header1(
                      title: '''What Are Your
          Interest''',
                      signs: '?',
                    ),
                    SizedBox(
                      height: _verticalSpacing,
                    ),
                    Text(
                      'Select 3 to 5',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: _verticalSpacing * 2,
                    ),
                    _searchInput(),
                    SizedBox(
                      height: _verticalSpacing,
                    ),
                    SafeArea(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 400,
                                child: _interestsItemList(context),
                              ),
                            ],
                          ),
                          IgnorePointer(
                            ignoring: true,
                            child: Container(
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
                _nextButton(context, state.selectedIndustriesMap.length),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _interestsItemList(BuildContext context) {
    return ListView.builder(
      itemCount: interests!.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        IndustryInfo info = interests!.elementAt(index);
        return InterestItem(
          backgroundColor: Color(int.parse(info.color)),
          icon: IconData(int.parse(info.icon), fontFamily: 'MaterialIcons'),
          title: info.name,
          subtitle: info.interests,
          id: info.id,
        );
      },
    );
  }

  Widget _searchInput() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: 'Search interest',
            hintStyle: TextStyle(
              color: AppColors.GREY_DARK_STRONG,
            ),
            suffixIcon: Icon(
              Icons.search,
              size: 30,
              color: AppColors.GREY_DARK_STRONG,
            ),
          ),
          controller: widget._searchInputController,
          onChanged: (value) {
            interests!.clear();
            _getInterestItems();
          },
        ),
      ],
    );
  }

  void _getInterestItems() async {
    SignUpRepository signUpRepository = context.read<SignUpRepository>();
    String searchInputText = widget._searchInputController.text;

    var items = await signUpRepository.getInterests(
      filter: searchInputText,
      page: page_number.toString(),
      records: records_per_page.toString(),
    );

    setState(() {
      if (interests!.length == 0) {
        for (int i = 0; i < items.length; i++) {
          interests!.add(items.toList().elementAt(i));
        }
      }
    });
  }

  Widget _nextButton(BuildContext context, int cantIndustriesSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Step 3 of 7",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColors.PRIMARY_SWATCH[200],
                  fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
            ),
            ButtonPrimary(
              onPressed:
                  (cantIndustriesSelected > 2 && cantIndustriesSelected <= 5)
                      ? () {
                          Navigator.of(context).pushNamed(
                            LocationScreen.Route,
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
  }
}
