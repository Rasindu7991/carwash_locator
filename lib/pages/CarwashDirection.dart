import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class CarwashDirection extends StatefulWidget {
  CarwashDirection({this.shopid,this.shopname});
  final String shopid;
  final String shopname;

  @override
  State<CarwashDirection> createState() => MapSampleState();
}
bool mapEnabled=false;
var currentLocation;
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 10;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
LatLng destinationLocation;


class MapSampleState extends State<CarwashDirection> {
  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "put the google maps api here!!";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((currentlocation){
      setState(() {
        currentLocation=currentlocation;
        mapEnabled=true;
      });
    });
    getShopLocation();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');
  }

  void getShopLocation() async{
      await Firestore.instance.collection('markers').where('id',isEqualTo: widget.shopid).getDocuments().then((docs){
      if(docs.documents.isNotEmpty){
            docs.documents.forEach((result){
              destinationLocation = LatLng(result.data['location'].latitude,result.data['location'].longitude);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: LatLng(currentLocation.latitude,currentLocation.longitude));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Direction'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated),
    );
  }

   void onMapCreated(GoogleMapController controller) async{
//    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    await setMapPins();
    await setPolylines();
  }

   Future<void> setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(currentLocation.latitude,currentLocation.longitude),
          icon: sourceIcon,
          ));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: LatLng(destinationLocation.latitude,destinationLocation.longitude),
          icon: destinationIcon,
          infoWindow: InfoWindow(title:widget.shopname)
      ));
    });
  }

  setPolylines() async {

    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }


}
