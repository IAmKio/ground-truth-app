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

import 'dart:convert';

import 'package:http/http.dart' as http;

class LayersHelper {
  static final LayersHelper _singleton = new LayersHelper._internal();

  Map<String, dynamic> layers;
  
  factory LayersHelper() {
    return _singleton;
  }

  Future<dynamic> fetchLayers() async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/layers';
    var response = await http.get(url);
    print(response.statusCode);

    layers = jsonDecode(response.body);

    return Future.value(layers);
  }

  Map<String, dynamic> getLayerById(String layerId) {
    List<dynamic> innerLayers = layers['layers'];
    return innerLayers.firstWhere((l) => (l['layerId'] == layerId));
  }

  LayersHelper._internal();
}