//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:foodapp/Core/models/product_model.dart';
// import 'package:foodapp/Widgets/products_items_dispaly.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class ViewAllProductScreen extends StatefulWidget {
//   const ViewAllProductScreen({super.key});
//
//   @override
//   State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
// }
//
// class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
//   final supabase = Supabase.instance.client;
//   List<FoodModel> products = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFoodProduct();
//   }
//
//   Future<void> fetchFoodProduct() async {
//     try {
//       final response =
//           await Supabase.instance.client.from("food_product").select();
//       final data = response as List;
//
//       setState(() {
//         products = data.map((json) => FoodModel.fromJson(json)).toList();
//         isLoading = false;
//       });
//     } catch (error) {
//       print("Error detching Products: $error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       appBar: AppBar(
//         title: Text("All Products"),
//         backgroundColor: Colors.blue[50],
//         forceMaterialTransparency: true,
//         centerTitle: true,
//       ),
//       body:
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : GridView.builder(
//             itemCount: products.length,
//                 padding: EdgeInsets.all(10),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.59,
//                   crossAxisSpacing: 8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return ProductsItemsDispaly(foodModel: products[index]);
//                 },
//               ),
//     );
//   }
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Core/models/product_model.dart';
import 'package:foodapp/Widgets/products_items_dispaly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFoodProduct();
  }

  Future<void> fetchFoodProduct() async {
    try {
      final response =
      await Supabase.instance.client.from("food_product").select();
      final data = response as List;

      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching Products: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust grid based on screen size
    int crossAxisCount = screenWidth > 600 ? 3 : 2; // 3 columns for larger screens
    double aspectRatio = screenWidth > 600 ? 0.6 : 0.59; // Adjust aspect ratio for larger screens
    double padding = screenWidth > 600 ? 20 : 10; // More padding for larger screens

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.blue[50],
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.all(padding),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return ProductsItemsDispaly(foodModel: products[index]);
        },
      ),
    );
  }
}
