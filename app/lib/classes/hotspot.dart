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

class Hotspot {
  String _layerId;
  double _latitude;
  double _longitude;
  String _anonymousUserId;
  String _geohash;

  String get layerId => _layerId;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get anonymousUserId => _anonymousUserId;
  String get geohash => _geohash;

  set layerId(String layerId) {
    _layerId = layerId;
  }

  set latitude(double latitude) {
    _latitude = latitude;
  }

  set longitude(double longitude) {
    _longitude = longitude;
  }

  set anonymousUserId(String anonymousUserUd) {
    _anonymousUserId = anonymousUserUd;
  }

  set geohash(String geohash) {
    _geohash = geohash;
  }
}