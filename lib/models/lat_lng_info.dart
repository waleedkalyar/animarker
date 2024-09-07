import 'package:flutter/foundation.dart';
import 'package:flutter_animarker/core/i_lat_lng.dart';
import 'package:flutter_animarker/helpers/spherical_util.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

final MarkerId defaultId = MarkerId('');

class LatLngInfo implements ILatLng {
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final MarkerId markerId;
  @override
  final double bearing;
  @override
  final bool isStopover;
  @override
  final bool ripple;
  @override
  final bool isEmpty;
  @override
  final double mapScale;
  @override
  final Map<String, dynamic> markerJson;
  @override
  bool get isNotEmpty => !isEmpty;

  const LatLngInfo(
    this.latitude,
    this.longitude,
    this.markerId, {
    this.bearing = 0,
    this.isStopover = false,
    this.ripple = false,
    this.mapScale = 0.5,
    this.markerJson = const {},
  }) : isEmpty = false;

  LatLngInfo.marker(
    Marker marker, {
    this.bearing = 0,
    this.isStopover = false,
    this.ripple = false,
    this.mapScale = 0.5,
  })  : isEmpty = false,
        latitude = marker.position.latitude,
        longitude = marker.position.longitude,
        markerId = marker.markerId,
        markerJson = marker.toJson() as Map<String, Object>;

  const LatLngInfo.point(
    this.latitude,
    this.longitude, {
    this.bearing = 0,
    this.isStopover = false,
    this.ripple = false,
    this.mapScale = 0.5,
    this.markerJson = const {},
  })  : isEmpty = false,
        markerId = const MarkerId('');

  LatLngInfo.position(
    LatLng latLng,
    this.markerId, {
    this.bearing = 0,
    this.isStopover = false,
    this.ripple = false,
    this.mapScale = 0.5,
    this.markerJson = const {},
  })  : isEmpty = false,
        latitude = latLng.latitude,
        longitude = latLng.longitude;

  const LatLngInfo.empty()
      : bearing = 0,
        isStopover = false,
        latitude = 0,
        longitude = 0,
        markerId = const MarkerId(''),
        ripple = false,
        mapScale = 0.5,
        isEmpty = true,
        markerJson = const {};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatLngInfo &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          markerId == other.markerId &&
          bearing == other.bearing &&
          isStopover == other.isStopover &&
          ripple == other.ripple &&
          isEmpty == other.isEmpty &&
          mapScale == other.mapScale;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      markerId.hashCode ^
      bearing.hashCode ^
      isStopover.hashCode ^
      ripple.hashCode ^
      isEmpty.hashCode ^
      mapScale.hashCode;

  @override
  String toString() {
    return 'LatLngInfo{latitude: $latitude, longitude: $longitude, markerId: $markerId, bearing: $bearing, isStopover: $isStopover, ripple: $ripple, isEmpty: $isEmpty, mapScale: $mapScale}';
  }

  @override
  LatLngInfo copyWith({
    double? latitude,
    double? longitude,
    double? bearing,
    MarkerId? markerId,
    bool? isStopover,
    bool? ripple,
    bool? isEmpty,
    double? mapScale,
    Map<String, dynamic>? markerJson,
  }) {
    if ((latitude == null || identical(latitude, this.latitude)) &&
        (longitude == null || identical(longitude, this.longitude)) &&
        (bearing == null || identical(bearing, this.bearing)) &&
        (markerId == null || identical(markerId, this.markerId)) &&
        (isStopover == null || identical(isStopover, this.isStopover)) &&
        (ripple == null || identical(ripple, this.ripple)) &&
        (isEmpty == null || identical(isEmpty, this.isEmpty)) &&
        (mapScale == null || identical(mapScale, this.mapScale)) &&
        (markerJson == null ||
            identical(markerJson, this.markerJson) ||
            mapEquals(markerJson, this.markerJson))) {
      return this;
    }

    return LatLngInfo(
      latitude ?? this.latitude,
      longitude ?? this.longitude,
      markerId ?? this.markerId,
      bearing: bearing ?? this.bearing,
      isStopover: isStopover ?? this.isStopover,
      ripple: ripple ?? this.ripple,
      mapScale: mapScale ?? this.mapScale,
      markerJson: markerJson ?? this.markerJson,
    );
  }

  @override
  double operator -(ILatLng other) =>
      SphericalUtil.computeHeading(other, this).toDouble();
}
