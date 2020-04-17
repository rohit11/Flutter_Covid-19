import 'package:covid_19/countryRow.dart';
import 'package:covid_19/viewModel/countryDataViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CountryView extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() {
    return _CountryViewState();
  }

}
class _CountryViewState extends State<CountryView> {
  bool _isFavSelected = false;

  Widget handleResponse(CountryDataViewModel countryDataViewModel){

    if(countryDataViewModel.errorMessage != null){

      Fluttertoast.showToast(
        msg: countryDataViewModel.errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
          return Container();
    } else if(countryDataViewModel.countryDataModel == null ) {
        return Center(child: CircularProgressIndicator());
    } else {
       return Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          onChanged: (text) => {countryDataViewModel.filterCountries(text)},
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: 'Search for Country',
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.grey[800]),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.5),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: countryDataViewModel.countryDataModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CountryRow(
                                country: countryDataViewModel.countryDataModel[index], onTapFavIcon: () => _isFavSelected == true ? countryDataViewModel.getFavList() : countryDataViewModel.resetList(),
                              );
                            }),
                      ),
                    ],
                  );
    }
  }
  
  @override
  Widget build(BuildContext context) {

    Widget _offsetPopup(CountryDataViewModel countryViewDataModel) => PopupMenuButton<int>(
          onSelected: (value) {
            switch (value) {
              case 1:
                countryViewDataModel.filterCasesHighToLow(true);
                break;
              case 2:
                countryViewDataModel.filterCasesHighToLow(false);
                break;
              case 3:
                countryViewDataModel.filterDeathHighToLow(false);
                break;
              case 4:
                countryViewDataModel.filterDeathHighToLow(true);
                break;
              default:
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                "Cases: high to low",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "Cases: low to high",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(
                "Deaths: low to high",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuItem(
              value: 4,
              child: Text(
                "Deaths: High to low",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ],
          icon: Icon(Icons.filter_list),
          offset: Offset(0, 100),
        );

    return ViewModelProvider<CountryDataViewModel>.withConsumer(
            viewModel: CountryDataViewModel(),
            onModelReady: (model) => model.getCountryData(),
            builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Country Details"),
          actions: <Widget>[
            IconButton(icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ), onPressed: () { 
                _isFavSelected == false ? model.getFavList() : model.resetList();
                setState(() {
                  _isFavSelected = !_isFavSelected;
                });
              }),
            _offsetPopup(model)
          ],
        ),
        body: SafeArea(
          child:  /*model.countryDataModel == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          onChanged: (text) => {model.filterCountries(text)},
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: 'Search for Country',
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.grey[800]),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.5),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: model.countryDataModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CountryRow(
                                country: model.countryDataModel[index], onTapFavIcon: () => _isFavSelected == true ? model.getFavList() : model.resetList(),
                              );
                            }),
                      ),
                    ],
                  ),*/
                  handleResponse(model)
          ),
        ));
  }
}
