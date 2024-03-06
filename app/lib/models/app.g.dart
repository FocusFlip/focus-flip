// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppAdapter extends TypeAdapter<App> {
  @override
  final int typeId = 0;

  @override
  App read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return App(
      name: fields[0] as String,
      url: fields[2] as String,
      packageName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, App obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TriggerAppAdapter extends TypeAdapter<TriggerApp> {
  @override
  final int typeId = 1;

  @override
  TriggerApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TriggerApp(
      name: fields[0] as String,
      url: fields[2] as String,
      packageName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TriggerApp obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriggerAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthyAppAdapter extends TypeAdapter<HealthyApp> {
  @override
  final int typeId = 2;

  @override
  HealthyApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthyApp(
      name: fields[0] as String,
      url: fields[2] as String,
      packageName: fields[1] as String?,
      requiredUsageDuration: fields[3] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, HealthyApp obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.requiredUsageDuration)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthyAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
