import 'package:domain/usecase/cache/config/cache_config.dart';
import 'package:domain/usecase/user/user_usecase.dart';

class UserUseCaseCacheConfig extends CacheConfig<UserUseCaseKeys> {
  UserUseCaseCacheConfig(
    List<UserUseCaseKeys> cacheApis, {
    super.delay,
    super.resetTimer,
  }) {
    for (final key in UserUseCaseKeys.values) {
      if (cacheApis.contains(key)) {
        cache[key] = true;
      } else {
        cache[key] = false;
      }
    }
  }
}
