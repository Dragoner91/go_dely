import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool estadoCatalogo = true;



/*final CategoryProvider = Provider((ref) {
    return estadoCatalogo;
  },
);*/

final CategoryProvider = StateProvider<bool>((ref){
  return estadoCatalogo;

});

/*void changeStateCategory({required bool newstate}) async {
  estadoCatalogo = newstate;
}*/