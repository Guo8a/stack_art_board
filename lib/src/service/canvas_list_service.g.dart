// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_list_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canvasListServiceHash() => r'f0b544094d32924dd28fc0a2d103b6dde1fed5be';

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

abstract class _$CanvasListService
    extends BuildlessAutoDisposeNotifier<List<CanvasItem>> {
  late final Key key;

  List<CanvasItem> build({
    required Key key,
  });
}

/// See also [CanvasListService].
@ProviderFor(CanvasListService)
const canvasListServiceProvider = CanvasListServiceFamily();

/// See also [CanvasListService].
class CanvasListServiceFamily extends Family<List<CanvasItem>> {
  /// See also [CanvasListService].
  const CanvasListServiceFamily();

  /// See also [CanvasListService].
  CanvasListServiceProvider call({
    required Key key,
  }) {
    return CanvasListServiceProvider(
      key: key,
    );
  }

  @override
  CanvasListServiceProvider getProviderOverride(
    covariant CanvasListServiceProvider provider,
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
  String? get name => r'canvasListServiceProvider';
}

/// See also [CanvasListService].
class CanvasListServiceProvider extends AutoDisposeNotifierProviderImpl<
    CanvasListService, List<CanvasItem>> {
  /// See also [CanvasListService].
  CanvasListServiceProvider({
    required this.key,
  }) : super.internal(
          () => CanvasListService()..key = key,
          from: canvasListServiceProvider,
          name: r'canvasListServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canvasListServiceHash,
          dependencies: CanvasListServiceFamily._dependencies,
          allTransitiveDependencies:
              CanvasListServiceFamily._allTransitiveDependencies,
        );

  final Key key;

  @override
  bool operator ==(Object other) {
    return other is CanvasListServiceProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  List<CanvasItem> runNotifierBuild(
    covariant CanvasListService notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
