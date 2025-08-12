import 'package:flutter/material.dart';

class RecipeDetails extends StatefulWidget {
  final String img;
  final String title;
  final List<String> ingredients;
  final List<String> steps;
  final String time;

  RecipeDetails({
    required this.img,
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.time,
  });

  @override
  State<RecipeDetails> createState() => _RecipeDetails();
}

class _RecipeDetails extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, bld) {
            return [
              SliverAppBar.large(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: SafeArea(
                    child: Column(
                      children: [
                        Text(
                          '${widget.title}\n ${widget.time}',
                          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  background: Image.asset(widget.img, fit: BoxFit.cover),
                ),
                backgroundColor: Colors.orange.shade400,
                bottom: TabBar(
                  indicatorColor: Colors.black,
                  dividerColor: Colors.orange.shade400,
                  dividerHeight: 4,
                  unselectedLabelColor: Color(0xFF9E9E9E),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                        color: Colors.orange.shade400,
                      ),
                      child: Tab(text: 'Ingredients'),
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.orange.shade400,
                      ),
                      child: Tab(text: 'Instructions'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: widget.ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.orange.shade400,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      widget.ingredients[index],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: widget.steps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.orange.shade400,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      widget.steps[index],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
