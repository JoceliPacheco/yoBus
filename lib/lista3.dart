import 'package:flutter/material.dart';

class Lista3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            floating: true,
            backgroundColor: Colors.blue,
            pinned: true,
            expandedHeight: 250.0,
            elevation: 0.0,
            leading: IconButton(icon: Icon(Icons.home), onPressed: null),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('yoBus'),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(' $index'),
                      subtitle: Text('List Item $index'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
