import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred. Please try again.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to load local cache data.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Please check your internet connection and try again.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed. Please verify credentials.']);
}

class StreamFailure extends Failure {
  const StreamFailure([super.message = 'Video stream decoding or loading failed.']);
}
