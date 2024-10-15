import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/user_list_model.dart';

class Server{
  static Future<void> setUser(
      String userId,
      String name,
      String pises,
      String netWait,
      String price,
      String totalAmount,
      String paybelAmount,
      String dueAmount,
      String date,
      ) async {
    await FirebaseFirestore.instance.collection("User_list").doc("user").set(
      {
        "user": FieldValue.arrayUnion([
          {
            "userID": userId,
            "name": name,
            "pises": pises,
            "netWait": netWait,
            "price": price,
            "totalAmount": totalAmount,
            "paybelAmount": paybelAmount,
            "dueAmount": dueAmount,
            "date": date,
          }
        ]),
      },
      SetOptions(merge: true), // Use merge to avoid overwriting the whole document
    );
  }
  static Stream<List<UserListModel>> getItems() {
    return FirebaseFirestore.instance
        .collection('User_list')
        .doc('user')
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> users = data['user'] ?? [];
      return users.map((user) {
        return UserListModel.fromMap(user as Map<String, dynamic>);
      }).toList();
    });
  }

  static updateUserData(String userId, String paybelAmount,
      String dueAmount,) async {
    try {
      // Update logic using FirebaseFirestore or other methods
      await FirebaseFirestore.instance
          .collection('User_list')
          .doc('user')
          .update({
        'user': FieldValue.arrayUnion(
            [{
              "paybelAmount": paybelAmount,
              "dueAmount": dueAmount,
            }]
        ), // Assuming update logic
      });
      print('User updated successfully');
    } catch (error) {
      print('Error updating user: $error');
    }
  }

  static Future addUser (Map<String,dynamic> userInf,String id)async{
    return await FirebaseFirestore.instance.collection('customer')
        .doc(id).set(userInf);
   }
  static Future<Stream<QuerySnapshot>> getUser ()async{
    return await FirebaseFirestore.instance.collection('customer').snapshots();
  }
  // static Future<Stream<List<UserListModel>>> getUser() async {
  //   return FirebaseFirestore.instance.collection('customer').snapshots().map(
  //         (snapshot) {
  //       return snapshot.docs.map((doc) {
  //         return UserListModel.fromMap(doc.data());
  //       }).toList();
  //     },
  //   );
  // }


  static Future updateUser (Map<String,dynamic> userInf,String id)async{
    return await FirebaseFirestore.instance.collection('customer')
        .doc(id).update(userInf);
  }

  static Future<void> deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(id)
          .delete();
      print('User deleted successfully');
    } catch (error) {
      print('Error deleting user: $error');
    }
  }
}