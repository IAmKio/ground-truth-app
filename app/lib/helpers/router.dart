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

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
import '../screens/report/report.dart';
import '../screens/report/geolocate.dart';
import '../screens/map/mapBrowser.dart';

class RouterHelper {
  static final RouterHelper _singleton = new RouterHelper._internal();
  final router = Router();
  bool initialised = false;

  var homeScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomeScreen(routeData: params);
  });

  var reportScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ReportScreen(routeData: params);
  });

  var reportGeolocateScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ReportGeolocateScreen(routeData: params);
  });

  var mapBrowserScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MapBrowserScreen(routeData: params);
  });

  factory RouterHelper() {
    print('Helpers: Router');

    return _singleton;
  }

  RouterHelper._internal();
   init() {
    print('Helpers: Router - initialising...');

    if (initialised != true) {
      router.define(
        '/home',
        handler: homeScreenHandler,
        transitionType: TransitionType.native
      );

      router.define(
        '/report',
        handler: reportScreenHandler,
        transitionType: TransitionType.native
      );

      router.define(
        '/report-geolocation/:layerId',
        handler: reportGeolocateScreenHandler,
        transitionType: TransitionType.native
      );

      router.define(
        '/map',
        handler: mapBrowserScreenHandler,
        transitionType: TransitionType.native
      );

      print('Helpers: Router - Finished initialised routing.');  
      initialised = true;
    } else {
      print('Helpers: Router - already initalised.');
    }
  }
}