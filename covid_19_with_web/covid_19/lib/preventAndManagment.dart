import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';


class PreventAndManagment extends StatefulWidget {
  @override
  _PreventAndManagment createState() => new _PreventAndManagment();
}

class _PreventAndManagment extends State<PreventAndManagment> {
  String pathPDF = "";
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        _loading = false;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "https://www.mohfw.gov.in/pdf/PreventionandManagementofCOVID19FLWEnglish.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return  _loading ? Center(child:  CircularProgressIndicator(),) : PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Prevent And Managment"),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.share),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        path: pathPDF);
  }
}
