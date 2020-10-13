import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/**
 * CUSTOM COMPONENT FOR CREATING MAP
 */
class AppMap extends StatefulWidget {
  final double width;
  final double height;
  final double centerLat;
  final double centerLng;
  final Set<Marker> markers;

  AppMap(
      {@required this.height,
      @required this.centerLat,
      @required this.centerLng,
      this.width,
      this.markers});

  @override
  _AppMapState createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng _centerLatLng;
  CameraPosition _center;

  @override
  void initState() {
    super.initState();

    _centerLatLng = LatLng(widget.centerLat, widget.centerLng);
    _center = CameraPosition(target: _centerLatLng, zoom: 14.4746);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _center,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: widget.markers ?? null,
        ),
      ),
    );
  }
}
