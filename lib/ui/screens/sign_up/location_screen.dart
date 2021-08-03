import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../repository/identity/sign_up_repository.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'upload_profile_picture_screen.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class LocationScreen extends StatelessWidget {
  static const String Route = '/sign_up/location_screen';
  final TextEditingController _autocompleteController = TextEditingController();

  LocationScreen({Key? key}) : super(key: key);

  final _verticalSpacing = 25.0;
  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();

    return AppTopPaddingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Header1(
                title: '''Add a
Location''',
                signs: '.',
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              Text(
                'Find relevant opportunities in your area.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: _verticalSpacing * 2,
              ),
              _searchLocationInput(context),
              SizedBox(
                height: _verticalSpacing * 2,
              ),
            ],
          ),
          _nextButton(context),
        ],
      ),
    );
  }

  Widget _searchLocationInput(BuildContext context) {
    SignUpRepository signUpRepository = context.read<SignUpRepository>();
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.location != current.location,
      builder: (context, state) {
        _autocompleteController.text = state.location;
        final errorText = _autocompleteController.text.length == 0
            ? null
            : state.location.length > 0
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
            autofocus: true,
            controller: _autocompleteController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppColors.GREY_DARK_STRONG,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'Enter a city or a country',
              errorText: errorText,
            ),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length > 0) {
              var locations = await signUpRepository.getLocations(
                filter: pattern,
              );
              return locations.map(
                (location) => LocationWithFilterInfo(
                  id: location.id,
                  name: location.name,
                  filter: pattern,
                ),
              );
            }
            return [];
          },
          itemBuilder: (context, suggestion) {
            LocationWithFilterInfo selectedLocation =
                suggestion as LocationWithFilterInfo;

            final filter = selectedLocation.filter.toLowerCase();
            final nameLowerCase = selectedLocation.name.toLowerCase();
            final indexOfFilter = nameLowerCase.indexOf(filter);

            String part1 = selectedLocation.name.substring(0, indexOfFilter);
            String part2 = selectedLocation.name
                .substring(indexOfFilter, indexOfFilter + filter.length);
            String part3 = selectedLocation.name.substring(
                indexOfFilter + filter.length, selectedLocation.name.length);

            return Column(
              children: [
                ListTile(
                  tileColor: AppColors.PRIMARY_SWATCH,
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.WHITE,
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: part1,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: part2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                            children: [
                              TextSpan(
                                text: part3,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17,
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.GREY_DARK_STRONG,
                  height: .1,
                )
              ],
            );
          },
          onSuggestionSelected: (suggestion) {
            if (suggestion == null) {
              return;
            }
            LocationWithFilterInfo selectedLocation =
                suggestion as LocationWithFilterInfo;
            _signUpCubit.locationChanged(selectedLocation.name);
          },
        );
      },
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.location != current.location,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 4 of 7",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.PRIMARY_SWATCH[200],
                      fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
                ),
                ButtonPrimary(
                  onPressed: state.location.length > 0
                      ? () {
                          Navigator.of(context).pushNamed(
                            UploadProfilePictureScreen.Route,
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
