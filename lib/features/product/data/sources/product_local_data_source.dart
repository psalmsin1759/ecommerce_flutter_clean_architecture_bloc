import 'package:hive/hive.dart';
import 'package:julybyoma_app/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();

  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel?> getCachedProductById(String id);

  Future<void> clearCache();
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  static const String productBoxName = "products_box";

  Future<Box> _openBox() async {
    return await Hive.openBox(productBoxName);
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final box = await _openBox();
    final Map<String, dynamic> productMap = {
      for (var product in products) product.sId!: product.toJson(),
    };
    await box.putAll(productMap);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final box = await _openBox();
    final List<ProductModel> products = box.values
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return products;
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    if (product.sId == null) return;
    final box = await _openBox();
    await box.put(product.sId!, product.toJson());
  }

  @override
  Future<ProductModel?> getCachedProductById(String id) async {
    final box = await _openBox();
    final data = box.get(id);
    if (data == null) return null;
    return ProductModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<void> clearCache() async {
    final box = await _openBox();
    await box.clear();
  }
}
