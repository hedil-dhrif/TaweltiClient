class FileEvent {
  int id;
  int eventId;
  String fileName;
  String url;

  FileEvent(
      {this.id,
        this.eventId,
        this.fileName,
        this.url,
      });
  Map<String, dynamic> toJson() {
    return {
      'filename': fileName,
      'EvenementId':eventId,
      'url':url,
    };
  }
  factory FileEvent.fromJson(Map<String, dynamic> item) {
    return FileEvent(
      id: item['id'],
      fileName: item['filename'],
      url: item['url'],
      eventId: item['EvenementId'],

    );
  }
}
