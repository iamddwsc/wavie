import 'package:flutter/material.dart';
import 'package:wavie/presentation/tab_navigator.dart';
import '../common/appcolors.dart' as appcolors;

class WavieApp extends StatefulWidget {
  const WavieApp({Key? key}) : super(key: key);

  @override
  State<WavieApp> createState() => _WavieAppState();
}

class _WavieAppState extends State<WavieApp>
    with SingleTickerProviderStateMixin {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (index != 1) {
      // _navigatorKeys["Page2"]!.currentState!.pushReplacement(MaterialPageRoute(
      //     maintainState: false, builder: (context) => SearchPage()));
      _navigatorKeys["Page2"]!.currentState!.maybePop();
    }
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
            if (isFirstRouteInCurrentTab) {
              if (_currentPage != "Page1") {
                _selectTab("Page1", 1);
                return false;
              }
            }
            // let system handle back button if we're on the first route
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              body: Container(
                color: appcolors.background,
                child: Stack(
                  children: [
                    _buildOffstageNavigator("Page1"),
                    _buildOffstageNavigator("Page2"),
                    _buildOffstageNavigator("Page3"),
                    _buildOffstageNavigator("Page4"),
                    _buildOffstageNavigator("Page5"),
                    // Positioned(
                    //     left: 20.0,
                    //     top: 10.0,
                    //     child: Image.asset(
                    //       'assets/images/logo_w.png',
                    //       fit: BoxFit.fitHeight,
                    //       height: 32.0,
                    //       isAntiAlias: true,
                    //     )),
                    // Positioned(
                    //   right: 20.0,
                    //   top: 5.0,
                    //   child: Container(
                    //     margin: EdgeInsets.all(5.0),
                    //     child: CircleAvatar(
                    //       radius: 20.0,
                    //       child: Icon(Icons.person),
                    //       //maxRadius: 25.0,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 70.0,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Container(
                    //     padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Container(
                    //           child: Text('TV Shows',
                    //               style: TextStyle(color: appcolors.white)),
                    //         ),
                    //         Container(
                    //           child: Text('Movies',
                    //               style: TextStyle(color: appcolors.white)),
                    //         ),
                    //         Container(
                    //           child: Text('Categories',
                    //               style: TextStyle(color: appcolors.white)),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //   colors: [
                //     Colors.white.withOpacity(0.4),
                //     Colors.blue[200]!,
                //     //Colors.black.withOpacity(1.0)
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   stops: [0.0, 1.0],
                //   tileMode: TileMode.decal,
                // )),
                // color: Colors.black.withOpacity(0.8),
                child: BottomNavigationBar(
                  elevation: 0.0,
                  backgroundColor: Color(0x35000000),
                  selectedItemColor: appcolors.white,
                  unselectedItemColor: appcolors.sliverBackground,
                  // selectedLabelStyle: TextStyle(
                  //     fontFamily: 'Gotham',
                  //     color: AppColors.white,
                  //     fontWeight: FontWeight.w600),
                  onTap: (int index) {
                    _selectTab(pageKeys[index], index);
                  },
                  currentIndex: _selectedIndex,
                  items: navItem,
                  type: BottomNavigationBarType.fixed,
                ),
              ))),
    );
  }

  List<BottomNavigationBarItem> get navItem {
    return [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Discover',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.download_for_offline_outlined,
        ),
        label: 'Downloads',
      ),
    ];
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
