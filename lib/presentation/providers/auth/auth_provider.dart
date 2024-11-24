import 'package:flutter_riverpod/flutter_riverpod.dart';

final AuthProvider = StateProvider<String>((ref){
  String Token = '';

  return Token;

});