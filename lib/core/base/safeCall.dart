import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:task_flow/core/base/results.dart';

Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call) async {
  try {
    return await call();
  } on SocketException catch (e, stackTrace) {
    if (kDebugMode) {
      print(stackTrace.toString());
    }
    return Failure(exception: e, message: stackTrace.toString());
  } on IOException catch (e, stackTrace) {
    return Failure(exception: e, message: stackTrace.toString());
  } on TimeoutException catch (e, stackTrace) {
    if (kDebugMode) {
      print(stackTrace.toString());
    }
    return Failure(exception: e, message: stackTrace.toString());
  } on FormatException catch (e, stackTrace) {
    if (kDebugMode) {
      print(stackTrace.toString());
    }
    return Failure(exception: e, message: stackTrace.toString());
  }
}
