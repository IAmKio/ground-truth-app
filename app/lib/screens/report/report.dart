// Copyright 2020 Kieran Goodary, Digital Industria Ltd
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import '../../helpers/router.dart';
import '../../helpers/layers.dart';

class ReportScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  ReportScreen({this.routeData}) : super();

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var routerHelper = RouterHelper();
  var layersHelper = LayersHelper();
  bool loaded = false;
  Map<String, dynamic> layers = {
    'layers': []
  };

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    print('Report Screen starting...');

    // var url = 'https://us-central1-wearequarantined.cloudfunctions.net/layers';
    // var response = await http.get(url);
    // layers = jsonDecode(response.body);
    layers = await layersHelper.fetchLayers();
    print('Layers $layers');

    setState(() {
      loaded = true;
    });
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    if (loaded == true) {
      List<dynamic> innerLayers = layers['layers'];
      print(innerLayers);

      if (innerLayers.length > 0) {
        innerLayers.forEach((layer) {
          widgets.add(Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add_location, size: 50),
                  title: Text(
                    '${layer['friendlyName']} (${layer['technicalName']})',
                    style: Theme.of(context).textTheme.title
                  ),
                  subtitle: Text(layer['shortDescription']),
                  onTap: () {
                    routerHelper.router.navigateTo(context, '/report-geolocation/${layer['layerId']}');
                  },
                ),
              ],
            ),
          ));
        });
      }
    } else {
      widgets.add(new LinearProgressIndicator());
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: buildActions(),
        elevation: 0,
        title: new Text(
          'Report',
        ),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildWidgets(),
          )
        )
      ),
    );
  }
}