import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 10;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);
