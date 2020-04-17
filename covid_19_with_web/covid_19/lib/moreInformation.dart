import 'package:flutter/material.dart';
import 'constant.dart';
import 'cardListTile.dart';
import 'package:covid_19/constant.dart';

class MoreInformation extends StatelessWidget {
   final String title;
   final MoreInformationOption moreInformationOption;
   MoreInformation({this.title,this.moreInformationOption});
 
 
  List<Widget> getWidgetList(MoreInformationOption moreInformationOption) {

   var widgets = new List<Widget>();


  switch(moreInformationOption) { 
   case MoreInformationOption.about: { 
            widgets.add(CardListTile(aboutDataModel: aboutCovid19));
            widgets.add(CardListTile(aboutDataModel: covid19Symptom));
            widgets.add(CardListTile(aboutDataModel: covid19HighRisk));
            widgets.add(CardListTile(aboutDataModel: covid19Doctor));
   } 
   break; 
  
   case MoreInformationOption.whatYouanDo : { 
            widgets.add(CardListTile(aboutDataModel: washingYourHands));
            widgets.add(CardListTile(aboutDataModel: isolateYourselfFromOthers));
            widgets.add(CardListTile(aboutDataModel: socialDistancing));
            widgets.add(CardListTile(aboutDataModel: symptomMonitoring));
            widgets.add(CardListTile(aboutDataModel: cleaningAndDisinfectingSurfaces));

   } 
   break; 

   case MoreInformationOption.preventAndManagment : { 
            widgets.add(CardListTile(aboutDataModel: washingYourHands));
            widgets.add(CardListTile(aboutDataModel: isolateYourselfFromOthers));
            widgets.add(CardListTile(aboutDataModel: socialDistancing));
            widgets.add(CardListTile(aboutDataModel: symptomMonitoring));
            widgets.add(CardListTile(aboutDataModel: cleaningAndDisinfectingSurfaces));
   } 
   break;   
   default: { 
        
   }
   break; 
} 

   return widgets;

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
          padding: EdgeInsets.all(16.0),
          children: getWidgetList(moreInformationOption),
        ),
    );
  }
}
