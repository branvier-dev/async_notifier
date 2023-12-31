import 'package:flutter/widgets.dart';

import '../async_listenable_base.dart';
import 'async_snapshot_extension.dart';

/// Extension for [AsyncListenableBase].
extension AsyncListenableBaseExtension<T, Data extends T>
    on AsyncListenableBase<T, Data> {
  /// Wheter [future] or [stream] is computing for the first time.
  bool get isLoading => snapshot.connectionState == ConnectionState.waiting;

  /// Wheter [future] or [stream] is recomputing.
  bool get isReloading =>
      (hasData || hasError) &&
      (isLoading || snapshot.connectionState == ConnectionState.active);

  /// Wheter [future] or [stream] threw an error.
  bool get hasError => snapshot.hasError;

  /// Wheter [future] or [stream] has data.
  bool get hasData => snapshot.hasData;

  /// The current error of [future] or [stream].
  Object? get error => snapshot.error;

  /// The current [StackTrace] of [future] or [stream].
  StackTrace? get stackTrace => snapshot.stackTrace;

  /// The current [ConnectionState] of [future] or [stream].
  ConnectionState get connectionState => snapshot.connectionState;

  /// Handles different states of this [snapshot].
  ///
  /// For more details, see the documentation for [AsyncSnapshotExtension.when].
  R when<R>({
    required R Function(Data data) data,
    required R Function(Object error, StackTrace stackTrace) error,
    required R Function() loading,
    R Function(Data data)? reloading,
    R Function()? none,
  }) {
    return snapshot.when(
      data: data,
      error: error,
      loading: loading,
      reloading: reloading,
      none: none,
    );
  }
}

/// Extension for [AsyncListenableBase] with nullable [T] or [Data].
extension AsyncListenableNullableExtension<T, Data extends T>
    on AsyncListenableBase<T?, Data?> {
  /// Returns latest data received, failing if there is no data.
  T get requireData => value ?? snapshot.requireData!;
}
