import 'package:equatable/equatable.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubscriptionEvent extends SubscriptionEvent {
  final String id;

  const LoadSubscriptionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
