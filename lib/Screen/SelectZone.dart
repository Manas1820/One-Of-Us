import 'package:MAP/Screen/WaitingRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../Constants.dart';

class SelectZone extends StatefulWidget {
  final String roomId;
  @override
  State<StatefulWidget> createState() => SelectZoneState();
  SelectZone({Key key, @required this.roomId}) : super(key: key);
}

class SelectZoneState extends State<SelectZone> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves

  Set<Circle> _circles = Set<Circle>();

  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });

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
    // set the initial location
    setInitialLocation();
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    // add the initial source location pin
    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
    ));
    // set the route lines on the map from source to destination
    //setPolylines();
  }

  // void setPolylines() async {
  //   List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPIKey,
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       destinationLocation.latitude,
  //       destinationLocation.longitude);
  //   if (result.isNotEmpty) {
  //     result.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //     setState(() {
  //       _polylines.add(Polyline(
  //           width: 5, // set the width of the polylines
  //           polylineId: PolylineId('poly'),
  //           color: Color.fromARGB(255, 40, 122, 198),
  //           points: polylineCoordinates));
  //     });
  //   }
  // }
  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
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
      _circles.removeWhere((m) => m.circleId.value == 'circle');
      _circles.add(Circle(
          circleId: CircleId("circle"),
          center: pinPosition,
          radius: 100,
          fillColor: Colors.redAccent.withOpacity(0.5),
          strokeWidth: 3,
          strokeColor: Colors.redAccent));
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
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
                myLocationEnabled: false,
                compassEnabled: false,
                zoomControlsEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                circles: _circles,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  // my map has completed being created;
                  // i'm ready to show the pins on the map
                  showPinsOnMap();
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.location_on),
        backgroundColor: Colors.green,
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('games')
              .doc(widget.roomId)
              .update({
            'center':
                GeoPoint(currentLocation.latitude, currentLocation.longitude)
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitingRoom(roomId: widget.roomId)));
        },
      ),
    );
    // : Container(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ));
  }
}
