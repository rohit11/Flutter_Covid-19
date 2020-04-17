import 'package:bezier_chart/bezier_chart.dart';
import 'package:covid_19/dataModel/historicalDataModel.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

enum  CaseType {
  cases,
  deaths,
  recovered
}
enum  CaseRecord {
  all,
  last15days,
  last7days,
}

class LineChart extends StatefulWidget {
  final Historical historical;
  final CaseType caseType;
  final String title;
  final CaseRecord caseRecord;
  LineChart({this.historical, this.caseType = CaseType.cases, this.title, this.caseRecord = CaseRecord.all});

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {


  @override
  void initState() {
    super.initState();  
  }

  getCaseType(Timeline timeline) {

    switch (widget.caseType) {
      case CaseType.cases:
        return timeline.cases;
        break;
        case CaseType.deaths:
        return timeline.deaths;
        break;
        case CaseType.recovered:
        return timeline.recovered;
        break;
      default:
    }
  }

   _getColor() {

    switch (widget.caseType) {
      case CaseType.cases:
        return Colors.blue;
        break;
        case CaseType.deaths:
        return Colors.red;
        break;
        case CaseType.recovered:
        return Colors.orange;
        break;
      default:
    }
  }

  filteredCases(Map<String, dynamic> cases){
    
    List<String> fiteredDateKeys = cases.keys.toList();

    switch (widget.caseRecord) {
      case CaseRecord.all:
        fiteredDateKeys = cases.keys.toList();
        break;
        case CaseRecord.last15days:
        fiteredDateKeys = cases.keys.toList();
        return  fiteredDateKeys.getRange(fiteredDateKeys.length - 15,fiteredDateKeys.length);
        break;
        case CaseRecord.last7days:
        fiteredDateKeys = cases.keys.toList();
        return fiteredDateKeys.getRange(fiteredDateKeys.length - 7,fiteredDateKeys.length);
        break;
      default:
              fiteredDateKeys = cases.keys.toList();
      break;
    }
     return fiteredDateKeys;
  }

  DateTime firstDate() {
      final timeLine = widget.historical.timeline;
      final cases = getCaseType(timeLine);
      final dateKeys = filteredCases(cases);
      final splitDate = dateKeys.first.split('/');
      DateTime firstDate = DateTime(int.parse(splitDate[2]) + 2000,int.parse(splitDate[0]),int.parse(splitDate[1]));
      return firstDate;
  }

  DateTime lastDate() {
      final timeLine = widget.historical.timeline;
      final cases = getCaseType(timeLine);
      final dateKeys = filteredCases(cases);
      final splitDate = dateKeys.last.split('/');
      DateTime lastDate = DateTime(int.parse(splitDate[2]) + 2000,int.parse(splitDate[0]),int.parse(splitDate[1]));
      return lastDate;
  }


  List<DataPoint<DateTime>>  getData() {
    List<DataPoint<DateTime>> data = List<DataPoint<DateTime>> ();

    
    final timeLine = widget.historical.timeline;
      final cases = getCaseType(timeLine);
      final dateKeys = filteredCases(cases);

      for ( var date in dateKeys) {
         final value = cases[date];
         final splitDate = date.split('/');
         DateTime formattedDate = DateTime(int.parse(splitDate[2]) + 2000,int.parse(splitDate[0]),int.parse(splitDate[1]));
         double valueInDouble = value.toDouble();
        data.add(DataPoint<DateTime>(value: valueInDouble, xAxis: formattedDate));
      }
    
      return data;

  }

  Widget lineChartView(BuildContext context) {
  final fromDate =  firstDate(); 
  final toDate = lastDate();
  return Center(
    child: Container(
      //color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: toDate,
        onIndicatorVisible: (val) {
          print("Indicator Visible :$val");
        },
        onDateTimeSelected: (datetime) {
          print("selected datetime: $datetime");
        },
        selectedDate: toDate,
        //this is optional
        footerDateTimeBuilder: (DateTime value, BezierChartScale scaleType) {
          final newFormat = intl.DateFormat('MM/dd');
          return newFormat.format(value);
        },
        series: [
          BezierLine(
            label: "Cases",
            lineColor: _getColor(),
            data : getData()
          ),
        ],
        config: BezierChartConfig(
          displayDataPointWhenNoValue: false,
          verticalIndicatorStrokeWidth: 3.0,
          pinchZoom: false,
          physics: ClampingScrollPhysics(),
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Card( color: Colors.grey[900], child: Column(
      children: <Widget>[
        Container(padding: EdgeInsets.only(top:16), child: Text(widget.title, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20 ))),
        lineChartView(context),
      ],
    ));
  }

  void setFilteredType(CaseRecord recordType){
    setState(() {
      //widget.caseRecord = recordType;
    });
  }
}