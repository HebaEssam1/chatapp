import 'dart:async';
import 'package:chatapp/model/Room.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseUtils{
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>
      (fromFirestore: ((snapshot, options) => MyUser.fromJson(snapshot.data()!)),
      toFirestore: (user, options) => user.toJson());
  }
  static CollectionReference<Room> getRoomCollection(){
    return FirebaseFirestore.instance.collection(Room.collectionName).
    withConverter<Room>
      (fromFirestore: ((snapshot, options) => Room.fromJson(snapshot.data()!)),
        toFirestore: (room, options) => room.toJson());
  }
  static CollectionReference<Message> getMessageCollection(String roomId){
    return FirebaseFirestore.instance.collection(Room.collectionName).
    doc(roomId).collection(Message.CollectionName).
    withConverter<Message>
      (fromFirestore: (snapshot, options) => Message.fromJson(snapshot.data()!),
        toFirestore: (message, options) => message.toJson());
  }
  static Future<void> registerUser(MyUser user) async{
    return getUserCollection().doc(user.id).set(user);

  }
  static Future<MyUser?> getUser(String userId)async{
    var documentSnapshot= await getUserCollection().doc(userId).get();
    return documentSnapshot.data();
  }
  static Future<void> AddRoom(Room room) async{
    var docRef=await getRoomCollection().doc();
    room.id=docRef.id;
    return docRef.set(room);

  }
  static Stream<QuerySnapshot<Room>> getRomms(){
    return getRoomCollection().snapshots();
  }
  static Future<void> sendMessage(Message message) async{
    var docRef= await getMessageCollection(message.roomId).doc();
    message.id=docRef.id;
    return docRef.set(message);
  }
  static Stream<QuerySnapshot<Message>> loadMessages(roomId){
    return getMessageCollection(roomId).orderBy('senderTime').snapshots();
  }

}
