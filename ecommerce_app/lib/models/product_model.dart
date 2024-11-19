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
    description: "IMMERSIVE SOUND, WIRELESS FREEDOM.\n"
        "Experience high-quality audio without the hassle of wires with our Premium Wireless Headphones. Designed for comfort and performance, these headphones deliver deep bass and crystal-clear sound for a truly immersive listening experience. "
        "With up to 20 hours of battery life, you'll enjoy non-stop music, gaming, or calls throughout the day. Equipped with Bluetooth 5.0 technology, it ensures a seamless connection to your devices.\n\n"
        "Details:\n"
        "- Connectivity: Bluetooth 5.0\n"
        "- Battery life: Up to 20 hours\n"
        "- Charging time: 2 hours\n"
        "- Noise-cancellation: Active\n"
        "- Product color: Black",
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
    description: "STAY WARM AND STYLISH.\n"
        "This Cozy Knit Women's Sweater is perfect for chilly days. Made from soft, breathable fabric, it features a relaxed fit and classic knit design for all-day comfort. "
        "The timeless style allows it to be paired with jeans or leggings for a casual yet chic look, making it a versatile addition to your wardrobe.\n\n"
        "Details:\n"
        "- Material: 60% cotton, 40% acrylic\n"
        "- Fit: Relaxed\n"
        "- Neckline: Round\n"
        "- Sleeves: Long\n"
        "- Product color: Beige",
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
    description: "YOUR ULTIMATE FITNESS AND LIFESTYLE COMPANION.\n"
        "The Advanced Fitness Smart Watch is designed to keep you connected and on track with your health goals. Featuring heart rate monitoring, GPS tracking, and a variety of fitness modes, this watch is the perfect partner for your active lifestyle. "
        "Stay connected with notifications, and track your daily activity with ease. Its sleek, water-resistant design ensures you can wear it anywhere, from the gym to the office.\n\n"
        "Details:\n"
        "- Display: 1.4-inch AMOLED touchscreen\n"
        "- Battery life: Up to 10 days\n"
        "- Features: Heart rate monitor, GPS, sleep tracking\n"
        "- Water-resistance: 5ATM\n"
        "- Product color: Black",
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
    description: "RUGGED STYLE WITH A MODERN EDGE.\n"
        "This Leather Biker Jacket offers a tough yet stylish look with its premium leather construction and sharp details. Perfect for adding a rebellious touch to any outfit, it features zippered pockets and a comfortable fit that pairs well with jeans or casual wear. "
        "Designed to stand the test of time, it’s a wardrobe must-have for any fashion-forward individual.\n\n"
        "Details:\n"
        "- Material: 100% leather\n"
        "- Lining: Polyester\n"
        "- Zipper closure\n"
        "- Pockets: 4 zippered\n"
        "- Product color: Black",
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
    description: "TIMELESS STYLE AND PRECISION.\n"
        "This Luxury Analog Watch combines classic design with precise craftsmanship, offering elegance and durability for any occasion. "
        "The watch features a stainless steel case, a scratch-resistant sapphire crystal, and a high-quality leather strap for a refined look. Whether worn with formal or casual attire, this watch adds a sophisticated touch to your wardrobe.\n\n"
        "Details:\n"
        "- Movement: Quartz\n"
        "- Case material: Stainless steel\n"
        "- Strap: Genuine leather\n"
        "- Water resistance: 50 meters\n"
        "- Product color: Silver/Brown",
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "A SCENT THAT CAPTIVATES.\n"
        "Our Luxury Eau de Parfum combines floral, fruity, and woody notes to create a captivating fragrance that lingers all day. Designed for those who appreciate fine scents, it strikes the perfect balance between sensuality and freshness. "
        "Encased in a sleek glass bottle, it's a stylish addition to any fragrance collection. Ideal for day or night wear, it leaves a lasting impression wherever you go.\n\n"
        "Details:\n"
        "- Fragrance type: Eau de Parfum\n"
        "- Top notes: Bergamot, Pear\n"
        "- Heart notes: Jasmine, Rose\n"
        "- Base notes: Amber, Sandalwood\n"
        "- Volume: 100ml\n"
        "- Product color: Clear",
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
    description: "A SYMBOL OF ETERNAL LOVE.\n"
        "This Classic Diamond Wedding Ring features a brilliant-cut diamond set in a sleek, polished band. Crafted with precision, this ring is designed to reflect the timeless bond of marriage. "
        "Its understated elegance makes it the perfect symbol of commitment, ideal for both men and women. "
        "Whether worn daily or reserved for special occasions, this wedding ring stands out with its stunning simplicity and enduring quality.\n\n"
        "Details:\n"
        "- Material: 18K white gold\n"
        "- Stone: 0.5 carat brilliant-cut diamond\n"
        "- Band width: 2.5mm\n"
        "- Weight: 4g\n"
        "- Product color: White Gold",
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
    description: "VERSATILE AND COMFORTABLE.\n"
        "Our Slim Fit Chinos provide the perfect combination of style and comfort. Tailored from premium cotton, these pants feature a slim silhouette that enhances your look, whether you're at the office or out for a casual evening. "
        "The added stretch ensures freedom of movement while maintaining a polished appearance.\n\n"
        "Details:\n"
        "- Fit: Slim\n"
        "- Material: 98% cotton, 2% elastane\n"
        "- Pockets: 4 (2 side, 2 back)\n"
        "- Waistband: Mid-rise\n"
        "- Product color: Navy",
    image: "images/women fashion/pants.png",
    priceBDT: 12000,
    priceAED: 155,
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.blueAccent,
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "BASKETBALL SHOES FOR ALL-GAME COMFORT.\n"
        "Own the court with adidas' latest release of the Ownthegame 2.0. The versatile cut allows for all-day wear on and off the hardwood. "
        "Show off the bold 3-Stripe branding as you make your way up and down the court. A lightweight yet responsive Lightmotion midsole keeps you on your toes for quick cuts and crossovers. "
        "The dual-mesh upper provides breathability for intense play. A molded heel clip locks you in for hard-fought possessions in the paint. Traditional tongue construction offers familiar comfort. "
        "The Adiwear outsole withstands the pounding of countless pick-up games and practice sessions alike. From pre-game warmups to the final buzzer, the Ownthegame 2.0 delivers performance and style worthy of the big leagues.\n\n"
        "This product features at least 20% recycled materials. By reusing materials that have already been created, we help to reduce waste and our reliance on finite resources and reduce the footprint of the products we make.\n\n"
        "Details:\n"
        "- Regular fit\n"
        "- Lace closure\n"
        "- Dual-material mesh upper\n"
        "- Textile lining\n"
        "- Molded TPU lockdown heel\n"
        "- Lightmotion cushioning\n"
        "- Weight: 331 g (size UK 8.5)\n"
        "- Adiwear outsole\n"
        "- Product color: Core Black",
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
    description: "A SCENT THAT CAPTIVATES.\n"
        "Our Luxury Eau de Parfum combines floral, fruity, and woody notes to create a captivating fragrance that lingers all day. Designed for those who appreciate fine scents, it strikes the perfect balance between sensuality and freshness. "
        "Encased in a sleek glass bottle, it's a stylish addition to any fragrance collection. Ideal for day or night wear, it leaves a lasting impression wherever you go.\n\n"
        "Details:\n"
        "- Fragrance type: Eau de Parfum\n"
        "- Top notes: Bergamot, Pear\n"
        "- Heart notes: Jasmine, Rose\n"
        "- Base notes: Amber, Sandalwood\n"
        "- Volume: 100ml\n"
        "- Product color: Clear",
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
    description: "A SCENT THAT CAPTIVATES.\n"
        "Our Luxury Eau de Parfum combines floral, fruity, and woody notes to create a captivating fragrance that lingers all day. Designed for those who appreciate fine scents, it strikes the perfect balance between sensuality and freshness. "
        "Encased in a sleek glass bottle, it's a stylish addition to any fragrance collection. Ideal for day or night wear, it leaves a lasting impression wherever you go.\n\n"
        "Details:\n"
        "- Fragrance type: Eau de Parfum\n"
        "- Top notes: Bergamot, Pear\n"
        "- Heart notes: Jasmine, Rose\n"
        "- Base notes: Amber, Sandalwood\n"
        "- Volume: 100ml\n"
        "- Product color: Clear",
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
    description: "NOURISH AND REVITALIZE YOUR SKIN.\n"
        "Our Hydrating Face Cream is formulated to deeply nourish and moisturize your skin, leaving it soft, smooth, and radiant. Enriched with natural ingredients, this cream helps to restore the skin’s natural moisture barrier, providing long-lasting hydration. "
        "Suitable for all skin types, it's a daily essential for maintaining healthy, glowing skin.\n\n"
        "Details:\n"
        "- Skin type: All\n"
        "- Key ingredients: Aloe Vera, Vitamin E\n"
        "- Application: Day and night\n"
        "- Volume: 50ml\n"
        "- Product color: White",
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
    description: "VERSATILE AND COMFORTABLE.\n"
        "Our Slim Fit Chinos provide the perfect combination of style and comfort. Tailored from premium cotton, these pants feature a slim silhouette that enhances your look, whether you're at the office or out for a casual evening. "
        "The added stretch ensures freedom of movement while maintaining a polished appearance.\n\n"
        "Details:\n"
        "- Fit: Slim\n"
        "- Material: 98% cotton, 2% elastane\n"
        "- Pockets: 4 (2 side, 2 back)\n"
        "- Waistband: Mid-rise\n"
        "- Product color: Navy",
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
    description: "RUGGED STYLE WITH A MODERN EDGE.\n"
        "This Leather Biker Jacket offers a tough yet stylish look with its premium leather construction and sharp details. Perfect for adding a rebellious touch to any outfit, it features zippered pockets and a comfortable fit that pairs well with jeans or casual wear. "
        "Designed to stand the test of time, it’s a wardrobe must-have for any fashion-forward individual.\n\n"
        "Details:\n"
        "- Material: 100% leather\n"
        "- Lining: Polyester\n"
        "- Zipper closure\n"
        "- Pockets: 4 zippered\n"
        "- Product color: Black",
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
    description: "CASUAL STYLE WITH A BOLD STATEMENT.\n"
        "Our Graphic T-Shirt is designed for those who want to stand out. Featuring bold prints and soft cotton fabric, it offers both comfort and style. "
        "Pair it with jeans or shorts for an effortless casual look that suits any occasion.\n\n"
        "Details:\n"
        "- Fit: Regular\n"
        "- Material: 100% cotton\n"
        "- Neckline: Crew\n"
        "- Sleeves: Short\n"
        "- Product color: Black/White",
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
    description: "VERSATILE AND COMFORTABLE.\n"
        "Our Slim Fit Chinos provide the perfect combination of style and comfort. Tailored from premium cotton, these pants feature a slim silhouette that enhances your look, whether you're at the office or out for a casual evening. "
        "The added stretch ensures freedom of movement while maintaining a polished appearance.\n\n"
        "Details:\n"
        "- Fit: Slim\n"
        "- Material: 98% cotton, 2% elastane\n"
        "- Pockets: 4 (2 side, 2 back)\n"
        "- Waistband: Mid-rise\n"
        "- Product color: Navy",
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
    description: "CLASSIC ELEGANCE FOR EVERY OCCASION.\n"
        "These Elegant Pearl Earrings feature lustrous pearls set in gold-plated settings, perfect for adding a touch of sophistication to any outfit. "
        "Whether worn with formal attire or to elevate a casual look, these timeless earrings are a versatile accessory for any jewelry collection.\n\n"
        "Details:\n"
        "- Material: 18K gold-plated\n"
        "- Pearl size: 8mm\n"
        "- Closure: Push-back\n"
        "- Product color: Gold/White",
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
    description: "KEEP YOUR TREASURES SAFE IN STYLE.\n"
        "Our Luxury Wooden Jewelry Box is crafted from premium wood and lined with soft velvet to keep your valuable jewelry safe and organized. Featuring multiple compartments, it provides ample space for rings, earrings, necklaces, and more. "
        "The elegant design makes it not just functional, but a beautiful display piece for your dresser or vanity.\n\n"
        "Details:\n"
        "- Material: Premium wood with velvet lining\n"
        "- Compartments: 6 slots and 2 drawers\n"
        "- Lock: Metal clasp lock\n"
        "- Dimensions: 25cm x 18cm x 10cm\n"
        "- Product color: Dark Brown",
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
    description: "A SYMBOL OF ETERNAL LOVE.\n"
        "This Classic Diamond Wedding Ring features a brilliant-cut diamond set in a sleek, polished band. Crafted with precision, this ring is designed to reflect the timeless bond of marriage. "
        "Its understated elegance makes it the perfect symbol of commitment, ideal for both men and women. "
        "Whether worn daily or reserved for special occasions, this wedding ring stands out with its stunning simplicity and enduring quality.\n\n"
        "Details:\n"
        "- Material: 18K white gold\n"
        "- Stone: 0.5 carat brilliant-cut diamond\n"
        "- Band width: 2.5mm\n"
        "- Weight: 4g\n"
        "- Product color: White Gold",
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
    description: "CRAFTED FOR SOPHISTICATED CHARM.\n"
        "This Elegant Gold Necklace adds a touch of luxury to any outfit. Handcrafted with precision, it features a delicate chain and a stunning centerpiece that radiates timeless beauty. "
        "Perfect for special occasions or daily wear, this necklace complements both casual and formal attire. Its lightweight design ensures comfort while exuding elegance and class.\n\n"
        "Details:\n"
        "- Material: 18K gold-plated\n"
        "- Chain length: 45cm\n"
        "- Pendant size: 1.5cm diameter\n"
        "- Weight: 5g\n"
        "- Clasp: Lobster clasp\n"
        "- Product color: Gold",
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
    description: "RUGGED STYLE WITH A MODERN EDGE.\n"
        "This Leather Biker Jacket offers a tough yet stylish look with its premium leather construction and sharp details. Perfect for adding a rebellious touch to any outfit, it features zippered pockets and a comfortable fit that pairs well with jeans or casual wear. "
        "Designed to stand the test of time, it’s a wardrobe must-have for any fashion-forward individual.\n\n"
        "Details:\n"
        "- Material: 100% leather\n"
        "- Lining: Polyester\n"
        "- Zipper closure\n"
        "- Pockets: 4 zippered\n"
        "- Product color: Black",
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
    description: "VERSATILE AND COMFORTABLE.\n"
        "Our Slim Fit Chinos provide the perfect combination of style and comfort. Tailored from premium cotton, these pants feature a slim silhouette that enhances your look, whether you're at the office or out for a casual evening. "
        "The added stretch ensures freedom of movement while maintaining a polished appearance.\n\n"
        "Details:\n"
        "- Fit: Slim\n"
        "- Material: 98% cotton, 2% elastane\n"
        "- Pockets: 4 (2 side, 2 back)\n"
        "- Waistband: Mid-rise\n"
        "- Product color: Navy",
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
    description: "A CLASSIC WARDROBE STAPLE.\n"
        "This Classic Button-Down Shirt is designed for men who value both comfort and style. Made from high-quality cotton, it features a regular fit that’s perfect for everyday wear or special occasions. "
        "Pair it with chinos for a polished look or wear it with jeans for a relaxed weekend outfit.\n\n"
        "Details:\n"
        "- Fit: Regular\n"
        "- Material: 100% cotton\n"
        "- Collar: Spread\n"
        "- Sleeves: Long\n"
        "- Product color: White",
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
    description: "CASUAL STYLE WITH A BOLD STATEMENT.\n"
        "Our Graphic T-Shirt is designed for those who want to stand out. Featuring bold prints and soft cotton fabric, it offers both comfort and style. "
        "Pair it with jeans or shorts for an effortless casual look that suits any occasion.\n\n"
        "Details:\n"
        "- Fit: Regular\n"
        "- Material: 100% cotton\n"
        "- Neckline: Crew\n"
        "- Sleeves: Short\n"
        "- Product color: Black/White",
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
    description: "TIMELESS ELEGANCE WITH A MODERN TOUCH.\n"
        "Experience the perfect blend of classic design and modern technology with our Classic Leather Watch. Featuring a sleek stainless steel case and a genuine leather strap, this watch is the ideal companion for both formal and casual settings. "
        "The minimalistic dial design ensures easy readability while maintaining a sophisticated look. Powered by a precise quartz movement, this watch guarantees accurate timekeeping. "
        "Water-resistant up to 50 meters, it's ready to accompany you through any occasion—whether it's a business meeting or an evening out.\n\n"
        "Details:\n"
        "- Case material: Stainless steel\n"
        "- Strap material: Genuine leather\n"
        "- Movement: Quartz\n"
        "- Water resistance: 50 meters\n"
        "- Dial size: 40mm\n"
        "- Strap width: 20mm\n"
        "- Buckle: Pin buckle\n"
        "- Product color: Brown/Gold\n\n\n\n\n\n\n",
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

final List<Product> groceries = [
  // Product(id: id, title: title, description: description, image: image, priceBDT: priceBDT, priceAED: priceAED, colors: colors, category: category, quantity: quantity)
];
