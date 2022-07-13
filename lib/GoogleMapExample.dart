import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class GoogleMapExample extends StatefulWidget {


  @override
  State<GoogleMapExample> createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center =  LatLng(9.669111, 80.014007);

  GoogleMapController _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};

  Timer timer;
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  BitmapDescriptor customIcon;
  void getLocation() async{
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10)),
        'Image/google.png')
        .then((d) {
      customIcon = d;
    });

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) async{
      await FirebaseFirestore.instance.collection("Employee").doc("fpMJJ0hIo9g7Ty2hEePx").get().then((document){
        setState(() {
          _markers.add(Marker(markerId: MarkerId('Home'),icon: customIcon,
              position: LatLng(double.parse(document["lattitude"].toString()),double.parse(document["longtitude"].toString()))
          ));
        });
      });
    });
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GoogleMap...."),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937,78.9629),
          zoom: 9,
        ),
        // markers: markers.values.toSet(),
        onMapCreated: (GoogleMapController controller)
        {
          _controller = controller;
        },
        markers : _markers,
      ),
    );
  }
}
