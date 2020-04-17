import 'package:covid_19/constant.dart';
import 'package:covid_19/countryView.dart';
import 'package:covid_19/locator.dart';
import 'package:covid_19/moreInformation.dart';
import 'package:covid_19/preventAndManagment.dart';
import 'package:covid_19/viewModel/worldDataViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'homeView.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
         debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColorDark: Colors.black,
            primaryColor: Colors.grey[900],
            accentColor: Colors.green,
            scaffoldBackgroundColor: Colors.black,
            textTheme: TextTheme(
                body1: TextStyle(color: Colors.white),
                title: TextStyle(color: Colors.white),
                subhead: TextStyle(color: Colors.white),
                subtitle: TextStyle(color: Colors.white),
                caption: TextStyle(color: Colors.white),
                display1: TextStyle(color: Colors.black),
                display2: TextStyle(color: Colors.white),
                display3: TextStyle(color: Colors.white),
                display4: TextStyle(color: Colors.white),
                body2: TextStyle(color: Colors.white),
                headline: TextStyle(color: Colors.white),
                overline: TextStyle(color: Colors.white)),
            primaryTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
            accentTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
        home: MyHomePage(title: "COVID-19"));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final WorldDataViewModel worldDataViewModel = null; 
  MyHomePage({Key key, this.title}) : super(key: key);


  Widget handleResponse(WorldDataViewModel worldDataViewModel){

    if(worldDataViewModel.errorMessage != null){

      Fluttertoast.showToast(
        msg: worldDataViewModel.errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
          return Container();
    } else if(worldDataViewModel.wordDataModel == null ) {
        return Center(child: CircularProgressIndicator());
    } else {
       return HomeView(wordDataModel: worldDataViewModel.wordDataModel,);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
      actions: <Widget>[
            // action button
            IconButton(
              icon: Image.asset('assets/img/totalCountries.png'),
              onPressed: () {
                Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CountryView(), fullscreenDialog: true));
              },
            ),
             ],
      ),
     
      drawer: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.grey[900],
          accentColor: Colors.green,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          canvasColor: Colors.grey[900],
        ),
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/img/myself.jpg'),
                      radius: 50.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Rohit Nisal',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(0, .3),
                    child: Text(
                      'Mobile App Architect',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(0, .8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('rohitnisal@gmail.com', style: TextStyle(color: Colors.white),),
                      ) ,
                      ),
                  ),
                ],
              ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('About COVID-19',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MoreInformation(
                              title: 'About COVID-19',
                              moreInformationOption:
                                  MoreInformationOption.about)));
                },
              ),
              ListTile(
                title: Text('What you can do',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MoreInformation(
                              title: 'What you can do',
                              moreInformationOption:
                                  MoreInformationOption.whatYouanDo)));
                },
              ),
              ListTile(
                title: Text('Prevent and Management',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => PreventAndManagment()));
                },
              ),
              ListTile(
                title: Text('Credit',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        
      ),
      body: SafeArea(
        child: ViewModelProvider<WorldDataViewModel>.withConsumer(
          viewModel: WorldDataViewModel(),
          onModelReady: (model) => model.getWordData(),
          builder: (context, model, child) =>
               
              RefreshIndicator(
                onRefresh: () => model.getWordData() ,
                              child: SingleChildScrollView(child: handleResponse(model)
                ),
              ),
        ),
      ),
    );
  }
}
