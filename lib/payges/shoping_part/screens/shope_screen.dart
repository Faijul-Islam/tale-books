import 'package:flutter/material.dart';
import 'package:tale_book/common_widget/commn_textfield.dart';
import 'package:tale_book/payges/shoping_part/components/item_card.dart';

import '../../../common_widget/text_styles.dart';

class ShoppeScreen extends StatefulWidget {
  const ShoppeScreen({super.key});

  @override
  State<ShoppeScreen> createState() => _ShoppeScreenState();
}

class _ShoppeScreenState extends State<ShoppeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1B3D79),
        title:  Text("Shoppe Page",
        style: CustomTextStyles.boldText(22,color:Colors.white),),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("data"),
              Text("data"),
            ],
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ItemCard(
                        name: "Poultry",
                        image: "https://www.myerspoultry.com/files/products/30/images/thumb/thumb_Cornish-Product-Category.jpg",
                        price: "180",
                        dis: "10%");
                  }))
        ],
      ),
    );
  }
}
