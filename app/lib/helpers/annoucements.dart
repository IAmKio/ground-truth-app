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

class AnnouncementsHelper {
  static final AnnouncementsHelper _singleton = new AnnouncementsHelper._internal();

  Map<String, dynamic> announcements;
  bool loaded = false;
  
  factory AnnouncementsHelper() {
    return _singleton;
  }

  Future<dynamic> fetchAnnouncements() async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/announcements';
    var response = await http.get(url);
    print(response.statusCode);

    announcements = jsonDecode(response.body);
    loaded = true;

    return Future.value(announcements);
  }

  AnnouncementsHelper._internal();
}