// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canvasServiceHash() => r'5b1a2d826f834591e3a1f54729088fcb0115abd2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CanvasService
    extends BuildlessAutoDisposeNotifier<CanvasState> {
  late final Key key;

  CanvasState build({
    required Key key,
  });
}

/// See also [CanvasService].
@ProviderFor(CanvasService)
const canvasServiceProvider = CanvasServiceFamily();

/// See also [CanvasService].
class CanvasServiceFamily extends Family<CanvasState> {
  /// See also [CanvasService].
  const CanvasServiceFamily();

  /// See also [CanvasService].
  CanvasServiceProvider call({
    required Key key,
  }) {
    return CanvasServiceProvider(
      key: key,
    );
  }

  @override
  CanvasServiceProvider getProviderOverride(
    covariant CanvasServiceProvider provider,
  ) {
    return call(
      key: provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'canvasServiceProvider';
}

/// See also [CanvasService].
class CanvasServiceProvider
    extends AutoDisposeNotifierProviderImpl<CanvasService, CanvasState> {
  /// See also [CanvasService].
  CanvasServiceProvider({
    required this.key,
  }) : super.internal(
          () => CanvasService()..key = key,
          from: canvasServiceProvider,
          name: r'canvasServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canvasServiceHash,
          dependencies: CanvasServiceFamily._dependencies,
          allTransitiveDependencies:
              CanvasServiceFamily._allTransitiveDependencies,
        );

  final Key key;

  @override
  bool operator ==(Object other) {
    return other is CanvasServiceProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  CanvasState runNotifierBuild(
    covariant CanvasService notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
