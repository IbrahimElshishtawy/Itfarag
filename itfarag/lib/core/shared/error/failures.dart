import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'A server error occurred. Please try again.']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Failed to load local cache data.']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Please check your internet connection and try again.']) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication failed. Please verify credentials.']) : super(message);
}

class StreamFailure extends Failure {
  const StreamFailure([String message = 'Video stream decoding or loading failed.']) : super(message);
}
