import 'package:flutter/material.dart';
import 'package:recipe/profile.dart';
import 'package:recipe/recipe.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _Recipehome();
}

class _Recipehome extends State<Homepage> {
  int _selectedIndex = 0;

  void _onitemtap(int index) {
    _selectedIndex = index;

    setState(() {});
  }

  final List<Widget> _pages = [HomepageContent(), Recipe(), Profile()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade400,
          title: Text(
            'RecipeX',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _onitemtap(value);
          },
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.orange.shade400,
          selectedLabelStyle: TextStyle(
            height: 2,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Recipes'),

            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}

class HomepageContent extends StatelessWidget {
  TextEditingController searchcontroller = TextEditingController();

  final List<Map<String, String>> horipics = [
    {
      'img': "assets/a2.jpg",
      'name': 'Biryani',
      'time': '1 hr 15 min',
      'subtitle': 'Aromatic rice and spiced meat',
    },
    {
      'img': "assets/beefkorma.jpg",
      'name': 'Beef Korma',
      'time': '2 hrs',
      'subtitle': 'Rich, creamy and flavorful curry',
    },
    {
      'img': "assets/chicken.jpeg",
      'name': 'Chicken',
      'time': '45 min',
      'subtitle': 'Juicy and tender grilled chicken',
    },
    {
      'img': "assets/creamy pasta salad.jpg",
      'name': 'Creamy Pasta Salad',
      'time': '25 min',
      'subtitle': 'Fresh veggies tossed with creamy dressing',
    },
    {
      'img': "assets/kheer.jpg",
      'name': 'Kheer',
      'time': '1 hr',
      'subtitle': 'Sweet rice pudding with cardamom',
    },
    {
      'img': "assets/mutton cury.jpg",
      'name': 'Mutton Curry',
      'time': '2 hrs 30 min',
      'subtitle': 'Slow-cooked spicy and tender mutton',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
         Center(
           child: Text('Your kitchen’s new best friend!', style: TextStyle(
            fontSize: 24,
            color: Colors.orange.shade400,
            fontWeight: FontWeight.w600
           ),),
         ),
          SizedBox(height: 20),
          Card(
            elevation: 8,
            shadowColor: Colors.orange.shade200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/main.jpg',
                width: 340,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Latest Recipes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade400,

            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 280,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: horipics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.orange.shade400,
                    child: Container(
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              horipics[index]['img'] ?? '',

                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            horipics[index]['name'] ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Center(
                            child: Text(
                              horipics[index]['time'] ?? '',
                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            horipics[index]['subtitle'] ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
