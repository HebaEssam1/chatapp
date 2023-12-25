class Message{
  static const String CollectionName='Messages';
  String id;
  String roomId;
  String senderId;
  String senderName;
  String content;
  int senderTime;
  Message({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.senderTime,
});

  Message.fromJson(Map<String,dynamic> json):this(
    id: json['id'] as String,
    roomId: json['roomId'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    content: json['content'] as String,
    senderTime: json['senderTime'] as int,
  );

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'roomId':roomId,
      'senderId':senderId,
      'senderName':senderName,
      'content':content,
      'senderTime':senderTime
    };
  }
}