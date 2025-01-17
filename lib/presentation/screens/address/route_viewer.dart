import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/config/constants/ubication.dart';
import 'package:latlong2/latlong.dart';

class RouteViewer extends StatefulWidget {
  final MapController mapController = MapController();
  
  final LatLng initialPosition = Ubication.coordinates;
  final LatLng start = Ubication.coordinates;
  final LatLng end;
  final bool isTracking;

  RouteViewer({super.key, required this.end, required this.isTracking});

  @override
  State<RouteViewer> createState() => _RouteViewerState();
}

class _RouteViewerState extends State<RouteViewer> {

  final Dio dio = Dio();
  List<LatLng> routeCoordinate = [];

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    
    final apiKey = Environment.routeAPI;
    final url = 'https://api.geoapify.com/v1/routing?waypoints=${widget.start.latitude},${widget.start.longitude}|${widget.end.latitude},${widget.end.longitude}&mode=drive&apiKey=$apiKey';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final coordinates = data['features'][0]['geometry']['coordinates'][0];
        setState(() {
          routeCoordinate = coordinates
              .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
              .toList();
        });
      } else {
        throw Exception('Failed to load route');
      }
    } catch (e) {
      throw Exception('Failed to load route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCenter: findMidpoint(widget.start, widget.end),
        initialZoom: 12.5,
        minZoom: 10,
        maxZoom: 22,
        interactionOptions: const InteractionOptions(
        flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
      ),
      children: [
        TileLayer( 
          urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
          maxZoom: 22,
          minZoom: 10
        ),
        
        PolylineLayer(
          polylines: [
            Polyline(
              points: routeCoordinate,
              strokeWidth: 4.0,
              color: Colors.greenAccent,
            ),
          ]
        ),
        MarkerLayer(
          markers: [
            
            Marker(
              width: 80.0,
              height: 80.0,
              point: widget.start,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: widget.end,
              child: const Icon(
                Icons.location_on,
                color: Colors.green,
                size: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}




LatLng findMidpoint(LatLng point1, LatLng point2) {
    final double lat1 = point1.latitude;
    final double lon1 = point1.longitude;
    final double lat2 = point2.latitude;
    final double lon2 = point2.longitude;

    final double dLon = (lon2 - lon1).toRad();

    // Convert latitude and longitude from degrees to radians
    final double lat1Rad = lat1.toRad();
    final double lat2Rad = lat2.toRad();
    final double lon1Rad = lon1.toRad();

    final double bx = cos(lat2Rad) * cos(dLon);
    final double by = cos(lat2Rad) * sin(dLon);
    final double lat3 = atan2(sin(lat1Rad) + sin(lat2Rad), sqrt((cos(lat1Rad) + bx) * (cos(lat1Rad) + bx) + by * by));
    final double lon3 = lon1Rad + atan2(by, cos(lat1Rad) + bx);

    // Convert the midpoint from radians to degrees
    return LatLng(lat3.toDeg(), lon3.toDeg());
  }

  extension on double {
    double toRad() => this * (pi / 180.0);
    double toDeg() => this * (180.0 / pi);
  }