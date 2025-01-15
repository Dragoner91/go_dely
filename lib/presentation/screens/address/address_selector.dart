import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_dely/aplication/model/address.dart';
import 'package:go_dely/aplication/providers/cart/address_selected_provider.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:latlong2/latlong.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const OSMFlutterMap();
  }
}

class OSMFlutterMap extends ConsumerStatefulWidget {

  const OSMFlutterMap({super.key});

  @override
  ConsumerState<OSMFlutterMap> createState() => _OSMFlutterMapState();
}

class _OSMFlutterMapState extends ConsumerState<OSMFlutterMap> {

  MapController mapController = MapController();
  List<LatLng> routeCoordinate = [];
  LatLng initialPosition = const LatLng(10.491844819983271, -66.8748406971111);
  LatLng start = const LatLng(10.491844819983271, -66.8748406971111);
  LatLng end = const LatLng(10.453942243889514, -66.87650053490484);
  LatLng? selectedPoint;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchRoute();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
      mapController.move(initialPosition, 16.0); 
    });
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

  Future<void> _getAddressFromCoordinates(LatLng point) async {
    final url = 'https://nominatim.openstreetmap.org/reverse?format=json&lat=${point.latitude}&lon=${point.longitude}&addressdetails=1';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final address = data['display_name'] ?? 'No address available';
        setState(() {
          ref.read(addressSelected.notifier).update((state) => Address(address: address, coordinates: point));
          print(address);
          selectedPoint = point;
        });
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      print('Failed to get address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, point) {
            _getAddressFromCoordinates(point);
          },
        initialCenter: const LatLng(10.491844819983271, -66.8748406971111),
        initialZoom: 15,
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
        /*
        PolylineLayer(
          polylines: [
            Polyline(
              points: routeCoordinate,
              strokeWidth: 4.0,
              color: Colors.greenAccent,
            ),
          ]
        ),
        */
        MarkerLayer(
          markers: [
            /*
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
            */
            if (selectedPoint != null)
              Marker(
                point: selectedPoint!,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.green,
                  size: 40.0,
                ),
              )
          ],
        ),
      ],
    );
  }
}