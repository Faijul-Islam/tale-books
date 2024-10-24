import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.name,
    required this.image, required this.price,
    required this.dis}) : super(key: key);
final String name;
final String image;
final String dis;
final String price;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 2.r,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image,
            fit: BoxFit.fitWidth,
              height: 150.h,
              width: 200.w,
            ),
            Text("Name: $name"),
            Text("Price: $price"),
            Text("Dis%:$dis"),
          ],
        ),
      ),
    );
  }
}
