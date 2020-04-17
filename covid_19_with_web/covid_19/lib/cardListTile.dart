import 'package:covid_19/MoreInformationDetails.dart';
import 'package:covid_19/moreInformationDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final MoreInformationDataModel aboutDataModel;
  CardListTile({Key key, this.aboutDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: aboutDataModel.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Hero(
                  tag: aboutDataModel.id,
                  child: Image.asset(aboutDataModel.imageName),
                ),
                title: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(aboutDataModel.title,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline4.color,
                            fontWeight: FontWeight.bold, fontSize: 20))),
                subtitle: Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(aboutDataModel.subTitle,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.headline4.color))),
              ),
            ),
            Divider(
               color:Theme.of(context).textTheme.headline4.color,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16, top: 0),
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                child:
                    Text('Learn More', style: TextStyle(color:Theme.of(context).textTheme.headline4.color)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MoreInformationDetails(
                        aboutDataModel: aboutDataModel);
                  }));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
