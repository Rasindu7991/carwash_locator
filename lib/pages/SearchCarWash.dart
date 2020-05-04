import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchCarWash extends StatefulWidget {
  @override
  State<SearchCarWash> createState() => MapSampleState();
}

class MapSampleState extends State<SearchCarWash> {
  bool mapEnabled=false;
  var currentLocation;
  String searchLocation;
  LatLng searchLocationLatLng;
  double distanceInMeters;
  GoogleMapController mapController;
  BitmapDescriptor pinLocationIcon,pinSearchLocationIcon;
  List<Marker> markers = <Marker>[];
  var carWashLocation=[];

  void initState(){
    super.initState();
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((currentlocation){
      setState(() {
           currentLocation=currentlocation;
           mapEnabled=true;
//           populateCarWash();
      });
    });
//    populateCarWash();
    setCustomMapPin();
  }
  void populateCarWash() async{
    carWashLocation=[];
    await Firestore.instance.collection('markers').getDocuments().then((docs){
        if(docs.documents.isNotEmpty){
          for(int i=0;i<docs.documents.length;++i){
              carWashLocation.add(docs.documents[i].data);
              initMarker(docs.documents[i].data);
          }
        }
    });
  }
   initMarker(client){
    markers.add(Marker(
      markerId: MarkerId(client['id']),
      position: LatLng(client['location'].latitude,client['location'].longitude),
      draggable: false,
      infoWindow: InfoWindow(
        title: client['carwashName'],
      )
    ));
   }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/pin.png');
    pinSearchLocationIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/signs_pin.png');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[

          mapEnabled ? Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: onMapCreated,
                mapType: MapType.hybrid,
                initialCameraPosition:CameraPosition(
                  target: LatLng(currentLocation.latitude,currentLocation.longitude),
                  zoom: 15.0,
//                        bearing: 192.8334901395799,
//                        tilt: 59.440717697143555,
                ),
                markers: Set<Marker>.of(markers),
              ),
              Positioned(
                top: 30.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white70
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search Car Wash',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0,top: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.indigo[400],
                            onPressed: viewSearchLocation,
                            iconSize: 33.0,
                          )
                      ),
                      onChanged: (val){
                        setState(() {
                          searchLocation=val;
                        });
                      },
                    )
                ),
              ),
            ],
          )
          : Center(
                  child:
                  Text('Loading Please Wait',style: TextStyle(
                    fontSize: 20.0,
                  ),),
                ),
    ]));
  }

  viewSearchLocation() async{
    await Geolocator().placemarkFromAddress(searchLocation).then((result){
      searchLocationLatLng=LatLng(result[0].position.latitude, result[0].position.longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
     setState(() {
      markers.add(Marker(
          markerId: MarkerId('1122'),
          position: LatLng(searchLocationLatLng.latitude, searchLocationLatLng.longitude),
          icon: pinSearchLocationIcon,
          infoWindow: InfoWindow(
            title: 'Search Location',
          )
      ));
    });
    await mapController.showMarkerInfoWindow(MarkerId('1122'));
    FocusScope.of(context).requestFocus(new FocusNode());
     distanceInMeters = await Geolocator().distanceBetween(currentLocation.latitude, currentLocation.longitude, searchLocationLatLng.latitude, searchLocationLatLng.longitude)/1000;
     distanceInMeters=distanceInMeters.roundToDouble();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Distance from Your Location '+distanceInMeters.toString()+' KM'),
      duration: Duration(seconds: 3),
    ));
  }

 void onMapCreated(controller){
    setState(() {
      mapController=controller;
      markers.add(Marker(
        markerId: MarkerId('1111'),
        position: LatLng(currentLocation.latitude,currentLocation.longitude),
        icon: pinLocationIcon,
        infoWindow: InfoWindow(
          title: 'You are Here!',
        )
      )
      );
//      populateCarWash();
    });
 }

}