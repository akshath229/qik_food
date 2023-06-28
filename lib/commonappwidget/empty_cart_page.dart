
import 'package:flutter/material.dart';

class NodataPage extends StatelessWidget {
  final String imgpath;
  const NodataPage({Key? key,this.imgpath="lib/images/emptycart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgpath,height: MediaQuery.of(context).size.height*0.22,
        width: MediaQuery.of(context).size.width*0.22,
        ),
      ],
    );
  }
}
