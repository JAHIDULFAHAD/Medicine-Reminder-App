// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:medicine_reminder_app/features/medicine/data/datasources/hive_datasource.dart'
    as _i304;
import 'package:medicine_reminder_app/features/medicine/data/models/history_model.dart'
    as _i471;
import 'package:medicine_reminder_app/features/medicine/data/models/medicine_model.dart'
    as _i987;
import 'package:medicine_reminder_app/features/medicine/data/repositories/medicine_repository_impl.dart'
    as _i395;
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart'
    as _i330;
import 'package:medicine_reminder_app/features/medicine/domain/usecases/add_medicine.dart'
    as _i353;
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_history.dart'
    as _i996;
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_medicines.dart'
    as _i1034;
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart'
    as _i799;
import 'package:medicine_reminder_app/features/medicine/domain/usecases/save_history.dart'
    as _i376;
import 'package:medicine_reminder_app/features/medicine/presentation/cubit/medicine_cubit.dart'
    as _i586;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i304.HiveDataSource>(() => _i304.HiveDataSource(
          medicineBox: gh<_i979.Box<_i987.MedicineModel>>(),
          historyBox: gh<_i979.Box<_i471.HistoryModel>>(),
        ));
    gh.factory<_i330.MedicineRepository>(
        () => _i395.MedicineRepositoryImpl(gh<_i304.HiveDataSource>()));
    gh.factory<_i353.AddMedicine>(
        () => _i353.AddMedicine(gh<_i330.MedicineRepository>()));
    gh.factory<_i376.SaveHistory>(
        () => _i376.SaveHistory(gh<_i330.MedicineRepository>()));
    gh.factory<_i996.GetHistory>(
        () => _i996.GetHistory(gh<_i330.MedicineRepository>()));
    gh.factory<_i1034.GetMedicines>(
        () => _i1034.GetMedicines(gh<_i330.MedicineRepository>()));
    gh.factory<_i799.GetTodayMedicineStatus>(
        () => _i799.GetTodayMedicineStatus(gh<_i330.MedicineRepository>()));
    gh.factory<_i586.MedicineCubit>(() => _i586.MedicineCubit(
          addMedicineUseCase: gh<_i353.AddMedicine>(),
          saveHistoryUseCase: gh<_i376.SaveHistory>(),
          getTodayStatusUseCase: gh<_i799.GetTodayMedicineStatus>(),
          getMedicinesUseCase: gh<_i1034.GetMedicines>(),
          getHistoryUseCase: gh<_i996.GetHistory>(),
        ));
    return this;
  }
}
