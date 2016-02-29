//TODO: copyright ODW
library odw.sdk.http.mime_type;

//TODO: either make this part of http_parser.dart or flush

const utf8 = "utf-8";

class MimeType {
  final String type;
  final String subtype;
  /// The default character set for the MediaTypeBase
  final String charset;  // default character set

  String get mimeType => toString();

  const MimeType(this.type, this.subtype, this.charset);

  // Compile time constant definitions
  static const text = const MimeType("text", "plain", utf8);
  static const html = const MimeType("text", "html", utf8);
  static const rtf = const MimeType("text", "rtf", utf8);

  static const application = "application";
  static const pdf = const MimeType(application, "pdf", utf8);
  static const xml = const MimeType(application, "xml", utf8);
  static const json = const MimeType(application, "json", utf8);
  static const dicom = const MimeType(application, "dicom", utf8);
  static const dicom_xml = const MimeType(application, "dicom+xml", utf8);
  static const dicom_json = const MimeType(application, "dicom+json", utf8);

  toString() => '$type/$subtype';
}
