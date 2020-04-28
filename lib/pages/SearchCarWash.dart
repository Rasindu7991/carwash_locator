import 'dart:async';
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
  GoogleMapController mapController;
  BitmapDescriptor pinLocationIcon;
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
    populateCarWash();
    setCustomMapPin();
  }
  void populateCarWash(){
    carWashLocation=[];
    Firestore.instance.collection('markers').getDocuments().then((docs){
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 130.0,
//                width: double.infinity,
                child:mapEnabled ? GoogleMap(
                      onMapCreated: onMapCreated,
                      mapType: MapType.hybrid,
                      initialCameraPosition:CameraPosition(
                        target: LatLng(currentLocation.latitude,currentLocation.longitude),
                        zoom: 15.0,
//                        bearing: 192.8334901395799,
//                        tilt: 59.440717697143555,
                      ),
                      markers: Set<Marker>.of(markers),
                ) : Center(
                  child:
                  Text('Loading Please Wait',style: TextStyle(
                    fontSize: 20.0,
                  ),),
                ),
              )
            ],
          )
        ],
      ),
    );
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
      populateCarWash();
    });
 }


}