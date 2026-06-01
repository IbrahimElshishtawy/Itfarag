import 'dart:io';

void main() {
  print('ETFARAG Clean Architecture & BLoC Generator Starting...');

  final features = [
    'auth',
    'home',
    'search',
    'video',
    'video_details',
    'player',
    'profile',
    'notifications',
    'subscription',
    'shorts',
    'live_stream',
    'favorites',
    'settings',
  ];

  for (final feature in features) {
    _generateFeature(feature);
  }

  print('ETFARAG Generator finished successfully! Created 13 features.');
}

void _generateFeature(String feature) {
  final capitalized = _capitalize(feature);
  final baseDir = 'lib/features/$feature';

  // Create presentation/pages, widgets, bloc
  _createDir('$baseDir/presentation/pages');
  _createDir('$baseDir/presentation/widgets');
  _createDir('$baseDir/presentation/bloc');

  // Create domain/entities, repositories, usecases
  _createDir('$baseDir/domain/entities');
  _createDir('$baseDir/domain/repositories');
  _createDir('$baseDir/domain/usecases');

  // Create data/models, datasources, repositories
  _createDir('$baseDir/data/models');
  _createDir('$baseDir/data/datasources');
  _createDir('$baseDir/data/repositories');

  // 1. Generate Domain Entity
  _writeFile(
    '$baseDir/domain/entities/${feature}_entity.dart',
    '''import 'package:equatable/equatable.dart';

class ${capitalized}Entity extends Equatable {
  final String id;
  final String name;

  const ${capitalized}Entity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
''',
  );

  // 2. Generate Domain Repository Interface
  _writeFile(
    '$baseDir/domain/repositories/${feature}_repository.dart',
    '''import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/${feature}_entity.dart';

abstract class ${capitalized}Repository {
  Future<Either<Failure, ${capitalized}Entity>> get${capitalized}Data(String id);
}
''',
  );

  // 3. Generate Domain Use Case
  _writeFile(
    '$baseDir/domain/usecases/get_${feature}_usecase.dart',
    '''import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/${feature}_entity.dart';
import '../repositories/${feature}_repository.dart';

class Get${capitalized}UseCase {
  final ${capitalized}Repository repository;

  Get${capitalized}UseCase(this.repository);

  Future<Either<Failure, ${capitalized}Entity>> call(String id) async {
    return await repository.get${capitalized}Data(id);
  }
}
''',
  );

  // 4. Generate Data Model
  _writeFile(
    '$baseDir/data/models/${feature}_model.dart',
    '''import '../../domain/entities/${feature}_entity.dart';

class ${capitalized}Model extends ${capitalized}Entity {
  const ${capitalized}Model({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory ${capitalized}Model.fromJson(Map<String, dynamic> json) {
    return ${capitalized}Model(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
''',
  );

  // 5. Generate Data Source Interface & Implementation
  _writeFile(
    '$baseDir/data/datasources/${feature}_remote_datasource.dart',
    '''import '../models/${feature}_model.dart';

abstract class ${capitalized}RemoteDataSource {
  Future<${capitalized}Model> fetch${capitalized}FromApi(String id);
}

class ${capitalized}RemoteDataSourceImpl implements ${capitalized}RemoteDataSource {
  @override
  Future<${capitalized}Model> fetch${capitalized}FromApi(String id) async {
    // Stub implementation simulating API fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    return ${capitalized}Model(id: id, name: 'Premium $capitalized Data');
  }
}
''',
  );

  // 6. Generate Data Repository Implementation
  _writeFile(
    '$baseDir/data/repositories/${feature}_repository_impl.dart',
    '''import 'package:dartz/dartz.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/error/exceptions.dart';
import '../../domain/entities/${feature}_entity.dart';
import '../../domain/repositories/${feature}_repository.dart';
import '../datasources/${feature}_remote_datasource.dart';

class ${capitalized}RepositoryImpl implements ${capitalized}Repository {
  final ${capitalized}RemoteDataSource remoteDataSource;

  ${capitalized}RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ${capitalized}Entity>> get${capitalized}Data(String id) async {
    try {
      final remoteData = await remoteDataSource.fetch${capitalized}FromApi(id);
      return Right(remoteData);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure('Connection failed.'));
    }
  }
}
''',
  );

  // 7. Generate BLoC Events
  _writeFile(
    '$baseDir/presentation/bloc/${feature}_event.dart',
    '''import 'package:equatable/equatable.dart';

abstract class ${capitalized}Event extends Equatable {
  const ${capitalized}Event();

  @override
  List<Object?> get props => [];
}

class Load${capitalized}Event extends ${capitalized}Event {
  final String id;

  const Load${capitalized}Event(this.id);

  @override
  List<Object?> get props => [id];
}
''',
  );

  // 8. Generate BLoC States
  _writeFile(
    '$baseDir/presentation/bloc/${feature}_state.dart',
    '''import 'package:equatable/equatable.dart';
import '../../domain/entities/${feature}_entity.dart';

abstract class ${capitalized}State extends Equatable {
  const ${capitalized}State();

  @override
  List<Object?> get props => [];
}

class ${capitalized}Initial extends ${capitalized}State {}

class ${capitalized}Loading extends ${capitalized}State {}

class ${capitalized}Loaded extends ${capitalized}State {
  final ${capitalized}Entity entity;

  const ${capitalized}Loaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ${capitalized}Error extends ${capitalized}State {
  final String message;

  const ${capitalized}Error(this.message);

  @override
  List<Object?> get props => [message];
}
''',
  );

  // 9. Generate BLoC Class
  _writeFile(
    '$baseDir/presentation/bloc/${feature}_bloc.dart',
    '''import 'package:flutter_bloc/flutter_bloc.dart';
import '${feature}_event.dart';
import '${feature}_state.dart';
import '../../domain/usecases/get_${feature}_usecase.dart';

class ${capitalized}Bloc extends Bloc<${capitalized}Event, ${capitalized}State> {
  final Get${capitalized}UseCase get${capitalized}UseCase;

  ${capitalized}Bloc({required this.get${capitalized}UseCase}) : super(${capitalized}Initial()) {
    on<Load${capitalized}Event>((event, emit) async {
      emit(${capitalized}Loading());
      final result = await get${capitalized}UseCase(event.id);
      result.fold(
        (failure) => emit(${capitalized}Error(failure.message)),
        (entity) => emit(${capitalized}Loaded(entity)),
      );
    });
  }
}
''',
  );
}

void _createDir(String path) {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
}

void _writeFile(String path, String content) {
  final file = File(path);
  file.writeAsStringSync(content);
}

String _capitalize(String text) {
  return text.split('_').map((str) {
    if (str.isEmpty) return '';
    return str[0].toUpperCase() + str.substring(1);
  }).join('');
}
