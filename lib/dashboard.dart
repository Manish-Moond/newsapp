import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/account_page.dart';
import 'package:newsapp/screens/chat_page.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/screens/home_page.dart';
import 'package:newsapp/screens/saved_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentIndex = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _tabController.index = _currentIndex;
    });
  }

  final List<Widget> _screen = [
    const Center(child: HomePage()),
    const SavedPage(),
    const ChatPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width < 750;
    return Scaffold(
      bottomNavigationBar: isMobile(context)
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 0
                        ? FluentIcons.home_16_filled
                        : FluentIcons.home_16_regular,
                    color: _currentIndex == 0 ? kPrimaryColor : kGreyColor,
                  ),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 1
                        ? FluentIcons.heart_16_filled
                        : FluentIcons.heart_16_regular,
                    color: _currentIndex == 1 ? kPrimaryColor : kGreyColor,
                  ),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 2
                        ? FluentIcons.chat_16_filled
                        : FluentIcons.chat_16_regular,
                    color: _currentIndex == 2 ? kPrimaryColor : kGreyColor,
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 3
                        ? FluentIcons.person_16_filled
                        : FluentIcons.person_16_regular,
                    color: _currentIndex == 3 ? kPrimaryColor : kGreyColor,
                  ),
                  label: 'Account',
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (!isMobile(context))
            NavigationRail(
                selectedIndex: _currentIndex,
                onDestinationSelected: _onTabTapped,
                labelType: NavigationRailLabelType.all,
                leading: const SizedBox(height: 70),
                elevation: 2,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(
                      _currentIndex == 0
                          ? FluentIcons.home_16_filled
                          : FluentIcons.home_16_regular,
                      color: _currentIndex == 0 ? kPrimaryColor : kGreyColor,
                    ),
                    label: const Text("Feed"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      _currentIndex == 1
                          ? FluentIcons.heart_16_filled
                          : FluentIcons.heart_16_regular,
                      color: _currentIndex == 1 ? kPrimaryColor : kGreyColor,
                    ),
                    label: const Text("Saved"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      _currentIndex == 2
                          ? FluentIcons.chat_16_filled
                          : FluentIcons.chat_16_regular,
                      color: _currentIndex == 2 ? kPrimaryColor : kGreyColor,
                    ),
                    label: const Text("Chat"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      _currentIndex == 3
                          ? FluentIcons.person_16_filled
                          : FluentIcons.person_16_regular,
                      color: _currentIndex == 3 ? kPrimaryColor : kGreyColor,
                    ),
                    label: const Text("Account"),
                  ),
                ]),
          Expanded(child: _screen[_currentIndex]),
        ],
      ),
    );
  }
}
