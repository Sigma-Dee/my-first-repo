// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      noteTitle: fields[0] as String,
      noteContent: fields[1] as String,
      noteCreatedAt: fields[2] as DateTime,
      noteModifiedAt: fields[3] as DateTime?,
      isLiked: fields[4] as bool,
      isDeleted: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.noteTitle)
      ..writeByte(1)
      ..write(obj.noteContent)
      ..writeByte(2)
      ..write(obj.noteCreatedAt)
      ..writeByte(3)
      ..write(obj.noteModifiedAt)
      ..writeByte(4)
      ..write(obj.isLiked)
      ..writeByte(5)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
