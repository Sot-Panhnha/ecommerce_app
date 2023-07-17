import 'dart:convert';

class Product {
  final String name;
  final String description;
  final String category;
  final double price;
  final double quantity;
  final String? id;
  final List<String> images;
  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    this.id,
    required this.images
  });

  factory Product.fromMap(Map<String, dynamic> map){
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['name']?.toDouble() ?? 0.0,
      images:List<String>.from(map['image']),
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'category': category,
    'price': price,
    'quantity': quantity,
    'id': id,
    'images': images,
  };

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source){
    return Product.fromJson(json.decode(source));
  }
}