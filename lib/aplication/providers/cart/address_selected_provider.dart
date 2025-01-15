import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/model/address.dart';
import 'package:latlong2/latlong.dart';


final addressSelected = StateProvider<Address>(
  (ref) {
    return Address(address: '', coordinates: const LatLng(0, 0));
  },
);