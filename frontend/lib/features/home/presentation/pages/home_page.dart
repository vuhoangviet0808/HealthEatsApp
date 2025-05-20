import 'package:flutter/material.dart';
import '../../../../core/themes/theme.dart';          // để lấy màu

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo2.webp',
              height: 34,               // tuỳ chỉnh
            ),
            const SizedBox(width: 8),
            const Text('HealthEats'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: const _HomeBody(),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

/*------------------------------ BODY --------------------------------*/
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 20);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting --------------------------------------------------
          Text('Good morning, Alice 👋',
              style: Theme.of(context).textTheme.headlineMedium),
          gap,
          // Search ----------------------------------------------------
          TextField(
            decoration: InputDecoration(
              hintText: 'Search healthy recipes…',
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          gap,
          // Categories -----------------------------------------------
          _CategoryRow(),
          gap,
          // Intake Dashboard -----------------------------------------
          _IntakeBoard(),
          gap,
          // Featured Recipes -----------------------------------------
          Text('Featured Recipes',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, i) => _RecipeCard(index: i),
            ),
          ),
        ],
      ),
    );
  }
}

/*------------------------- CATEGORY ROW -----------------------------*/
class _CategoryRow extends StatelessWidget {
  final cats = const ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Drinks'];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) => ChoiceChip(
            label: Text(cats[i]),
            selected: i == 0,
            selectedColor: primaryColor.withOpacity(.2),
            labelStyle: TextStyle(
                color: i == 0 ? primaryColor : Colors.black87,
                fontWeight: FontWeight.w600),
            onSelected: (_) {},
          ),
        ),
      );
}

/*------------------------- INTAKE BOARD -----------------------------*/
class _IntakeBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Calories', 660, 2000, Icons.local_fire_department),
      ('Protein', 35, 80, Icons.egg_alt),
      ('Carbs', 120, 300, Icons.rice_bowl),
      ('Fat', 20, 70, Icons.oil_barrel_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4),
      itemBuilder: (_, i) {
        final (title, value, max, icon) = items[i];
        final pct = value / max;
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: primaryColor),
                const Spacer(),
                Text('$value / $max',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: pct,
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                  minHeight: 6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*-------------------------- RECIPE CARD -----------------------------*/
class _RecipeCard extends StatelessWidget {
  final int index;
  const _RecipeCard({required this.index});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 160,
        child: InkWell(
          onTap: () {}, // TODO: điều hướng sang chi tiết
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ảnh */
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    'assets/images/recipe_${index % 3 + 1}.webp',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Avocado Salad',
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Icon(Icons.local_fire_department,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('320 kcal',
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

/*---------------------- BOTTOM NAVIGATION ---------------------------*/
class _BottomNav extends StatefulWidget {
  @override
  State<_BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<_BottomNav> {
  int _idx = 0;
  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        currentIndex: _idx,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black45,
        onTap: (i) => setState(() => _idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      );
}
