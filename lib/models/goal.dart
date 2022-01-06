class Goal {
  final int id;
  final String title;
  final double balance;

  Goal({
    required this.id,
    required this.title,
    required this.balance,
  });
}

// Our demo Products

List<Goal> goals = [
  Goal(
    id: 01,
    title: "Bycycle",
    balance: 24,
  ),
  Goal(
    id: 02,
    title: "Cards",
    balance: 64,
  ),
  Goal(
    id: 03,
    title: "Play cards",
    balance: 73,
  ),
];
