import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentBackendProvider = StateProvider<String>((ref) {
  return "Team Verde";
});