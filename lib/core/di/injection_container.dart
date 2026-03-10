import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Configures all dependencies using Injectable annotations
///
/// This function initializes the service locator by reading the generated
/// @Injectable annotations throughout the codebase.
/// 
/// The [env] parameter allows for environment-specific registrations (dev, prod, test)
@injectableInit
void configureDependencies({String environment = 'prod'}) {
  getIt.init(environment: environment);
}
