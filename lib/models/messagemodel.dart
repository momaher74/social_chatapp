class MessageModel{
  String ? senderId ;
  String ? receiverId ;
  String ? date ;
  String ? text ;
  MessageModel({
    required this.senderId ,
    required this.receiverId ,
    required this.date ,
    required this.text ,
});
  MessageModel.fromJson(Map json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    date = json['date'];
    text = json['text'];
  }
  toMap(){
    return {
      'senderId':senderId ,
      'receiverId':receiverId ,
      'date':date ,
      'text':text ,
    } ;
  }
}