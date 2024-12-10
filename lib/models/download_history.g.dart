// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadHistoryAdapter extends TypeAdapter<DownloadHistory> {
  @override
  final int typeId = 1;

  @override
  DownloadHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadHistory(
      id: fields[0] as String,
      fileName: fields[1] as String,
      filePath: fields[2] as String,
      progress: fields[3] as double,
      state: fields[4] as String,
      size: fields[5] as int,
      time: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadHistory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.progress)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
