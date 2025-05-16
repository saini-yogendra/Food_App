import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/Core/models/product_model.dart';
import 'package:foodapp/Core/utils/consts.dart';
import 'package:foodapp/Screen/view_all_product_screen.dart';
import 'package:foodapp/Widgets/products_items_dispaly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Core/models/categories.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  late Future<List<FoodModel>> futureFoodProducts = Future.value([]);

  List<CategoryModel> categories = [];
  String? selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        print("Default Category: ${categories.first.name}");
        setState(() {
          this.categories = categories;
          selectedCategory = categories.first.name;
// Capitalize first letter
          selectedCategory = '${selectedCategory![0].toUpperCase()}${selectedCategory!.substring(1)}';
          futureFoodProducts = fetchFoodProduct(selectedCategory!);
          // selectedCategory = categories.first.name;
          // futureFoodProducts = fetchFoodProduct(selectedCategory!);
          // fetch food products
        });
      }
    } catch (error) {
      print("Initialization error: $error");
    }
  }

  // to fetch products data from supabase
  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final response = await Supabase.instance.client
          .from("food_product")
          .select()
          .eq("category", category);
      print("Fetched Products: $response"); //supabase table name

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (error) {
      print("Error fetching Products: $error");
      return [];
    }
  }

  // to fetch category data from supabase
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response =
          await Supabase.instance.client
              .from("category_items")
              .select(); //supabase table name

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (error) {
      print("Error fetching categories: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarPart(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: imageBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "The Fastest In Delivery ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Food",
                                      style: TextStyle(color: red),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 9,
                                ),
                                child: Text(
                                  "Order Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("assets/images/courier.png"),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildCategoryList(),
            // display products with it's respective category
            SizedBox(height: 30),
            viewAll(),
            SizedBox(height: 30),
            _buildProductSection(),
          ],
        ),
      ),
    );
  }




  Widget _buildProductSection() {
    return SizedBox(
      height: 260, // Height according to your card height
      child: FutureBuilder<List<FoodModel>>(
        future: futureFoodProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return Center(child: Text("No products found"));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 25 : 0,
                  right: index == products.length - 1 ? 25 : 0,
                ),
                child: ProductsItemsDispaly(foodModel: products[index]),
              );
            },
          );
        },
      ),
    );
  }

  // Widget _buildProductSection() {
  //   return Expanded(
  //     child: FutureBuilder<List<FoodModel>>(
  //       future: futureFoodProducts,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         if (snapshot.hasError) {
  //           return Center(child: Text("Error: ${snapshot.error}"));
  //         }
  //         final products = snapshot.data ?? [];
  //         if (products.isEmpty) {
  //           return Center(child: Text("No products found"));
  //         }
  //         return ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: products.length,
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: EdgeInsets.only(
  //                 left: index == 0 ? 25 : 0,
  //                 right: index == products.length - 1 ? 25 : 0,
  //               ),
  //               child: ProductsItemsDispaly(foodModel: products[index]),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Padding viewAll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular Now",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ViewAllProductScreen()),
              );
            },
            child: Row(
              children: [
                Text("View All", style: TextStyle(color: orange)),
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appbarPart() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/images/dash.png"),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 18, color: red),
            SizedBox(width: 5),
            Text(
              "Alwar, Rajasthan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: orange),
            SizedBox(width: 5),
          ],
        ),
        Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/images/man.png"),
        ),
        SizedBox(width: 25),
      ],
    );
  }

  Widget _buildCategoryList() {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink();
        }
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () => handelCategoryTab(category.name),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == category.name ? red : grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            category.image,
                            width: 20,
                            height: 20,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.fastfood),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          category.name,
                          style: TextStyle(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handelCategoryTab(String category) {
    print("Tapped category: $category");
    print("Selected Category: $category");
    if (selectedCategory == category) return;
    setState(() {
      selectedCategory = category;
      // fetch food products
      futureFoodProducts = fetchFoodProduct(category);
    });
  }
}
