

import 'package:flutter/material.dart';
import 'package:qik_food/defaults/dimensions.dart';

class Appcolumn extends StatelessWidget {
  final String text;
  double size;
  Appcolumn({Key? key,required this.text,this.size=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: size), ),
        SizedBox(height: Dimensions.height5),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star,color: Colors.teal,size: Dimensions.font17,)),
            ),
            Text("4.5",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13 )),
            SizedBox(width: Dimensions.width20,),
            Text("1287 comments",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.fast_forward_outlined,color: Colors.red),
            Text("Fast delivery",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),

            Icon(Icons.location_on,color: Colors.tealAccent),
            Text("1.7 KM",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),

            Icon(Icons.access_time_rounded,color: Colors.orange.shade900),
            Text("32 min",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),
          ],
        ),
      ],
    );
  }
}
