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

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../helpers/user.dart';
import '../../helpers/router.dart';

import '../../classes/home.dart';

import '../home/tabs/information.dart';
import '../home/tabs/data-browser.dart';
import '../home/tabs/map.dart';

class HomeScreen extends StatefulWidget {
  Map<String, dynamic> routeData;

  HomeScreen({this.routeData}) : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var userHelper = UserHelper();
  var routerHelper = RouterHelper();

  bool online = false;
  bool reportOpacity = true;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Home homeClass;

  InformationScreen informationScreen = new InformationScreen();
  MapScreen mapScreen = new MapScreen();
  DataBrowserScreen dataBrowserScreen = new DataBrowserScreen();

  @override
  void initState() {
    super.initState();

    homeClass = Provider.of<Home>(context, listen: false);

    start();
    setupGeolocation();
  }

  void start() async {
    await userHelper.signInAnonymously();
    await userHelper.getFcmTokenId();

    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/presences';
    await http.post(url, body: {
      'uid': userHelper.firebaseUser.uid,
      'fcmToken': userHelper.fcmToken
    });

    homeClass.online = true;

    setState(() {
      online = true;
    });

    Timer.periodic(Duration(milliseconds: 1000), (Timer r) {
      setState(() {
        reportOpacity = false;
      });
    });

    Timer.periodic(Duration(milliseconds: 2000), (Timer r) {
      setState(() {
        reportOpacity = true;
      });
    });
  }

  void setupGeolocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print('Service not enabled - requesting service...');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location service not enabled.');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      print('Location permission denied - requesting...');
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print('Location OK!');
        return;
      } else {
        print('Location permission denied.');
      }
    }

    _locationData = await location.getLocation();
    userHelper.lastKnownLocation = _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: AnimatedOpacity(
          opacity: reportOpacity ? 0.25 : 1,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: new FloatingActionButton(
            elevation: 0,
            isExtended: true,
            tooltip: "Report a symptom",
            child: new Icon(Icons.my_location),
            onPressed: () {
              routerHelper.router.navigateTo(context, '/report');
            }
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.data_usage)),
              Tab(icon: Icon(Icons.map)),
            ],
          ),
          title: Text(
            'Ground Truth',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: TabBarView(
          children: [
            informationScreen,
            dataBrowserScreen,
            mapScreen,
          ],
        ),
      ),
    );
  }
}