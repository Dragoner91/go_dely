import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:latlong2/latlong.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const OSMFlutterMap();
  }
}

class OSMFlutterMap extends StatefulWidget {

  const OSMFlutterMap({super.key});

  @override
  State<OSMFlutterMap> createState() => _OSMFlutterMapState();
}

class _OSMFlutterMapState extends State<OSMFlutterMap> {

  MapController mapController = MapController();
  List<LatLng> routeCoordinate = [];
  LatLng start = const LatLng(10.491844819983271, -66.8748406971111);
  LatLng end = const LatLng(10.453942243889514, -66.87650053490484);

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    
    final apiKey = Environment.routeAPI;
    final url = 'https://api.geoapify.com/v1/routing?waypoints=${start.latitude},${start.longitude}|${end.latitude},${end.longitude}&mode=drive&apiKey=$apiKey';

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
      mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(10.491844819983271, -66.8748406971111),
        initialZoom: 15,
        minZoom: 10,
        maxZoom: 22,
        interactionOptions: InteractionOptions(
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
              point: start,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: end,
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