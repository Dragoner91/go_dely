import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/infraestructure/datasources/combo_db_datasource.dart';
import 'package:go_dely/infraestructure/repositories/combo_repository_impl.dart';

final combosRepositoryProvider = Provider((ref) {
    return ComboRepositoryImpl(datasource: ComboDBDatasource());
  },
);