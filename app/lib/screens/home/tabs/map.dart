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

import '../../../helpers/router.dart';
import '../../../helpers/hotspots.dart';

class MapScreen extends StatefulWidget {
  const MapScreen() : super();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var routerHelper = RouterHelper();
  var hotspotsHelper = HotspotHelper();

  bool loaded = false;

  @override
  void initState() {
    super.initState();

    start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void start() async {
    var r = await hotspotsHelper.getHotspots();
    print(r);

    if (this.mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    if (!loaded) {
      widgets.add(Text(
        'Just a second...',
        style: Theme.of(context).textTheme.title,
      ));
      widgets.add(Text(
        'Fetching all the hotspots...',
        style: Theme.of(context).textTheme.subtitle,
      ));
      widgets.add(SizedBox(height: 40));
      widgets.add(new CircularProgressIndicator());
    } else {
      widgets.add(Text(
        'We\'re ready for you!',
        style: Theme.of(context).textTheme.title,
      ));
      widgets.add(
        FlatButton.icon(
          onPressed: () {
            routerHelper.router.navigateTo(context, '/map');
          },
          icon: Icon(Icons.map),
          label: new Text(
            'Launch Map',
            style: Theme.of(context).textTheme.title,
          ))
      );
    }

    return widgets;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding: Map Pane');

    return new Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildWidgets(),
        ),
      )
    );
  }
}