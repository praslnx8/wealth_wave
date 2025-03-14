import 'package:flutter/material.dart';
import 'package:wealth_wave/ui/nav_path.dart';
import 'package:wealth_wave/ui/pages/baskets_page.dart';
import 'package:wealth_wave/ui/pages/expense_tags_page.dart';
import 'package:wealth_wave/ui/pages/goal_page.dart';
import 'package:wealth_wave/ui/pages/investment_page.dart';
import 'package:wealth_wave/ui/pages/main_page.dart';
import 'package:wealth_wave/ui/pages/upcoming_sips_page.dart';

class AppRouter {
  static Widget route(String path) {
    final uri = Uri.parse(path);
    if (NavPath.isMainPagePath(uri.pathSegments)) {
      return MainPage(path: uri.pathSegments);
    } else if (NavPath.isInvestmentPagePath(uri.pathSegments)) {
      return InvestmentPage(investmentId: int.parse(uri.pathSegments[1]));
    } else if (NavPath.isGoalPagePath(uri.pathSegments)) {
      return GoalPage(goalId: int.parse(uri.pathSegments[1]));
    } else if(NavPath.isBasketsPagePath(uri.pathSegments)) {
      return const BasketsPage();
    } else if(NavPath.isExpenseTagsPagePath(uri.pathSegments)) {
      return const ExpenseTagsPage();
    } else if(NavPath.isUpcomingSipPath(uri.pathSegments)) {
      return const UpcomingSipsPage();
    }
    return const MainPage(path: []);
  }
}
