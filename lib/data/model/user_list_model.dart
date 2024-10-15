

class UserListModel {
  final String dueAmount;
  final String name;
  final String netWait;
  final String paybelAmount;
  final String pises;
  final String price;
  final String totalAmount;
  final String disAmount;
  final String userID;
  final String date;

  UserListModel({
    required this.dueAmount,
    required this.name,
    required this.netWait,
    required this.paybelAmount,
    required this.pises,
    required this.price,
    required this.totalAmount,
    required this.disAmount,
    required this.userID,
    required this.date,
  });
  factory UserListModel.fromMap(Map<String, dynamic> data) {
    return UserListModel(
      dueAmount: data['dueAmount'] ?? '',
      name: data['name'] ?? '',
      netWait: data['netWait'] ?? '',
      paybelAmount: data['paybelAmount'] ?? '',
      pises: data['pises'] ?? '',
      price: data['price'] ?? '',
      totalAmount: data['totalAmount'] ?? '',
      disAmount: data['disCountAmount'] ?? '',
      userID: data['userID'] ?? '',
      date: data['date'] ?? '',
    );
  }
}
