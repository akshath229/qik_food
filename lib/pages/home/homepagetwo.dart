import 'package:flutter/material.dart';
import 'package:qik_food/defaults/dimensions.dart';
import 'package:qik_food/pages/home/newfud_tile.dart';

class Firsthomepage extends StatefulWidget {
  const Firsthomepage({Key? key}) : super(key: key);

  @override
  State<Firsthomepage> createState() => _FirsthomepageState();
}

class _FirsthomepageState extends State<Firsthomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Container(
                child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text("Bangladesh",style: TextStyle(fontSize: Dimensions.font20)),
                        Text("city",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13 )),
                      ],
                    ),
                    ElevatedButton(onPressed: (){},
                      child: Icon(Icons.search_rounded,color: Colors.white,size: Dimensions.iconsize),
                     style: ElevatedButton.styleFrom(minimumSize: Size(Dimensions.buttonwidth50, Dimensions.buttonheight55),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.buttonborder),
                      ),
                    ),
                     ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(child: Newfoodsslide())),
        ],
      ),
    );
  }
}
