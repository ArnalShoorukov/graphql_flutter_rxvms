import 'package:flutter_graphql/services/graphql_service.dart';
import 'package:get_it/get_it.dart';

import 'managers/data_manager.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  // register services
  sl.registerLazySingleton<GraphQLService>(() => GraphQLService());


  // register managers
  sl.registerLazySingleton<DataManager>(() => DataManager());

}

