import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rti_task/data/hive_model/hive_employee_model.dart';

class HiveInitialize {
  HiveInitialize() {
    init();
  }

  init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HiveEmployeeModelAdapter());
    }

    await Hive.openBox<HiveEmployeeModel>('employee');
  }
}
