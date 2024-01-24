import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class GoalsPresenter extends Presenter<GoalsViewState> {
  final GoalService _goalService;

  GoalsPresenter({final GoalService? goalService})
      : _goalService = goalService ?? GoalService(),
        super(GoalsViewState());

  void fetchGoals() {
    _goalService
        .get()
        .then((goals) =>
            Future.wait(goals.map((goal) => GoalVO.from(goal: goal))))
        .then((goalVOs) =>
            updateViewState((viewState) => viewState.goalVOs = goalVOs));
  }

  void deleteGoal({required final int id}) {
    _goalService.deleteBy(id: id).then((_) => fetchGoals());
  }
}

class GoalsViewState {
  List<GoalVO> goalVOs = [];
}

class GoalVO {
  final int id;
  final String name;
  final String? description;
  final double maturityAmount;
  final double investedAmount;
  final DateTime maturityDate;
  final double valueOnMaturity;
  final double inflation;
  final double irr;
  final GoalImportance importance;
  final int taggedInvestmentCount;

  double get yearsLeft => maturityDate.difference(DateTime.now()).inDays / 365;

  double get progress => valueOnMaturity / maturityAmount;

  GoalVO._(
      {required this.id,
      required this.name,
      required this.description,
      required this.maturityAmount,
      required this.maturityDate,
      required this.valueOnMaturity,
      required this.investedAmount,
      required this.importance,
      required this.inflation,
      required this.irr,
      required this.taggedInvestmentCount});

  static Future<GoalVO> from({required final Goal goal}) async {
    return GoalVO._(
        id: goal.id,
        name: goal.name,
        description: goal.description,
        importance: goal.importance,
        inflation: goal.inflation,
        maturityAmount: goal.maturityAmount,
        investedAmount: goal.investedAmount,
        maturityDate: goal.maturityDate,
        irr: goal.irr,
        valueOnMaturity: goal.valueOnMaturity,
        taggedInvestmentCount: goal.taggedInvestments.length);
  }
}
