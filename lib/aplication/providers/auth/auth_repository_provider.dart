import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';

final authRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<IAuthRepository>();
  },
);