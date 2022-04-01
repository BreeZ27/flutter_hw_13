// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProductBlockStateTearOff {
  const _$ProductBlockStateTearOff();

  ProductLoadingState loading() {
    return const ProductLoadingState();
  }

  ProductLoadedState loaded({required ProductData prodData}) {
    return ProductLoadedState(
      prodData: prodData,
    );
  }
}

/// @nodoc
const $ProductBlockState = _$ProductBlockStateTearOff();

/// @nodoc
mixin _$ProductBlockState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductData prodData) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductLoadingState value) loading,
    required TResult Function(ProductLoadedState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBlockStateCopyWith<$Res> {
  factory $ProductBlockStateCopyWith(
          ProductBlockState value, $Res Function(ProductBlockState) then) =
      _$ProductBlockStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductBlockStateCopyWithImpl<$Res>
    implements $ProductBlockStateCopyWith<$Res> {
  _$ProductBlockStateCopyWithImpl(this._value, this._then);

  final ProductBlockState _value;
  // ignore: unused_field
  final $Res Function(ProductBlockState) _then;
}

/// @nodoc
abstract class $ProductLoadingStateCopyWith<$Res> {
  factory $ProductLoadingStateCopyWith(
          ProductLoadingState value, $Res Function(ProductLoadingState) then) =
      _$ProductLoadingStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductLoadingStateCopyWithImpl<$Res>
    extends _$ProductBlockStateCopyWithImpl<$Res>
    implements $ProductLoadingStateCopyWith<$Res> {
  _$ProductLoadingStateCopyWithImpl(
      ProductLoadingState _value, $Res Function(ProductLoadingState) _then)
      : super(_value, (v) => _then(v as ProductLoadingState));

  @override
  ProductLoadingState get _value => super._value as ProductLoadingState;
}

/// @nodoc

class _$ProductLoadingState implements ProductLoadingState {
  const _$ProductLoadingState();

  @override
  String toString() {
    return 'ProductBlockState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProductLoadingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductData prodData) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductLoadingState value) loading,
    required TResult Function(ProductLoadedState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProductLoadingState implements ProductBlockState {
  const factory ProductLoadingState() = _$ProductLoadingState;
}

/// @nodoc
abstract class $ProductLoadedStateCopyWith<$Res> {
  factory $ProductLoadedStateCopyWith(
          ProductLoadedState value, $Res Function(ProductLoadedState) then) =
      _$ProductLoadedStateCopyWithImpl<$Res>;
  $Res call({ProductData prodData});

  $ProductDataCopyWith<$Res> get prodData;
}

/// @nodoc
class _$ProductLoadedStateCopyWithImpl<$Res>
    extends _$ProductBlockStateCopyWithImpl<$Res>
    implements $ProductLoadedStateCopyWith<$Res> {
  _$ProductLoadedStateCopyWithImpl(
      ProductLoadedState _value, $Res Function(ProductLoadedState) _then)
      : super(_value, (v) => _then(v as ProductLoadedState));

  @override
  ProductLoadedState get _value => super._value as ProductLoadedState;

  @override
  $Res call({
    Object? prodData = freezed,
  }) {
    return _then(ProductLoadedState(
      prodData: prodData == freezed
          ? _value.prodData
          : prodData // ignore: cast_nullable_to_non_nullable
              as ProductData,
    ));
  }

  @override
  $ProductDataCopyWith<$Res> get prodData {
    return $ProductDataCopyWith<$Res>(_value.prodData, (value) {
      return _then(_value.copyWith(prodData: value));
    });
  }
}

/// @nodoc

class _$ProductLoadedState implements ProductLoadedState {
  const _$ProductLoadedState({required this.prodData});

  @override
  final ProductData prodData;

  @override
  String toString() {
    return 'ProductBlockState.loaded(prodData: $prodData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductLoadedState &&
            const DeepCollectionEquality().equals(other.prodData, prodData));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(prodData));

  @JsonKey(ignore: true)
  @override
  $ProductLoadedStateCopyWith<ProductLoadedState> get copyWith =>
      _$ProductLoadedStateCopyWithImpl<ProductLoadedState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductData prodData) loaded,
  }) {
    return loaded(prodData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
  }) {
    return loaded?.call(prodData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductData prodData)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(prodData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductLoadingState value) loading,
    required TResult Function(ProductLoadedState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductLoadingState value)? loading,
    TResult Function(ProductLoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProductLoadedState implements ProductBlockState {
  const factory ProductLoadedState({required ProductData prodData}) =
      _$ProductLoadedState;

  ProductData get prodData;
  @JsonKey(ignore: true)
  $ProductLoadedStateCopyWith<ProductLoadedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ProductBlockEventTearOff {
  const _$ProductBlockEventTearOff();

  _ProductInitEvent init() {
    return const _ProductInitEvent();
  }

  _ProductGetEvent getProd({required int prodId}) {
    return _ProductGetEvent(
      prodId: prodId,
    );
  }

  _ProductSetEvent setProd() {
    return const _ProductSetEvent();
  }
}

/// @nodoc
const $ProductBlockEvent = _$ProductBlockEventTearOff();

/// @nodoc
mixin _$ProductBlockEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(int prodId) getProd,
    required TResult Function() setProd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductInitEvent value) init,
    required TResult Function(_ProductGetEvent value) getProd,
    required TResult Function(_ProductSetEvent value) setProd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBlockEventCopyWith<$Res> {
  factory $ProductBlockEventCopyWith(
          ProductBlockEvent value, $Res Function(ProductBlockEvent) then) =
      _$ProductBlockEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductBlockEventCopyWithImpl<$Res>
    implements $ProductBlockEventCopyWith<$Res> {
  _$ProductBlockEventCopyWithImpl(this._value, this._then);

  final ProductBlockEvent _value;
  // ignore: unused_field
  final $Res Function(ProductBlockEvent) _then;
}

/// @nodoc
abstract class _$ProductInitEventCopyWith<$Res> {
  factory _$ProductInitEventCopyWith(
          _ProductInitEvent value, $Res Function(_ProductInitEvent) then) =
      __$ProductInitEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProductInitEventCopyWithImpl<$Res>
    extends _$ProductBlockEventCopyWithImpl<$Res>
    implements _$ProductInitEventCopyWith<$Res> {
  __$ProductInitEventCopyWithImpl(
      _ProductInitEvent _value, $Res Function(_ProductInitEvent) _then)
      : super(_value, (v) => _then(v as _ProductInitEvent));

  @override
  _ProductInitEvent get _value => super._value as _ProductInitEvent;
}

/// @nodoc

class _$_ProductInitEvent implements _ProductInitEvent {
  const _$_ProductInitEvent();

  @override
  String toString() {
    return 'ProductBlockEvent.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProductInitEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(int prodId) getProd,
    required TResult Function() setProd,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductInitEvent value) init,
    required TResult Function(_ProductGetEvent value) getProd,
    required TResult Function(_ProductSetEvent value) setProd,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _ProductInitEvent implements ProductBlockEvent {
  const factory _ProductInitEvent() = _$_ProductInitEvent;
}

/// @nodoc
abstract class _$ProductGetEventCopyWith<$Res> {
  factory _$ProductGetEventCopyWith(
          _ProductGetEvent value, $Res Function(_ProductGetEvent) then) =
      __$ProductGetEventCopyWithImpl<$Res>;
  $Res call({int prodId});
}

/// @nodoc
class __$ProductGetEventCopyWithImpl<$Res>
    extends _$ProductBlockEventCopyWithImpl<$Res>
    implements _$ProductGetEventCopyWith<$Res> {
  __$ProductGetEventCopyWithImpl(
      _ProductGetEvent _value, $Res Function(_ProductGetEvent) _then)
      : super(_value, (v) => _then(v as _ProductGetEvent));

  @override
  _ProductGetEvent get _value => super._value as _ProductGetEvent;

  @override
  $Res call({
    Object? prodId = freezed,
  }) {
    return _then(_ProductGetEvent(
      prodId: prodId == freezed
          ? _value.prodId
          : prodId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ProductGetEvent implements _ProductGetEvent {
  const _$_ProductGetEvent({required this.prodId});

  @override
  final int prodId;

  @override
  String toString() {
    return 'ProductBlockEvent.getProd(prodId: $prodId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductGetEvent &&
            const DeepCollectionEquality().equals(other.prodId, prodId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(prodId));

  @JsonKey(ignore: true)
  @override
  _$ProductGetEventCopyWith<_ProductGetEvent> get copyWith =>
      __$ProductGetEventCopyWithImpl<_ProductGetEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(int prodId) getProd,
    required TResult Function() setProd,
  }) {
    return getProd(prodId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
  }) {
    return getProd?.call(prodId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
    required TResult orElse(),
  }) {
    if (getProd != null) {
      return getProd(prodId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductInitEvent value) init,
    required TResult Function(_ProductGetEvent value) getProd,
    required TResult Function(_ProductSetEvent value) setProd,
  }) {
    return getProd(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
  }) {
    return getProd?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
    required TResult orElse(),
  }) {
    if (getProd != null) {
      return getProd(this);
    }
    return orElse();
  }
}

abstract class _ProductGetEvent implements ProductBlockEvent {
  const factory _ProductGetEvent({required int prodId}) = _$_ProductGetEvent;

  int get prodId;
  @JsonKey(ignore: true)
  _$ProductGetEventCopyWith<_ProductGetEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ProductSetEventCopyWith<$Res> {
  factory _$ProductSetEventCopyWith(
          _ProductSetEvent value, $Res Function(_ProductSetEvent) then) =
      __$ProductSetEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProductSetEventCopyWithImpl<$Res>
    extends _$ProductBlockEventCopyWithImpl<$Res>
    implements _$ProductSetEventCopyWith<$Res> {
  __$ProductSetEventCopyWithImpl(
      _ProductSetEvent _value, $Res Function(_ProductSetEvent) _then)
      : super(_value, (v) => _then(v as _ProductSetEvent));

  @override
  _ProductSetEvent get _value => super._value as _ProductSetEvent;
}

/// @nodoc

class _$_ProductSetEvent implements _ProductSetEvent {
  const _$_ProductSetEvent();

  @override
  String toString() {
    return 'ProductBlockEvent.setProd()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProductSetEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(int prodId) getProd,
    required TResult Function() setProd,
  }) {
    return setProd();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
  }) {
    return setProd?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(int prodId)? getProd,
    TResult Function()? setProd,
    required TResult orElse(),
  }) {
    if (setProd != null) {
      return setProd();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductInitEvent value) init,
    required TResult Function(_ProductGetEvent value) getProd,
    required TResult Function(_ProductSetEvent value) setProd,
  }) {
    return setProd(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
  }) {
    return setProd?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductInitEvent value)? init,
    TResult Function(_ProductGetEvent value)? getProd,
    TResult Function(_ProductSetEvent value)? setProd,
    required TResult orElse(),
  }) {
    if (setProd != null) {
      return setProd(this);
    }
    return orElse();
  }
}

abstract class _ProductSetEvent implements ProductBlockEvent {
  const factory _ProductSetEvent() = _$_ProductSetEvent;
}
