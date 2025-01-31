import 'dart:async';
import 'package:MAP/Constants.dart';
import 'package:MAP/Services/NewGameServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final String roomId;
  @override
  State<StatefulWidget> createState() => MapPageState();
  MapPage({Key key, @required this.roomId}) : super(key: key);
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  final db = FirebaseFirestore.instance;
  StreamSubscription sub;
  Map data;
  bool loading = false;
// for my drawn routes on the map

  // to daraw a circle on a map with specific id
  Set<Circle> _circles = Set<Circle>();

  // to set up markers on the screen
  Set<Marker> _markers = Set<Marker>();
  int _markerIdCounter = 0;

// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor activityIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;

  @override
  void initState() {
    super.initState();
    // create an instance of Location
    location = new Location();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });

    sub = db.collection('games').doc(widget.roomId).snapshots().listen((snap) {
      setState(() {
        data = snap.data();
        _circles.add(Circle(
            circleId: CircleId("circle"),
            center: LatLng(data['center'].latitude, data['center'].longitude),
            radius: 100,
            fillColor: Colors.redAccent.withOpacity(0.5),
            strokeWidth: 3,
            strokeColor: Colors.redAccent));
        getAllMarkers(data['activity']);
        loading = true;
      });
    });
    // set custom marker pins
    localIcons();
    // set the initial location
    setInitialLocation();
    // TODO :Load Firebase
  }

  getAllMarkers(List points) {
    for (int i = 0; i < points.length; i++) {
      _setMarkers(points[i]);
    }
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  void _setMarkers(GeoPoint point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: LatLng(point.latitude, point.longitude),
        ),
      );
    });
  }

  // void showPinsOnMap() {
  //   // get a LatLng for the source location
  //   // from the LocationData currentLocation object
  //   var pinPosition =
  //       LatLng(currentLocation.latitude, currentLocation.longitude);
  //   // get a LatLng out of the LocationData object
  //   // add the initial source location pin
  //   _markers.add(Marker(
  //       markerId: MarkerId('sourcePin'),
  //       position: pinPosition,
  //       icon: sourceIcon));
  //   // destination pin
  //   // set the route lines on the map from source to destination
  //   //setPolylines();
  // }

  void localIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/driving_pin.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          // tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
        body: loading
            ? Center(
                child: Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: false,
                          tiltGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          markers: _markers,
                          circles: _circles,
                          mapType: MapType.normal,
                          initialCameraPosition: initialCameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            // my map has completed being created;
                            // i'm ready to show the pins on the map
                          }),
                    ],
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        floatingActionButton: Constants.prefs.getString("userId") ==
                data['imposter']
            ? FloatingActionButton(
                // isExtended: true,
                child: Text(
                  "Kill",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                onPressed: () async {
                  await catchPlayer(
                      GeoPoint(
                          currentLocation.latitude, currentLocation.longitude),
                      GeoPoint(
                          currentLocation.latitude, currentLocation.longitude));
                },
              )
            : null);
  }
}
