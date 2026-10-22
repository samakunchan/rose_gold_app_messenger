import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/repositories/room_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/create_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/delete_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_rooms_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/update_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSupabaseRoomDI() {
  kGetIt
    /// Rooms
    ..registerLazySingleton<RoomDataSource>(() => RoomDataSourceImpl(client: kGetIt<SupabaseClient>()))
    /// Rooms - Repositories
    ..registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl(dataSource: kGetIt<RoomDataSource>()))
    /// Rooms - Use cases
    ..registerLazySingleton<CreateRoomUseCase>(() => CreateRoomUseCase(kGetIt<RoomRepository>()))
    ..registerLazySingleton<UpdateRoomUseCase>(() => UpdateRoomUseCase(kGetIt<RoomRepository>()))
    ..registerLazySingleton<GetRoomsUseCase>(() => GetRoomsUseCase(kGetIt<RoomRepository>()))
    ..registerLazySingleton<DeleteRoomUseCase>(() => DeleteRoomUseCase(kGetIt<RoomRepository>()))
    /// Rooms - Signals
    ..registerLazySingleton<RoomsSignals>(
      () => RoomsSignals(
        createRoomUseCase: kGetIt<CreateRoomUseCase>(),
        updateRoomUseCase: kGetIt<UpdateRoomUseCase>(),
        getRoomsUseCase: kGetIt<GetRoomsUseCase>(),
        deleteRoomUseCase: kGetIt<DeleteRoomUseCase>(),
      ),
    )
  //
  ;
}
