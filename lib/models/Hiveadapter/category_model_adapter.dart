import 'package:hive/hive.dart';
import '../category_model.dart';

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final typeId = 11; // Ensure this typeId is unique

  @override
  Category read(BinaryReader reader) {
    final catref = reader.readString();
    final id = reader.readString();
    final name = reader.readString();
    final description = reader.readString();
    final imageUrl = reader.readString();
    final color = reader.readString();
    final visibility = reader.readBool();
    final createdTime = reader.readString();
    final bannerImage = reader.readString();
    final isDeleted = reader.readBool();

    return Category(
      catref: catref,
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      color: color,
      visibility: visibility,
      createdTime: createdTime,
      bannerImage: bannerImage,
      isDeleted: isDeleted,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeString(obj.catref);
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.color);
    writer.writeBool(obj.visibility ?? true); // Handle null visibility
    writer.writeString(obj.createdTime ??
        DateTime.now().toString()); // Handle null createdTime
    writer.writeString(obj.bannerImage);
    writer.writeBool(obj.isDeleted);
  }
}
