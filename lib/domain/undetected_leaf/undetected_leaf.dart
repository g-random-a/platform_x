class UndetectedLeaf {
  // String coffeeLeafId;
  String filename;
  String filesize;
  int uploadtime;
  String imagelocation;

  static final List<String> hospitalFields = [
    'coffeeLeafId',
    'filename',
    'filesize',
    'uploadtime',
    'imagelocation',
  ];

  UndetectedLeaf({
    // required this.coffeeLeafId,
    required this.filename,
    required this.filesize,
    required this.uploadtime,
    required this.imagelocation,
  });

  factory UndetectedLeaf.fromJson(Map<String, dynamic> json) {
    return UndetectedLeaf(
        // coffeeLeafId: json['coffeeLeafId'],
        filename: json['filename'],
        filesize: json['filesize'],
        uploadtime: json['uploadtime'],
        imagelocation: json['imagelocation']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    // json['coffeeLeafId'] = coffeeLeafId;
    json['filename'] = filename;
    json['filesize'] = filesize;
    json['uploadtime'] = uploadtime;
    json['imagelocation'] = imagelocation;
    return json;
  }

  @override
  String toString() {
    return "leafname $filename, location $imagelocation";
  }
}
