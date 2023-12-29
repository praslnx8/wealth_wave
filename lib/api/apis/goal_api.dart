import 'package:drift/drift.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';

class GoalApi {
  final AppDatabase _db;

  GoalApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<List<Goal>> getGoals() async {
    return _db.select(_db.goalTable).get();
  }

  Future<Goal> getGoal({required final int id}) async {
    return _db.select(_db.goalTable).getSingle();
  }

  Future<int> createGoal(
      {required final String name,
      required final double amount,
      required final DateTime date,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) async {
    return _db.into(_db.goalTable).insert(GoalTableCompanion.insert(
        name: name,
        amount: amount,
        date: date,
        targetAmount: targetAmount,
        targetDate: targetDate,
        inflation: inflation,
        importance: importance));
  }

  Future<int> update(
      {required final int id,
      required final String name,
      required final double amount,
      required final DateTime date,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) async {
    return (_db.update(_db.goalTable)..where((t) => t.id.equals(id))).write(
        GoalTableCompanion(
            name: Value(name),
            amount: Value(amount),
            date: Value(date),
            targetAmount: Value(targetAmount),
            targetDate: Value(targetDate),
            inflation: Value(inflation),
            importance: Value(importance)));
  }

  Future<int> deleteGoal({required final int id}) async {
    return (_db.delete(_db.goalTable)..where((t) => t.id.equals(id))).go();
  }

  Future<int> tagInvestmentToGoal(
      {required final int goalId,
      required final int investmentId,
      required final double percentage}) async {
    return _db.into(_db.goalInvestmentTable).insert(
        GoalInvestmentTableCompanion.insert(
            goalId: goalId,
            investmentId: investmentId,
            sharePercentage: percentage));
  }

  Future<List<GoalInvestment>> getGoalInvestments() async {
    return _db.select(_db.goalInvestmentTable).get();
  }

  Future<int> updateGoalInvestmentTag(
      {required final int id,
      required final int goalId,
      required final int investmentId,
      required final double percentage}) async {
    return (_db.update(_db.goalInvestmentTable)..where((t) => t.id.equals(id)))
        .write(GoalInvestmentTableCompanion(
            goalId: Value(goalId),
            investmentId: Value(investmentId),
            sharePercentage: Value(percentage)));
  }

  Future<int> deleteGoalInvestmentTag({required final int id}) async {
    return (_db.delete(_db.goalInvestmentTable)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> deleteGoalInvestmentTags({required final int goalId}) async {
    return (_db.delete(_db.goalInvestmentTable)
          ..where((t) => t.goalId.equals(goalId)))
        .go();
  }
}
