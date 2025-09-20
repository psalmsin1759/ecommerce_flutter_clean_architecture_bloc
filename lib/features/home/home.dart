import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/cart/presentation/pages/cart_home_widget.dart';
import 'package:julybyoma_app/features/home/drawer.dart';
import 'package:julybyoma_app/features/home/main_home.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = const [
    MainHomeWidget(),
    CartHomeWidget(),
    Center(child: Text("Orders Page", style: TextStyle(fontSize: 20))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        //final isDark = state.themeEntity?.themeType == ThemeType.dark;
        return Scaffold(
          key: _globalKey,
          drawer: DrawerWidget(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [Expanded(child: _pages[_selectedIndex])],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 8,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
