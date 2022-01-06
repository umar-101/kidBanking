class Kid {
  final int id;
  final String name, image;
  final double balance, age;

  Kid({
    required this.id,
    required this.image,
    required this.name,
    required this.balance,
    required this.age,
  });
}

// Our demo Products

List<Kid> kids = [
  Kid(
    id: 1,
    image: 'assets/images/child.png',
    name: "Aviv",
    balance: 64.99,
    age: 12,
  ),
  Kid(
    id: 2,
    image: 'assets/images/child.png',
    name: "Sonail",
    balance: 78.99,
    age: 11,
  ),
  Kid(
    id: 3,
    image: 'assets/images/child.png',
    name: "Emily",
    balance: 124.99,
    age: 17,
  ),
  Kid(
    id: 4,
    image: 'assets/images/child.png',
    name: "Smith",
    balance: 234,
    age: 13,
  ),
  Kid(
    id: 5,
    image: 'assets/images/child.png',
    name: "John",
    balance: 14.99,
    age: 15,
  ),
];
