import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'An unexpected error occurred.'});
}

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure({super.message = 'No internet connection.'});
}

class NoLocalDataRequestFailure extends Failure {
  const NoLocalDataRequestFailure({super.message = 'No local data available.'});
}
