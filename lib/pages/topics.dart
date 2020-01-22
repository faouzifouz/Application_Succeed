import 'package:flutter/material.dart';
import '../components/components.dart';

class TopicsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('topics'), backgroundColor: Colors.purple),

      bottomNavigationBar: AppBottomNav(),
    );
  }
}