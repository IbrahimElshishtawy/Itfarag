import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String id;
  final String name;

  const VideoEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
