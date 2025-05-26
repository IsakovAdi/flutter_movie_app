import '../../../core/error/failure.dart';

const SERVER_FAILURE_MESSAGE = "Server failure";
const CACHED_FAILURE_MESSAGE = "Cache failure";

class ErrorHandler{
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure _:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected failure';
    }
  }
}

