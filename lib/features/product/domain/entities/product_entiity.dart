class ProductEntity {
  String? sId;
  String? sku;
  String? slug;
  String? name;
  String? description;
  String? shortDescription;
  List<String>? categories;
  double? price;
  double? salePrice;
  double? discountPercentage;
  int? stockQuantity;
  bool? isInStock;
  List<Variants>? variants;
  List<Attributes>? attributes;
  List<Images>? images;
  double? averageRating;
  int? reviewCount;
  List<Reviews>? reviews;
  bool? isFeatured;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductEntity({
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
  });
}

class Variants {
  String? sku;
  String? name;
  double? price;
  double? salePrice;
  int? stockQuantity;
  bool? isInStock;
  List<Attributes>? attributes;
  List<Images>? images;

  Variants({
    this.sku,
    this.name,
    this.price,
    this.salePrice,
    this.stockQuantity,
    this.isInStock,
    this.attributes,
    this.images,
  });
}

class Attributes {
  String? name;
  String? value;
  bool? visible;
  bool? variation;

  Attributes({this.name, this.value, this.visible, this.variation});
}

class Images {
  String? url;
  String? alt;
  bool? isPrimary;

  Images({this.url, this.alt, this.isPrimary});
}

class Reviews {
  String? userId;
  String? userName;
  double? rating;
  String? comment;
  String? createdAt;

  Reviews({
    this.userId,
    this.userName,
    this.rating,
    this.comment,
    this.createdAt,
  });
}
