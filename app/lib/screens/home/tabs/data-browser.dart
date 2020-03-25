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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/router.dart';
import '../../../helpers/statistics.dart';

class DataBrowserScreen extends StatefulWidget {
  const DataBrowserScreen() : super();

  @override
  _DataBrowserScreenState createState() => _DataBrowserScreenState();
}

class _DataBrowserScreenState extends State<DataBrowserScreen> with TickerProviderStateMixin {
  var routerHelper = RouterHelper();
  var statisticsHelper = StatisticsHelper();

  bool loaded = false;
  bool showStatsCards = false;
  bool showMoreComingCard = false;

  _launchURL(urlToLaunch) async {
    if (await canLaunch(urlToLaunch)) {
      await launch(urlToLaunch);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.only(top: 24, left: 24, right: 24),
            title: Text('Sorry...'),
            children: <Widget>[
              new Text('We tried to open this link but encountered issues.'),
              new Text('Here is the link we tried to open. You can copy this link.'),
              new TextFormField(
                initialValue: urlToLaunch
              ),
              new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ]
              )
            ],
          );
        }
      );
    }
  }

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    await statisticsHelper.fetchStatistics();

    new Timer(Duration(seconds: 2), () {
      setState(() {
        showMoreComingCard = true;
      });
    });

    if (this.mounted) {
      setState(() {
        loaded = true;
        showStatsCards = true;
      });
    }
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    if (loaded) {
      List<dynamic> stats = statisticsHelper.statistics['statistics'];

      stats.forEach((stat) {
        widgets.add(
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            vsync: this,
            curve: Curves.fastOutSlowIn,
            child: Container(
              height: showStatsCards ? null : 0,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        '${stat['name']}: ${stat['count']}' ,
                        style: Theme.of(context).textTheme.title
                      ),
                      subtitle: Text(stat['description']),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      });

      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showMoreComingCard ? null : 0,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: new Icon(Icons.timeline, size: 50),
                    title: Text(
                      'More statistics are coming' ,
                      style: Theme.of(context).textTheme.title
                    ),
                    subtitle: Text('We\'re working on it, but this app works best when everyone is working together to report infections. Tap here to share this app.'),
                    onTap: () {
                      _launchURL('https://onelink.to/efu96g');
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      );
    } else {
      widgets.add(AnimatedSize(
        duration: Duration(milliseconds: 500),
        vsync: this,
        curve: Curves.fastOutSlowIn,
        child: Container(
              height: showStatsCards ? 0 : null,
              child: LinearProgressIndicator()
        )
      ));
    }

    return widgets;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding: Data Browser Pane');

    return new Container(
      child: new SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildWidgets(),
        )
      )
    );
  }
}