import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaView extends StatefulWidget {
  @override
  State<MapaView> createState() => MapaViewState();
}

class MapaViewState extends State<MapaView> {
  late GoogleMapController _controller;
  Set<Marker> marcadores = Set();
  //Position? _ubicacionActual;

  static final CameraPosition _kMadrid = CameraPosition(
    target: LatLng(40.4227274, -3.5312032), // Coordenadas de Madrid
    zoom: 14.0,
  );

  /*Future<void> ubicacionActual() async {
    final posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _ubicacionActual = posicion;
    });
  }*/

  @override
  void initState() {
    //ubicacionActual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kMadrid,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: marcadores,
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/homeview');
              },
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('IES Rey Fernando VI'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }


  Future<void> _goToTheLake() async {
    CameraPosition _kUser = CameraPosition(
      target: LatLng(40.422767815469285, -3.528639686059464),
      //tilt: 59.440717697143555,
      zoom: 15,
    );

    _controller.animateCamera(CameraUpdate.newCameraPosition(_kUser));

    Marker marcador = Marker(
      markerId: MarkerId('1'),
      position: LatLng(40.46151833607977, -3.4902259282354193),
    );

    Marker marcador2 = Marker(
      markerId: MarkerId('2'),
      position: LatLng(40.432999470281096, -3.5334851040598427),
    );

    Marker marcador3 = Marker(
      markerId: MarkerId('3'),
      position: LatLng(40.4272174011443, -3.5267903107408456),
    );

    Marker marcador4 = Marker(
      markerId: MarkerId('4'),
      position: LatLng(40.42427717533754, -3.5325409665404974),
    );

    Marker marcador5 = Marker(
      markerId: MarkerId('5'),
      position: LatLng(40.42213726352629, -3.5344614280855304),
    );

    setState(() {
      marcadores.add(marcador);
      marcadores.add(marcador2);
      marcadores.add(marcador3);
      marcadores.add(marcador4);
      marcadores.add(marcador5);
    });
  }
}