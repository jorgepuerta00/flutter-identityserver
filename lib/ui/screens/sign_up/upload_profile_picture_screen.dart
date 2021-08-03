import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../repository/identity/sign_up_repository.dart';
import 'pronouns_screen.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'email_screen.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  static const String Route = '/sign_up/upload_profile_picture_screen';

  UploadProfilePictureScreen({Key? key}) : super(key: key);

  @override
  _UploadProfilePictureScreenState createState() =>
      _UploadProfilePictureScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  final _verticalSpacing = 25.0;
  File? imageFile;
  late SignUpCubit _signUpCubit;
  late AppState state;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();
    var appTheme = Theme.of(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: TextButton(
          child: Text(
            'Skip for Now',
            style: TextStyle(
                color: appTheme.appBarTheme.textTheme?.headline6?.color,
                fontSize: AppSizes.APPBAR_TRAILING_FONT_SIZE),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(PronounsScreen.Route);
          },
        ),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Back',
          color: appTheme.appBarTheme.textTheme?.headline6?.color,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: appTheme.appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.SCREEN_PADDING_HORIZONTAL,
            right: AppSizes.SCREEN_PADDING_HORIZONTAL,
            top: AppSizes.SCREEN_PADDING_TOP,
            bottom: AppSizes.SCREEN_PADDING_BOTTOM,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Header1(
                    title: '''Upload a Profile Picture''',
                    signs: '.',
                  ),
                  SizedBox(
                    height: _verticalSpacing,
                  ),
                  Text(
                    'Edit your profile picture anytime.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: _verticalSpacing * 6,
                  ),
                  _avatarStack(),
                ],
              ),
              _nextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarStack() {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.imagePath != current.imagePath,
        builder: (context, state) {
          return Stack(
            children: [
              state.imagePath.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: Image.file(
                        File(
                          state.imagePath,
                        ),
                        fit: BoxFit.cover,
                      ).image,
                      radius: 115,
                      backgroundColor: AppColors.WHITE,
                    )
                  : CircleAvatar(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/Intersect.png',
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      radius: 115,
                      backgroundColor: AppColors.GREY_DARK,
                    ),
              Positioned(
                bottom: 1,
                right: 5,
                child: FloatingActionButton(
                  backgroundColor: AppColors.ORANGE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    _modalPopupSelector();
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _modalPopupSelector() {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          Container(
            color: AppColors.GREY_DARK,
            child: CupertinoActionSheetAction(
              child: const Text('Take a Photo'),
              onPressed: () {
                Navigator.pop(context);
                _pickProfilePicture(imageSource: ImageSource.camera);
              },
            ),
          ),
          Container(
            color: AppColors.GREY_DARK,
            child: CupertinoActionSheetAction(
              child: const Text('Select Existing Picture'),
              onPressed: () {
                Navigator.pop(context);
                _pickProfilePicture(imageSource: ImageSource.gallery);
              },
            ),
          ),
        ],
        cancelButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.GREY_DARK,
          ),
          child: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  _pickProfilePicture({
    required ImageSource imageSource,
  }) async {
    final pickedImage = await ImagePicker().getImage(source: imageSource);
    SignUpRepository signUpRepository = context.read<SignUpRepository>();

    if (pickedImage != null && imageFile != null) {
      if (imageFile!.path.isNotEmpty) {
        setState(() {
          imageFile = null;
        });
      }
    }

    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      File? cropped = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        iosUiSettings: IOSUiSettings(),
      );

      setState(() {
        imageFile = cropped;
        state = AppState.picked;
      });

      signUpRepository.uploadProfilePicture(
        filePath: imageFile!.path,
        //TODO: user id harcoded on uploading
        userId: '545DE66E-19AC-47D2-57F6-08D8715337D7',
      );

      _signUpCubit.profilePicturePicked(imageFile!.path);
    }
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.imagePath != current.imagePath,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Step 5 of 7",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors.PRIMARY_SWATCH[200],
                        fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
                  ),
                  ButtonPrimary(
                    //TODO: Pending for image Validator
                    onPressed: state.imagePath.isNotEmpty
                        ? () {
                            Navigator.of(context)
                                .pushNamed(PronounsScreen.Route);
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
        });
  }
}
