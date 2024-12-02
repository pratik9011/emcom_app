import 'package:flutter/material.dart';
import 'package:quickeats/config.dart';

class ProductSectionHorizontal extends StatelessWidget {
  const ProductSectionHorizontal({super.key,required this.title,this.isShowMore = false});
   final String title;
   final bool isShowMore;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextLine(title: title, fontSize: 17,isBold: true,color: Colors.black,),

        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){},
              child:isShowMore?const TextLine(title: "show_more", fontSize: 15,isBold: false,):const SizedBox()),

        ),
      ],
    );
  }
}
