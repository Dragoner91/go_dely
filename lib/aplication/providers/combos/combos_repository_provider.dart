import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';

final combosRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<IComboRepository>();
  },
);