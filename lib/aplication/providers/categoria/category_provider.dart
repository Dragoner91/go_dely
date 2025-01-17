import 'package:flutter_riverpod/flutter_riverpod.dart';



/*final CategoryProvider = Provider((ref) {
    return estadoCatalogo;
  },
);*/

final CategoryProvider = StateProvider<bool>((ref){
  return true;

});

final currentCategory = StateProvider<String> ((ref) {
  return '';
});

/*void changeStateCategory({required bool newstate}) async {
  estadoCatalogo = newstate;
}*/