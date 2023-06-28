import 'package:flutter/material.dart';

class IncrementDecrementButton extends StatefulWidget {
  @override
  _IncrementDecrementButtonState createState() => _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int _count = 0;
   int count = _IncrementDecrementButtonState()._count;
  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 50,
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _decrement,
            icon: Icon(Icons.remove),
          ),
          Text(
            '$_count',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: _increment,
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
