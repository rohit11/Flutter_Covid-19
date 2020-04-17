import 'package:covid_19/dataModel/countriesDataModel.dart';
import 'package:covid_19/viewModel/historicalViewDataModel.dart';
import 'package:covid_19/widgets/linechart.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HistoryView extends StatefulWidget {
  final Country country;
  final HistoricalViewDataModel historicalViewDataModel =
      HistoricalViewDataModel();
  HistoryView({this.country});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'All',),
    Tab(text: 'Last 15 days'),
    Tab(text: 'Last 7 days')
  ];

   LineChart totalCases, totalDeath, totalRecovered;
   var tabIndex = 0; 
   @override
  void initState() {
    super.initState();  
  }

  CaseRecord getRecordType(String label){
    if(label.contains('last 7 days')){
        return  CaseRecord.last7days;
     } else if(label.contains('last 15 days')) {
        return  CaseRecord.last15days;
     } 
      return CaseRecord.all;
  }

  Widget getBody(String label) {

    /*if(totalCases == null) {
    totalCases = LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.cases,
                            title: 'Total Cases',
                          );
    }else {
      if(label.contains('Last 7 days')){
        totalCases.caseRecord = CaseRecord.all;
     } else if(label.contains('Last 15 days')) {
        totalCases.caseRecord = CaseRecord.last15days;
     } else {
               totalCases.caseRecord = CaseRecord.all;
     }
    }
    if(totalDeath == null){
      totalDeath= LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.deaths,
                            title: 'Total Deaths',
                          );
    }
    if(totalRecovered == null) {
      totalRecovered =  LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.recovered,
                            title: 'Total Recovered',
                          );
      }*/

    return SingleChildScrollView(
      child: Card(
        color: Colors.grey[850],
        child: Container(
          //width: 300,
          //height: 900,
          child:  Column(
                        children: <Widget>[
                          
                          LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.cases,
                            title: 'Total Cases',
                            caseRecord: getRecordType(label),
                          ),
                          LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.deaths,
                            title: 'Total Deaths',
                            caseRecord: getRecordType(label),
                          ),
                          LineChart(
                            historical: widget.historicalViewDataModel.historicalDataModel,
                            caseType: CaseType.recovered,
                            title: 'Total Recovered',
                            caseRecord: getRecordType(label),
                          ),
                        ],
                      ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
                length: myTabs.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text((widget.country.country)+' Cases History'),
                    bottom: TabBar(
                      tabs: myTabs,
                    ),
                  ),
                  body: ViewModelProvider<HistoricalViewDataModel>.withConsumer(
        viewModel: widget.historicalViewDataModel,
        onModelReady: (model) =>
            model.getCountryHistory(widget.country.country),
        builder: (context, model, child) => model.historicalDataModel == null
            ? Center(child: CircularProgressIndicator())
            :TabBarView(
                    children: myTabs.map((Tab tab) {
                        final String label = tab.text.toLowerCase();
                      return Center(
                        child: getBody(label),
                      );
                    }).toList(),
                  ),
                ),
              ));
    /*Scaffold(
      appBar: AppBar(title : Text((widget.country.country)+' Cases History')),
      body :SingleChildScrollView(
              child: Card(
                          color: Colors.grey[850],
                          child:
                              Container(
                                //width: 300,
                                //height: 900,
                                child: ViewModelProvider<HistoricalViewDataModel>.withConsumer(
                            viewModel: HistoricalViewDataModel(),
                            onModelReady: (model) => model.getCountryHistory(widget.country.country),
                            builder: (context, model, child) => model.historicalDataModel == null
                                      ? Center(child: CircularProgressIndicator())
                                      : Column(
                                        children: <Widget>[
                                          LineChart(historical: model.historicalDataModel,caseType: CaseType.cases,title: 'Total Cases',),
                                          LineChart(historical: model.historicalDataModel,caseType: CaseType.deaths,title: 'Total Deaths',),
                                          LineChart(historical: model.historicalDataModel,caseType: CaseType.recovered,title: 'Total Recovered',),
                                        ],
                                      ),
                                
                          ),
                              ),
                        ),
      ),
    );*/
  }
  }

