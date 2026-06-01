import 'package:equatable/equatable.dart';

class VideoDetailsEntity extends Equatable {
  final String id;
  final String name;

  const VideoDetailsEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
