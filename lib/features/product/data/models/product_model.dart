import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:julybyoma_app/features/product/domain/entities/product_entiity.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends ProductEntity {
  @HiveField(0)
  final String? sId;
  @HiveField(1)
  final String? sku;
  @HiveField(2)
  final String? slug;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String? shortDescription;
  @HiveField(6)
  final List<String>? categories;
  @HiveField(7)
  final double? price;
  @HiveField(8)
  final double? salePrice;
  @HiveField(9)
  final double? discountPercentage;
  @HiveField(10)
  final int? stockQuantity;
  @HiveField(11)
  final bool? isInStock;
  @HiveField(12)
  final List<VariantsModel>? variants;
  @HiveField(13)
  final List<AttributesModel>? attributes;
  @HiveField(14)
  final List<ImagesModel>? images;
  @HiveField(15)
  final double? averageRating;
  @HiveField(16)
  final int? reviewCount;
  @HiveField(17)
  final List<ReviewsModel>? reviews;
  @HiveField(18)
  final bool? isFeatured;
  @HiveField(19)
  final bool? isPublished;
  @HiveField(20)
  final String? createdAt;
  @HiveField(21)
  final String? updatedAt;
  @HiveField(22)
  final int? iV;

  ProductModel({
    this.sId,
    this.sku,
    this.slug,
    this.name,
    this.description,
    this.shortDescription,
    this.categories,
    this.price,
    this.salePrice,
    this.discountPercentage,
    this.stockQuantity,
    this.isInStock,
    this.variants,
    this.attributes,
    this.images,
    this.averageRating,
    this.reviewCount,
    this.reviews,
    this.isFeatured,
    this.isPublished,
    this.createdAt,
    this.updatedAt,
    this.iV,
  }) : super(
         sId: sId,
         sku: sku,
         slug: slug,
         name: name,
         description: description,
         shortDescription: shortDescription,
         categories: categories,
         price: price,
         salePrice: salePrice,
         discountPercentage: discountPercentage,
         stockQuantity: stockQuantity,
         isInStock: isInStock,
         variants: variants,
         attributes: attributes,
         images: images,
         averageRating: averageRating,
         reviewCount: reviewCount,
         reviews: reviews,
         isFeatured: isFeatured,
         isPublished: isPublished,
         createdAt: createdAt,
         updatedAt: updatedAt,
         iV: iV,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      sId: json['_id'] ?? json['id'],
      sku: json['sku'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['shortDescription'] ?? json['short_description'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] ?? json['sale_price'])?.toDouble(),
      discountPercentage:
          (json['discountPercentage'] ?? json['discount_percentage'])
              ?.toDouble(),
      stockQuantity: json['stockQuantity'] ?? json['stock_quantity'],
      isInStock: json['isInStock'] ?? json['in_stock'],
      variants: json['variants'] != null
          ? (json['variants'] as List)
                .map((e) => VariantsModel.fromJson(e))
                .toList()
          : [],
      attributes: json['attributes'] != null
          ? (json['attributes'] as List)
                .map((e) => AttributesModel.fromJson(e))
                .toList()
          : [],
      images: json['images'] != null
          ? (json['images'] as List)
                .map((e) => ImagesModel.fromJson(e))
                .toList()
          : [],
      averageRating: (json['averageRating'] ?? json['avg_rating'])?.toDouble(),
      reviewCount: json['reviewCount'] ?? json['reviews_count'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
                .map((e) => ReviewsModel.fromJson(e))
                .toList()
          : [],
      isFeatured: json['isFeatured'] ?? json['featured'],
      isPublished: json['isPublished'] ?? json['published'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'] ?? json['iV'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'sku': sku,
    'slug': slug,
    'name': name,
    'description': description,
    'shortDescription': shortDescription,
    'categories': categories,
    'price': price,
    'salePrice': salePrice,
    'discountPercentage': discountPercentage,
    'stockQuantity': stockQuantity,
    'isInStock': isInStock,
    'variants': variants?.map((e) => e.toJson()).toList(),
    'attributes': attributes?.map((e) => e.toJson()).toList(),
    'images': images?.map((e) => e.toJson()).toList(),
    'averageRating': averageRating,
    'reviewCount': reviewCount,
    'reviews': reviews?.map((e) => e.toJson()).toList(),
    'isFeatured': isFeatured,
    'isPublished': isPublished,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };

  static List<ProductModel> listFromJson(dynamic jsonList) {
    if (jsonList == null) return [];
    if (jsonList is String) {
      final parsed = jsonDecode(jsonList);
      if (parsed is List) {
        return parsed.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    if (jsonList is List) {
      return jsonList.map((e) => ProductModel.fromJson(e)).toList();
    }
    return [];
  }
}

@HiveType(typeId: 1)
class VariantsModel extends Variants {
  @HiveField(0)
  final String? sku;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final double? salePrice;
  @HiveField(4)
  final int? stockQuantity;
  @HiveField(5)
  final bool? isInStock;
  @HiveField(6)
  final List<AttributesModel>? attributes;
  @HiveField(7)
  final List<ImagesModel>? images;

  VariantsModel({
    this.sku,
    this.name,
    this.price,
    this.salePrice,
    this.stockQuantity,
    this.isInStock,
    this.attributes,
    this.images,
  }) : super(
         sku: sku,
         name: name,
         price: price,
         salePrice: salePrice,
         stockQuantity: stockQuantity,
         isInStock: isInStock,
         attributes: attributes,
         images: images,
       );

  factory VariantsModel.fromJson(Map<String, dynamic> json) => VariantsModel(
    sku: json['sku'],
    name: json['name'],
    price: (json['price'] as num?)?.toDouble(),
    salePrice: (json['salePrice'] ?? json['sale_price'])?.toDouble(),
    stockQuantity: json['stockQuantity'] ?? json['stock_quantity'],
    isInStock: json['isInStock'],
    attributes: json['attributes'] != null
        ? (json['attributes'] as List)
              .map((e) => AttributesModel.fromJson(e))
              .toList()
        : [],
    images: json['images'] != null
        ? (json['images'] as List).map((e) => ImagesModel.fromJson(e)).toList()
        : [],
  );

  Map<String, dynamic> toJson() => {
    'sku': sku,
    'name': name,
    'price': price,
    'salePrice': salePrice,
    'stockQuantity': stockQuantity,
    'isInStock': isInStock,
    'attributes': attributes?.map((e) => e.toJson()).toList(),
    'images': images?.map((e) => e.toJson()).toList(),
  };
}

@HiveType(typeId: 2)
class AttributesModel extends Attributes {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? value;
  @HiveField(2)
  final bool? visible;
  @HiveField(3)
  final bool? variation;

  AttributesModel({this.name, this.value, this.visible, this.variation})
    : super(name: name, value: value, visible: visible, variation: variation);

  factory AttributesModel.fromJson(Map<String, dynamic> json) =>
      AttributesModel(
        name: json['name'],
        value: json['value'],
        visible: json['visible'],
        variation: json['variation'],
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
    'visible': visible,
    'variation': variation,
  };
}

@HiveType(typeId: 3)
class ImagesModel extends Images {
  @HiveField(0)
  final String? url;
  @HiveField(1)
  final String? alt;
  @HiveField(2)
  final bool? isPrimary;

  ImagesModel({this.url, this.alt, this.isPrimary})
    : super(url: url, alt: alt, isPrimary: isPrimary);

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
    url: json['url'],
    alt: json['alt'],
    isPrimary: json['isPrimary'],
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'alt': alt,
    'isPrimary': isPrimary,
  };
}

@HiveType(typeId: 4)
class ReviewsModel extends Reviews {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? userName;
  @HiveField(2)
  final double? rating;
  @HiveField(3)
  final String? comment;
  @HiveField(4)
  final String? createdAt;

  ReviewsModel({
    this.userId,
    this.userName,
    this.rating,
    this.comment,
    this.createdAt,
  }) : super(
         userId: userId,
         userName: userName,
         rating: rating,
         comment: comment,
         createdAt: createdAt,
       );

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    userId: json['userId'] ?? json['user_id'],
    userName: json['userName'] ?? json['user_name'],
    rating: (json['rating'] as num?)?.toDouble(),
    comment: json['comment'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'rating': rating,
    'comment': comment,
    'createdAt': createdAt,
  };
}
