import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final double priceBDT;
  final double priceAED;
  final List<Color> colors;
  final String category;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.priceBDT,
    required this.priceAED,
    required this.colors,
    required this.category,
    required this.quantity,
  });

  // Save the current data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'priceBDT': priceBDT,
      'priceAED': priceAED,
      'colors': colors.map((color) => color.value).toList(),
      'category': category,
      'quantity': quantity,
    };
  }

  // Load the current data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      priceBDT: json['priceBDT'],
      priceAED: json['priceAED'],
      colors: (json['colors'] as List).map((color) => Color(color)).toList(),
      category: json['category'],
      quantity: json['quantity'],
    );
  }
}

// All Category er product eidike hobe
final List<Product> all = [
  Product(
    title: "Wireless Headphones",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/all/wireless.png",
    priceBDT: 12000,
    priceAED: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Electronics",
    quantity: 1,
    id: '1',
  ),
  Product(
    title: "Woman Sweter",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/all/sweet.png",
    priceBDT: 12000,
    priceAED: 120,
    colors: [
      Colors.brown,
      Colors.deepPurple,
      Colors.pink,
    ],
    category: "Woman Fashion",
    quantity: 1,
    id: '2',
  ),
  Product(
    title: "Smart Watch",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/all/miband.jpg",
    priceBDT: 5500,
    priceAED: 55,
    colors: [
      Colors.black,
      Colors.amber,
      Colors.purple,
    ],
    category: "Electronics",
    quantity: 1,
    id: '3',
  ),
  Product(
    title: "Mens Jacket",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/all/jacket.png",
    priceBDT: 15500,
    priceAED: 155,
    colors: [
      Colors.blueAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "Men Fashion",
    quantity: 1,
    id: '4',
  ),
  Product(
    title: "Watch",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/watch.png",
    priceBDT: 120000,
    priceAED: 1000,
    colors: [
      Colors.lightBlue,
      Colors.orange,
      Colors.purple,
    ],
    category: "MenFashion",
    quantity: 1,
    id: '5',
  ),
  Product(
    title: "Air Jordan",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/Air Jordan.png",
    priceBDT: 12550,
    priceAED: 255,
    colors: [
      Colors.grey,
      Colors.amber,
      Colors.purple,
    ],
    category: "Shoes",
    quantity: 1,
    id: '6',
  ),
  Product(
    title: "Super Perfume",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/beauty/perfume.png",
    priceBDT: 15500,
    priceAED: 155,
    colors: [
      Colors.purpleAccent,
      Colors.pinkAccent,
      Colors.green,
    ],
    category: "Beauty",
    quantity: 1,
    id: '7',
  ),
  Product(
    title: "Wedding Ring",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/jewelry/wedding ring.png",
    priceBDT: 15500,
    priceAED: 155,
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jewelry",
    quantity: 1,
    id: '8',
  ),
  Product(
    title: "  Pants",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/women fashion/pants.png",
    priceBDT: 12000,
    priceAED: 155,
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "WomenFashion",
    quantity: 1,
    id: '9',
  ),
];

// Shoes related product eidike hobe
final List<Product> shoes = [
  Product(
    title: "Air Jordan",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/Air Jordan.png",
    priceBDT: 12000,
    priceAED: 255,
    colors: [
      Colors.grey,
      Colors.amber,
      Colors.purple,
    ],
    category: "Shoes",
    quantity: 1,
    id: '10',
  ),
  Product(
    title: "Vans Old Skool",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/vans old skool.png",
    priceBDT: 35000,
    priceAED: 300,
    colors: [
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.green,
    ],
    category: "Shoes",
    quantity: 1,
    id: '11',
  ),
  Product(
    title: "Women-Shoes",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/women-shoes.png",
    priceBDT: 42000,
    priceAED: 320,
    colors: [
      Colors.red,
      Colors.orange,
      Colors.greenAccent,
    ],
    category: "Shoes",
    quantity: 1,
    id: '12',
  ),
  Product(
    title: "Sports Shoes",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/sports shoes.png",
    priceBDT: 14800,
    priceAED: 135,
    colors: [
      Colors.deepPurpleAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "Shoes",
    quantity: 1,
    id: '13',
  ),
  Product(
    title: "White Sneaker",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/shoes/white sneaker.png",
    priceBDT: 7000,
    priceAED: 56,
    colors: [
      Colors.blueAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "Shoes",
    quantity: 1,
    id: '14',
  ),
];

// Beauty Related products eidike hobe
final List<Product> beauty = [
  Product(
    title: "Face Care Product",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/beauty/face care.png",
    priceBDT: 25600,
    priceAED: 356,
    colors: [
      Colors.pink,
      Colors.amber,
      Colors.deepOrangeAccent,
    ],
    category: "Beauty",
    quantity: 1,
    id: '15',
  ),
  Product(
    title: "Super Perfume",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/beauty/perfume.png",
    priceBDT: 12000,
    priceAED: 120,
    colors: [
      Colors.purpleAccent,
      Colors.pinkAccent,
      Colors.green,
    ],
    category: "Beauty",
    quantity: 1,
    id: '16',
  ),
  Product(
    title: "Skin-Care Product",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/beauty/face care.png",
    priceBDT: 34000,
    priceAED: 240,
    colors: [
      Colors.black12,
      Colors.orange,
      Colors.white38,
    ],
    category: "Beauty",
    quantity: 1,
    id: '17',
  ),
];

final List<Product> womenFashion = [
  Product(
    title: " Women Kurta",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/women fashion/kurta.png",
    priceBDT: 12000,
    priceAED: 299,
    colors: [
      Colors.grey,
      Colors.black54,
      Colors.purple,
    ],
    category: "WomenFashion",
    quantity: 1,
    id: '18',
  ),
  Product(
    title: "Mens Jacket",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/women fashion/lehenga.png",
    priceBDT: 39000,
    priceAED: 399,
    colors: [
      Colors.black,
      Colors.orange,
      Colors.green,
    ],
    category: "WomenFashion",
    quantity: 1,
    id: '19',
  ),
  Product(
    title: "T-Shert",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/women fashion/t-shert.png",
    priceBDT: 15200,
    priceAED: 136,
    colors: [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.deepOrangeAccent,
    ],
    category: "Electronics",
    quantity: 1,
    id: '20',
  ),
  Product(
    title: "  Pants",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/women fashion/pants.png",
    priceBDT: 4400,
    priceAED: 22,
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "WomenFashion",
    quantity: 1,
    id: '21',
  ),
];

// Add more product lists if needed

final List<Product> jewelry = [
  Product(
    title: "Earrings",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/jewelry/earrings.png",
    priceBDT: 600000,
    priceAED: 3000,
    colors: [
      Colors.amber,
      Colors.deepPurple,
      Colors.pink,
    ],
    category: "Jewelry",
    quantity: 1,
    id: '22',
  ),
  Product(
    title: "Jewelry-Box",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/jewelry/jewelry-box.png",
    priceBDT: 700000,
    priceAED: 335,
    colors: [
      Colors.pink,
      Colors.orange,
      Colors.redAccent,
    ],
    category: "Jewelry",
    quantity: 1,
    id: '23',
  ),
  Product(
    title: "Wedding Ring",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/jewelry/wedding ring.png",
    priceBDT: 656000,
    priceAED: 158,
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jewelry",
    quantity: 1,
    id: '24',
  ),
  Product(
    title: "Necklace-Jewellery",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/jewelry/necklace-jewellery.png",
    priceBDT: 645200,
    priceAED: 6540,
    colors: [
      Colors.blueAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "Jewellery",
    quantity: 1,
    id: '25',
  ),
];

final List<Product> menFashion = [
  Product(
    title: "Man Jacket",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/man jacket.png",
    priceBDT: 20000,
    priceAED: 80,
    colors: [
      Colors.brown,
      Colors.orange,
      Colors.blueGrey,
    ],
    category: "MenFashion",
    quantity: 1,
    id: '26',
  ),
  Product(
    title: "Men Pants",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/pants.png",
    priceBDT: 3000,
    priceAED: 45,
    colors: [
      Colors.black54,
      Colors.orange,
      Colors.green,
    ],
    category: "MenFashion",
    quantity: 1,
    id: '27',
  ),
  Product(
    title: "Men Shirt",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/shert.png",
    priceBDT: 4500,
    priceAED: 88,
    colors: [
      Colors.pink,
      Colors.amber,
      Colors.green,
    ],
    category: "menFashion",
    quantity: 1,
    id: '28',
  ),
  Product(
    title: "T-Shirt",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/t-shirt.png",
    priceBDT: 4900,
    priceAED: 99,
    colors: [
      Colors.brown,
      Colors.orange,
      Colors.blue,
    ],
    category: "MenFashion",
    quantity: 1,
    id: '29',
  ),
  Product(
    title: "Watch",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "images/men fashion/watch.png",
    priceBDT: 300000,
    priceAED: 823,
    colors: [
      Colors.lightBlue,
      Colors.orange,
      Colors.purple,
    ],
    category: "MenFashion",
    quantity: 1,
    id: '30',
  ),
];
