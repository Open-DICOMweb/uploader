//TODO copyright
library uploader.tools.read_file_in_chunks;

import 'dart:async';
//import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const MB = 1024 * 1024;
const GB = MB * 1024;

main() async {
  // move to test

  Stopwatch watch = new Stopwatch();

  watch.start();
  int startTime = 0;

  for (int i = 1; i <= 1024; i *= 2) {
    String inName = 'data/data_${i}_MB.dat';
    String outName = '$inName.output';
    File inFile = new File(inName);
    File outFile = new File(outName);
   // print('input: ${inFile.path}, output: ${outFile.path}');
   // print('copying...');
    await copyFile(inName, outName, 8 * MB);
   // print('done.');

    int endTime = watch.elapsedMilliseconds;
    int elapsed = (endTime - startTime);
    //print('eTime: $elapsed seconds, File: $outName');
    print(elapsed);

    await  outFile.delete();
    //print('deleted $outFile');
  }
}

Future copyFile(String inName, String outName, [chunkSize= 1 * MB]) async {
  Uint8List chunk = new Uint8List(chunkSize);

  File inFile = new File(inName);
  int length = await inFile.length();
  int nChunks = (length / chunkSize).ceil();

  File outFile = new File('$inName.output');

  RandomAccessFile rafIn = await inFile.open(mode: FileMode.READ);
  RandomAccessFile rafOut = await outFile.open(mode: FileMode.WRITE_ONLY);
  //int inPos = 0;
  //int outPos = 0;

  //print('chunkSize: $chunkSize, nChunks: $nChunks');
  for(int i = 1; i <= nChunks; i++) {
    //inPos = await rafIn.position();
    //outPos = await rafOut.position();
    //print('inPos: $inPos, outPos: $outPos');
    await rafIn.readInto(chunk);
    await rafOut.writeFrom(chunk);
    //inPos = await rafIn.position();
    //outPos = await rafOut.position();
    //print('inPos: $inPos, outPos: $outPos');
  }
  await rafIn.close();
  await rafOut.close();
}




/*
main() async {
  List result = [];

  Stream<List<int>> stream = new File(Platform.script.toFilePath()).openRead();
  int semicolon = ';'.codeUnitAt(0);

  await for (var data in stream) {
    for (int i = 0; i < data.length; i++) {
      result.add(data[i]);
      if (data[i] == semicolon) {
        print(new String.fromCharCodes(result));
        return;
      }
    }
  }
}

main3() async {
  final file = new File('file.txt');
  Stream<List<int>> inputStream = file.openRead();

  Stream<String> lines = inputStream
      // Decode to UTF8.
      .transform(UTF8.decoder)
      // Convert stream to individual lines.
      .transform(new LineSplitter());

  try {
    await for (String line in lines) print('$line: ${line.length} bytes');
  } catch (e) {
    print(e.toString());
  }

  print('File is now closed.');
}
*/
