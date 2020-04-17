import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/moreInformationDataModel.dart';
import 'package:covid_19/moreInformationDetails.dart';
import 'package:flutter/material.dart';

final List<MoreInformationDataModel> moreInformationModel = [
  aboutCovid19,
  covid19Symptom,
  washingYourHands,
  isolateYourselfFromOthers,
  socialDistancing,
  cleaningAndDisinfectingSurfaces,
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  moreInformationModel,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          //Image.asset(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. $index image',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          moreInformationModel,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Auto playing carousel
    final CarouselSlider autoPlayDemo = CarouselSlider(
      viewportFraction: 0.9,
      height: 200,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: moreInformationModel.map(
        (moreInformationModel) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MoreInformationDetails(
                              aboutDataModel: moreInformationModel,
                                ), fullscreenDialog: true));
            },
            child: Container(
                width: 1000,
                color: moreInformationModel.backgroundColor,
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        moreInformationModel.imageName,
                        width: 100,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 16.0, right: 16.0),
                          child: Text(moreInformationModel.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .color,
                                  fontSize: 20)),
                        ),
                      )
                    ]),
                  ),
                )),
          );
        },
      ).toList(),
    );

    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(children: [
        Text('Offical Tips',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                //color: Colors.white,
                fontSize: 30)),
        autoPlayDemo,
      ]),
    );
  }
}
