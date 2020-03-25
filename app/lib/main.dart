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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './classes/home.dart';

import './screens/home/home.dart';
import './helpers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var routerHelper = RouterHelper();
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    routerHelper.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ground Truth',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
        cardTheme: CardTheme(
          margin: EdgeInsets.only(bottom: 20)
        ),
        primarySwatch: Colors.yellow,
        
      ),
      home: ChangeNotifierProvider(
        create: (_) => new Home(),
        child: HomeScreen(routeData: {}),
      )
    );
  }
}
