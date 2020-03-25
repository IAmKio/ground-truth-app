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

class Report with ChangeNotifier {
  String _workingLayerId;
  double _workingLat;
  double _workingLong;

  double get workingLat => _workingLat;
  double get workingLong => _workingLong;
  String get workingLayerId => _workingLayerId;

  set workingLat(double v) {
    _workingLat = v;
    notifyListeners();
  }

  set workingLong(double v) {
    _workingLong = v;
    notifyListeners();
  }

  set workingLayerId(String v) {
    _workingLayerId = v;
    notifyListeners();
  }
}