import 'package:flutter/material.dart';
import '../widgets/greeting_bar.dart';
import '../widgets/search_field.dart';
import '../widgets/category_row.dart';
import '../widgets/intake_board.dart';
import '../widgets/featured_list.dart';
import '../../../../core/themes/theme.dart';
import 'profile_page.dart';
import 'plan_page.dart';          
import 'analytics_page.dart';    
import '../../../chatbot/presentation/chatbot_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _idx = 0;
  final _pages = const [
     _HomeBody(), 
     PlanPage(),
     ChatbotPage(),
     AnalyticsPage(),
     ProfilePage(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo2.webp', height: 34),
        centerTitle: true,
      ),
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black45,
        onTap: (i) => setState(() => _idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),   label: 'Home'),
          BottomNavigationBarItem(                 
              icon: Icon(Icons.calendar_month), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.chat),   label: 'Chatbot'),
          BottomNavigationBarItem(              
              icon: Icon(Icons.bar_chart), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.person),   label: 'Profile'),
        ],
      ),
    );
  }
}

/*----------------- Home Body Part -----------------*/
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            GreetingBar(),
            SizedBox(height: 18),
            SearchField(),
            SizedBox(height: 18),
            CategoryRow(),
            SizedBox(height: 18),
            IntakeBoard(),
            SizedBox(height: 18),
            FeaturedList(),
          ],
        ),
      );
}
