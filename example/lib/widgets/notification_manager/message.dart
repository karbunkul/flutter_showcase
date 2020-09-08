class Message {
  final String title;
  final String message;

  Message({this.title, this.message});
}

enum MessageType {
  toast,
  modal,
}
