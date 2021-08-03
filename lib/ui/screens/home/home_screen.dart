import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/text/header_1.dart';
import '../sign_up/email_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String Route = '/home/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _widgetList;

  final CarouselController _buttonCarouselController = CarouselController();

  int _current = 0;

  final _verticalMargin = 25.0;
  double _carrouselWidgetHeightFactor = .73;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    var messages = AppLocalizations.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _widgetList = [
      _carrouselSingleWidget(
        img: 'assets/images/first_carousell_image.png',
        header: '''Redefine
Your Career''',
        title: 'Welcome to Revvy.',
        icon: 'assets/icons/Revvy_icon.png',
      ),
      _carrouselSingleWidget(
        img: 'assets/images/second_carousell_image.png',
        header: '''Create Your 
Personal Brand''',
        title: '''Connect, define & share your 
personal brand.''',
      ),
      _carrouselSingleWidget(
        img: 'assets/images/third_carousell_image.png',
        header: '''Discovery Job 
Opportunities''',
        title: '''Ai powered candidate to 
employer connection.''',
      ),
      _carrouselSingleWidget(
        img: 'assets/images/fourth_carousell_image.png',
        header: '''Land Your 
Dream Job''',
        title: '''Develop professional relationships 
to accomplish your goals.''',
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: _deviceHeight * _carrouselWidgetHeightFactor,
                          aspectRatio: 19 / 9,
                          viewportFraction: 5.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(
                            seconds: 6,
                          ),
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: _widgetList.map(
                          (imgUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: _deviceHeight *
                                      _carrouselWidgetHeightFactor,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                  ),
                                  child: imgUrl,
                                );
                              },
                            );
                          },
                        ).toList(),
                        carouselController: _buttonCarouselController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _verticalMargin * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _widgetList.map((url) {
                    int index = _widgetList.indexOf(url);
                    return Container(
                      width: 9.0,
                      height: 9.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _current == index ? Colors.white : Colors.white38,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.SCREEN_PADDING_HORIZONTAL,
                right: AppSizes.SCREEN_PADDING_HORIZONTAL,
                bottom: AppSizes.SCREEN_PADDING_TOP * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ButtonAccent(
                    child: Text('Get Started'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        EmailScreen.Route,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _carrouselSingleWidget({
    required String header,
    required String title,
    required String img,
    String? icon,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.PRIMARY_SWATCH,
          ),
          child: Image.asset(
            img,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          width: double.infinity,
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
        Positioned(
          bottom: 10,
          right: 150,
          left: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header1(
                title: header,
                signs: '.',
              ),
              SizedBox(
                height: _verticalMargin,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        height: 1.5,
                      ),
                ),
              )
            ],
          ),
        ),
        icon != null
            ? Center(
                child: Image.asset(icon),
              )
            : Center()
      ],
    );
  }
}
