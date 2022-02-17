import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

extension EventHandler on Bloc {
  Future<void> handleEvent<T>(
    event, {
    bool Function(T)? validator,
  }) {
    final _completer = Completer<void>();
    late StreamSubscription _subsc;
    _subsc = stream.listen(
      (_state) {
        if (_state is T) {
          var isValidated = validator?.call(_state) ?? true;
          if (null is T || isValidated) {
            _subsc.cancel();
            _completer.complete(null);
          }
        }
      },
    );
    add(event);
    return _completer.future;
  }
}
