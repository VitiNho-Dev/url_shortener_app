import 'package:get_it/get_it.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';
import 'package:url_shortener_app/app/home/data/services/local/db_client.dart';
import 'package:url_shortener_app/app/home/data/repositories/home_repository.dart';
import 'package:url_shortener_app/app/home/data/services/api/api_client.dart';
import 'package:url_shortener_app/app/home/data/services/local/local_data_service.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerFactory<ApiClient>(() => ApiClient());
  getIt.registerFactory<HomeRepository>(
    () => ApiHomeRepository(apiClient: getIt()),
  );
  getIt.registerFactory<LocalDataService>(
    () => LocalDataService(dbClient: getIt()),
  );
  getIt.registerSingleton<DBClient>(DBClient());
  getIt.registerSingleton<HomeController>(
    HomeController(
      repository: getIt(),
      dataService: getIt(),
    ),
  );
}
