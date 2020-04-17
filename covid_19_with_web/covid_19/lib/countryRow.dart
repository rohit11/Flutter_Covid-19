import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/countryDetailsView.dart';
import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class CountryRow extends StatefulWidget {
  final Country country;
  final VoidCallback onTapFavIcon;

  CountryRow({Key key, this.country, this.onTapFavIcon}) : super(key: key);

  @override
  _CountryRowState createState() => _CountryRowState();
}

class _CountryRowState extends State<CountryRow> {
  bool favState = false;

  @override
  void initState() {
    super.initState();
    _getFavStatus();
  }
 
  //Loading counter value on start
  _getFavStatus() async {
    var countryInfo = widget.country.countryInfo;
    bool result = await isFav(countryInfo.iId.toString());
    if (mounted) {
      setState(() {
        favState = result;
      });
    }
  }

  //Incrementing counter after click
  _updateFavStatus() async {
    await updateFavCountryStatus(widget.country.countryInfo.iId.toString());
    await _getFavStatus();
    if(widget.onTapFavIcon != null){
      widget.onTapFavIcon();
    }
  }

  CachedNetworkImage cacheimg() { 

    return CachedNetworkImage(
        imageUrl: widget.country.countryInfo.flag,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.symmetric(vertical: 60.0),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
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

  Widget planetThumbnail() {

    if(kIsWeb){

      return Container(
                    margin: EdgeInsets.symmetric(vertical: 60.0),
                    width: 90.0,
                    height: 90.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                widget.country.countryInfo.flag)
                        )
                    ));
    }
  return cacheimg() ; /*Hero(
        tag: widget.country.countryInfo.iId,
        child:cacheimg());*/
  }

  Widget planetCard(BuildContext context) {
    return Container(
      child: planetCardContent(context),
      height: 240,
      margin: EdgeInsets.only(left: 40.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget planetCardContent(BuildContext context) {
    _getFavStatus();
    return Container(
      margin: EdgeInsets.fromLTRB(60.0, 1.0, 1.0, 1.0),
      //constraints: BoxConstraints.expand(),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 16, top: 0),
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: favState == true ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    _updateFavStatus();
                  },
                )
              ],
            ),
          ),
          Text(widget.country.country,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Text(
              'Total cases: ' +
                  getFormattedString(widget.country.cases.toString()),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              )),
          Container(height: 16.0),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              gridContent(CaseType.totalCases),
              Container(width: 10.0),
              gridContent(CaseType.totalDeath),
            ],
          ),
          Container(height: 10.0),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              gridContent(CaseType.totalCritical),
              Container(width: 19.0),
              gridContent(CaseType.totalRecoved),
            ],
          )
        ],
      ),
    );
  }

  String cardTitle(CaseType cardType) {
    switch (cardType) {
      case CaseType.totalCases:
        return "Today's Count";
      case CaseType.totalDeath:
        return "Total Death";
      case CaseType.totalCritical:
        return "Total Critical";
      case CaseType.totalRecoved:
        return "Total Recovered";
      default:
        return '';
    }
  }

  String totalCount(CaseType cardType) {
    switch (cardType) {
      case CaseType.totalCases:
        return getFormattedString(widget.country.todayCases.toString());
      case CaseType.totalDeath:
        return getFormattedString(widget.country.deaths.toString());
      case CaseType.totalCritical:
        return getFormattedString(widget.country.critical.toString());
      case CaseType.totalRecoved:
        return getFormattedString(widget.country.recovered.toString());
      default:
        return '';
    }
  }

  Color getColor(CaseType cardType) {
    switch (cardType) {
      case CaseType.totalCases:
        return Colors.blue;
      case CaseType.totalDeath:
        return Colors.red;
      case CaseType.totalCritical:
        return Colors.yellow;
      case CaseType.totalRecoved:
        return Colors.orange;
      default:
        return Colors.white;
    }
  }

  Widget gridContent(CaseType cardType) => Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: getColor(cardType),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            margin: EdgeInsets.only(right: 8),
            height: 40.0,
            width: 8.0,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cardTitle(cardType),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(totalCount(cardType),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 1.0,
      ),
      child: GestureDetector(
              onTap: () {
                Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CountryDetailsView(country: widget.country,)));
              },
              child: Container(
          child: Stack(
            children: <Widget>[
              planetCard(context),
              planetThumbnail(),
            ],
          ),
        ),
      ),
    );
  }
}
