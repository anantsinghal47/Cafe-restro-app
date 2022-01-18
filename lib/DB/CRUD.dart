
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

 Future<void> addItem({
   @required userId,
   @required id ,
   @required orderNum ,
   @required amount ,
   @required products ,
   @required dateTime
}) async {
DocumentReference documentReferencer =
_mainCollection.doc(userId).collection('orders').doc(id);


Map<String, dynamic> data = <String, dynamic>{

  "order_id" : id,
  "orderNum":orderNum,
  "products" : products,
  "amount" : amount,
  "dateTime" : dateTime,
};

await documentReferencer
    .set(data)
.whenComplete(() => print(" orders  added to the database"))
.catchError((e) => print(e));
}