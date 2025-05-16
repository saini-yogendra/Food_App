import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Core/Provider/favorite_provider.dart';
import 'package:foodapp/Core/models/product_model.dart';
import 'package:foodapp/Core/utils/consts.dart';
import 'package:foodapp/Screen/food_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsItemsDispaly extends ConsumerWidget {
  final FoodModel foodModel;
  const ProductsItemsDispaly({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context,WidgetRef ref)  {



    final provider = ref.watch(favoriteProvider);
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;



    // final provider = ref.watch(favoriteProvider);
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder:
                (_, __, ___) => FoodDetailScreen(product: foodModel),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            child: Container(
              height: 210,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top:  30,
            right: 10,
            child: GestureDetector(
              onTap: (){
                ref.read(favoriteProvider).toggleFavorite(foodModel.name);
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor:
                provider.isExist(foodModel.name)
                ? Colors.red[100]
                    :Colors.transparent,
                child: provider.isExist(foodModel.name)?
                Image.asset("assets/images/fire.png",
                  height: 22,
                ):Icon(Icons.local_fire_department,color: red,)
              ),
            ),
          ),
          Container(
            width: size.width *0.5,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: foodModel.imageCard,
                  child: Image.network(
                    foodModel.imageCard,
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),



                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    foodModel.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth < 350
                          ? 14
                          : screenWidth < 600
                          ? 16
                          : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  foodModel.specialItems,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth < 350
                        ? 12
                        : screenWidth < 600
                        ? 13
                        : 15,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),





                // Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: Text(
                //     foodModel.name,
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                // Text(
                //   foodModel.specialItems,
                //   style: TextStyle(
                //     height: 0.1,
                //     letterSpacing: 0.5,
                //     fontSize: 15,
                //     color: Colors.black
                //   ),
                // ),
                SizedBox(height: 30,),
                RichText(text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "\$",
                      style: TextStyle(fontSize: 14,color: red)
                    ),
                    TextSpan(
                      text: "${foodModel.price}",
                      style: TextStyle(fontSize: 25,color: Colors.black)
                    )
                  ]
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
