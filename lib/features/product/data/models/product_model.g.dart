// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      sId: fields[0] as String?,
      sku: fields[1] as String?,
      slug: fields[2] as String?,
      name: fields[3] as String?,
      description: fields[4] as String?,
      shortDescription: fields[5] as String?,
      categories: (fields[6] as List?)?.cast<String>(),
      price: fields[7] as double?,
      salePrice: fields[8] as double?,
      discountPercentage: fields[9] as double?,
      stockQuantity: fields[10] as int?,
      isInStock: fields[11] as bool?,
      variants: (fields[12] as List?)?.cast<VariantsModel>(),
      attributes: (fields[13] as List?)?.cast<AttributesModel>(),
      images: (fields[14] as List?)?.cast<ImagesModel>(),
      averageRating: fields[15] as double?,
      reviewCount: fields[16] as int?,
      reviews: (fields[17] as List?)?.cast<ReviewsModel>(),
      isFeatured: fields[18] as bool?,
      isPublished: fields[19] as bool?,
      createdAt: fields[20] as String?,
      updatedAt: fields[21] as String?,
      iV: fields[22] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.sku)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.shortDescription)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.salePrice)
      ..writeByte(9)
      ..write(obj.discountPercentage)
      ..writeByte(10)
      ..write(obj.stockQuantity)
      ..writeByte(11)
      ..write(obj.isInStock)
      ..writeByte(12)
      ..write(obj.variants)
      ..writeByte(13)
      ..write(obj.attributes)
      ..writeByte(14)
      ..write(obj.images)
      ..writeByte(15)
      ..write(obj.averageRating)
      ..writeByte(16)
      ..write(obj.reviewCount)
      ..writeByte(17)
      ..write(obj.reviews)
      ..writeByte(18)
      ..write(obj.isFeatured)
      ..writeByte(19)
      ..write(obj.isPublished)
      ..writeByte(20)
      ..write(obj.createdAt)
      ..writeByte(21)
      ..write(obj.updatedAt)
      ..writeByte(22)
      ..write(obj.iV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariantsModelAdapter extends TypeAdapter<VariantsModel> {
  @override
  final int typeId = 1;

  @override
  VariantsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariantsModel(
      sku: fields[0] as String?,
      name: fields[1] as String?,
      price: fields[2] as double?,
      salePrice: fields[3] as double?,
      stockQuantity: fields[4] as int?,
      isInStock: fields[5] as bool?,
      attributes: (fields[6] as List?)?.cast<AttributesModel>(),
      images: (fields[7] as List?)?.cast<ImagesModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, VariantsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sku)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.salePrice)
      ..writeByte(4)
      ..write(obj.stockQuantity)
      ..writeByte(5)
      ..write(obj.isInStock)
      ..writeByte(6)
      ..write(obj.attributes)
      ..writeByte(7)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttributesModelAdapter extends TypeAdapter<AttributesModel> {
  @override
  final int typeId = 2;

  @override
  AttributesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttributesModel(
      name: fields[0] as String?,
      value: fields[1] as String?,
      visible: fields[2] as bool?,
      variation: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AttributesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.visible)
      ..writeByte(3)
      ..write(obj.variation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesModelAdapter extends TypeAdapter<ImagesModel> {
  @override
  final int typeId = 3;

  @override
  ImagesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagesModel(
      url: fields[0] as String?,
      alt: fields[1] as String?,
      isPrimary: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ImagesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.alt)
      ..writeByte(2)
      ..write(obj.isPrimary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReviewsModelAdapter extends TypeAdapter<ReviewsModel> {
  @override
  final int typeId = 4;

  @override
  ReviewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewsModel(
      userId: fields[0] as String?,
      userName: fields[1] as String?,
      rating: fields[2] as double?,
      comment: fields[3] as String?,
      createdAt: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
