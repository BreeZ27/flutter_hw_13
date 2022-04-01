import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'source.config.dart';

@InjectableInit()
void initializeBlocs() {
  initializeServices();
  $initGetIt(GetIt.I);
}
