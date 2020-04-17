import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:covid_19/historyView.dart';
import 'package:covid_19/widgets/cases.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart' show kIsWeb;
class CountryDetailsView extends StatefulWidget {
  final Country country;

  CountryDetailsView({this.country});

  @override
  _CountryDetailsViewState createState() => _CountryDetailsViewState();
}

class _CountryDetailsViewState extends State<CountryDetailsView> {
  List<charts.Series<Stats, String>> _seriesPieData;

  _getValue(int actual, int total) {
    return double.parse(((actual / total) * 100).toStringAsFixed(0));
  }

  _genrateDataPiedata() {
    List<Stats> _piedata = List<Stats>();
    if (widget.country.active != null) {
      _piedata.add(Stats('Total Active',
          _getValue(widget.country.active, widget.country.cases), Colors.blue));
    }
    if (widget.country.deaths != null) {
      _piedata.add(Stats('Total Deaths',
          _getValue(widget.country.deaths, widget.country.cases), Colors.red));
    }
    if (widget.country.recovered != null) {
      _piedata.add(Stats(
          'Total Recovered',
          _getValue(widget.country.recovered, widget.country.cases),
          Colors.orange));
    }
    if (widget.country.critical != null) {
      _piedata.add(Stats(
          'Total Critical',
          _getValue(widget.country.critical, widget.country.cases),
          Colors.yellow));
    }
    return _piedata;
  }

  _genrateData() {
    _seriesPieData.add(
      charts.Series(
        domainFn: (Stats task, _) => task.caseType,
        measureFn: (Stats task, _) => task.stateValue,
        colorFn: (Stats task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: _genrateDataPiedata(),
        labelAccessorFn: (Stats row, _) => '${row.stateValue}%',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Stats, String>>();
    _genrateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate:
                  MySliverAppBar(expandedHeight: 200, country: widget.country),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      Cases(
                        country: widget.country,
                        homescreen: false,
                      ),
                      Card(
                        color: Colors.grey[850],
                        child: Container(
                          height: 300.0,
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                      charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 2,
                                  cellPadding: new EdgeInsets.only(
                                      right: 4.0, bottom: 4.0, top: 8),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts.MaterialPalette.white,
                                      fontFamily: 'Georgia',
                                      fontSize: 11),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 80,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        outsideLabelStyleSpec:
                                            charts.TextStyleSpec(
                                                color: charts
                                                    .MaterialPalette.white,
                                                fontFamily: 'Georgia',
                                                fontSize: 11),
                                        labelPosition:
                                            charts.ArcLabelPosition.outside)
                                  ])),
                        ),
                      ),
                      Container(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => HistoryView(country: widget.country,)));
        },
        label: Text('History'),
        icon: Icon(Icons.history),
        backgroundColor: Colors.purple[800],
         
      )
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Country country;

  MySliverAppBar({@required this.expandedHeight, this.country});

  CachedNetworkImage cacheimg() { 
    return CachedNetworkImage(
        imageUrl: country.countryInfo.flag,
        imageBuilder: (context, imageProvider) => Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        //errorWidget: (context, url, error) => errorWidget,
      );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double flagHeight = 160;
    double flagWidth = 160;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              country.country,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: (MediaQuery.of(context).size.width/2) - (flagWidth / 2),
          //left: (MediaQuery.of(context).size.width + flagWidth / 2) / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                height: flagHeight,
                width: flagWidth,
                child: Hero(
                  tag: country.countryInfo.iId,
                  child: kIsWeb == true ?

       Container(
                    //margin: EdgeInsets.symmetric(vertical: 60.0),
                    width: 160.0,
                    height: 160.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                country.countryInfo.flag)
                        )
                    ))
     : cacheimg(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class Stats {
  String caseType;
  double stateValue;
  Color colorval;

  Stats(this.caseType, this.stateValue, this.colorval);
}
