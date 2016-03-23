//TODO: copyright
library uploader.tools.create_data_file;

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

const MB = 1024 * 1024;
const GB = MB * 1024;

const MB_1_64 = (1 * 1024 * 1024) ~/ 8;
const MB_2_64 = (2 * 1024 * 1024) ~/ 8;
const MB_4_64 = (4 * 1024 * 1024) ~/ 8;
const MB_8_64 = (8 * 1024 * 1024) ~/ 8;
const MB_16_64 = (16 * 1024 * 1024) ~/ 8;
const MB_32_64 = (32 * 1024 * 1024) ~/ 8;
const MB_64_64 = (64 * 1024 * 1024) ~/ 8;
const MB_128_64 = (128 * 1024 * 1024) ~/ 8;
void main() {
  String fname = "data/data.dat";
  //var rnd = new Random(0);
  Uint8List chunk = new Uint8List(1 * MB);
  for(int i = 0; i < chunk.length; i++) {
    print('1=$i');
    chunk[i] = i & 0xFF;
  }


  //print('data.length: ${data.length ~/ GB}');
  for(int i = 1; i <= 1024; i *= 2) {
    int size = i * GB;
    int nChunks = size ~/ chunk.length;
    File f = new File('data/data_${i}_GB.dat');
    print('i: $i, size: $size, nChunks: $nChunks, path: ${f.path}');
    IOSink sink = f.openWrite();
    for(int j = 0; j < nChunks; j++) {
      sink.add(chunk);
    }
    // Close the IOSink to free system resources.
    sink.close();
  }
}

