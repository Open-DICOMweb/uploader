// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library odw.sdk.http.media_type;

//TODO: either make this part of http_parser.dart or flush
import 'package:http_parser/http_parser.dart';
import 'mime_type.dart';

/// A regular expression matching a character that needs to be backslash-escaped
/// in a quoted string.
final _escapedChar = new RegExp(r'["\x00-\x1F\x7F]');

/// A class representing an HTTP media type, as used in Accept and Content-Type
/// headers.
///
/// This is immutable; new instances can be created based on an old instance by
/// calling [change].
class MT extends MediaType {
  /// The BaseType of the Media Type, sometimes called MIME type.
  ///
  /// This is always lowercase.
  final MimeType mimeType;

  //final String type;

  /// The secondary identifier of the MIME type.
  ///
  /// This is always lowercase.
  //final String subtype;

  /// The parameters to the media type.
  ///
  /// This map is immutable and the keys are case-insensitive.
  final Map<String, String> parameters;

  MT(this.mimeType, this.parameters);

  /// The media type's default character set.
  String get defaultCharset => mimeType.charset;

}
