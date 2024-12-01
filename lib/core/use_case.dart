import 'package:go_dely/core/result.dart';

abstract class IUseCase<T, R> {
  Future<Result<R>> execute(T dto);
}