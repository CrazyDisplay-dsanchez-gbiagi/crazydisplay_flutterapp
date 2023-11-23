class Message {
  String date;
  String message;

  Message(this.date, this.message);

  String getMessage() {
    return (message);
  }

  String getDate() {
    return (date);
  }

  @override
  String toString() {
    return "$date; $message";
  }
}
