import 'package:flutter_riverpod/flutter_riverpod.dart';



/*final CategoryProvider = Provider((ref) {
    return estadoCatalogo;
  },
);*/

final CategoryProvider = StateProvider<bool>((ref){
  return true;

});

/*void changeStateCategory({required bool newstate}) async {
  estadoCatalogo = newstate;
}*/