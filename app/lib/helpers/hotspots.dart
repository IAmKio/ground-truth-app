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

class HotspotHelper {
  static final HotspotHelper _singleton = new HotspotHelper._internal();

  Map<String, dynamic> latestHotspotReference;
  Map<String, dynamic> latestHotspots;
  
  factory HotspotHelper() {
    return _singleton;
  }

  Future<dynamic> pushHotspot({String anonymousUserId, String layerId, double latitude, double longitude}) async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/ingest';
    var response = await http.post(
      url,
      body: {
        'anonymousUserId': anonymousUserId,
        'layerId': layerId,
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      }
    );

    print(response.statusCode);

    latestHotspotReference = jsonDecode(response.body);

    return Future.value(latestHotspotReference);
  }

  Future<dynamic> getHotspots({String anonymousUserId, String layerId, double latitude, double longitude}) async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/hotspots';
    var response = await http.get(url);

    print(response.statusCode);

    latestHotspots = jsonDecode(response.body);
    return Future.value(latestHotspots);
  }

  HotspotHelper._internal();
}