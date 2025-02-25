import 'package:flutter/material.dart';

// Giả sử bạn đã định nghĩa appTheme trong app_theme.dart
import '../../core/themes/theme.dart';

class HomeScreen extends StatelessWidget {
  // Dữ liệu về các bữa ăn gợi ý
  final List<String> suggestedMeals = [
    "Fresh vegetable salad",
    "Stir-fried broccoli",
    "Grilled chicken with herbal spices",
    "Toasted bread with peanut butter"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthEats App", style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Điều hướng tới trang profile hoặc thông tin người dùng
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chào mừng người dùng
            Text(
              "Welcome back!",
              style: Theme.of(context).textTheme.headlineLarge, // Sử dụng headlineLarge từ appTheme
            ),
            SizedBox(height: 10),
            Text(
              "Here are some meal suggestions for you:",
              style: Theme.of(context).textTheme.headlineMedium, // Sử dụng bodyText1 từ appTheme
            ),
            SizedBox(height: 20),

            // Danh sách các bữa ăn gợi ý
            Expanded(
              child: ListView.builder(
                itemCount: suggestedMeals.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(suggestedMeals[index], style: Theme.of(context).textTheme.bodyMedium),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // Điều hướng tới chi tiết bữa ăn nếu muốn
                      },
                    ),
                  );
                },
              ),
            ),

            // Các tính năng khác (phân tích dinh dưỡng, chế độ ăn kiêng)
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.pie_chart, size: 40),
                    Text("Nutrition Analysis", style: Theme.of(context).textTheme.bodyMedium), // Sử dụng bodyMedium
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.fastfood, size: 40),
                    Text("Diet Plan", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 40),
                    Text("AI Suggestions", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Nút đăng ký (hoặc bất kỳ hành động nào)
            ElevatedButton(
              onPressed: () {
                // Hành động khi nhấn nút
              },
              child: Text("Get Started", style: Theme.of(context).textTheme.bodyMedium), // Sử dụng bodyText2 cho chữ nút
            ),
          ],
        ),
      ),
    );
  }
}
