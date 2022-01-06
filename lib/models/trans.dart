class Transaction {
  final int id;
  final String title;
  final double balance;

  Transaction({
    required this.id,
    required this.title,
    required this.balance,
  });
}

// Our demo Products

List<Transaction> transactions = [
  Transaction(
    id: 01,
    title: "Gifts from grandparents",
    balance: 24.99,
  ),
  Transaction(
    id: 02,
    title: "Buy xbox",
    balance: 64,
  ),
  Transaction(
    id: 03,
    title: "Buy cards",
    balance: 73,
  ),
];
