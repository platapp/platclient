class Transaction {
  final id;
  final amount;
  final dueDate;
  bool isRecurring;
  Transaction(this.id, this.amount, this.dueDate, this.isRecurring);
  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? Uuid().generateV4(),
        amount = json['amount'],
        dueDate = json['dueDate'],
        isRecurring = json['dueDate'];

  /*Map<String, dynamic> toJson() => {
        'id': name,
        'email': email,
      };*/
}
