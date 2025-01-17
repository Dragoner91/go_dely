import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';

final categoryRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<ICategoryRepository>();
  },
);