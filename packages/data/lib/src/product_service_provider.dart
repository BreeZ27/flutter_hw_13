import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'product_service_provider.config.dart';

@injectableInit
void initializeServices() => $initGetIt(GetIt.I);
