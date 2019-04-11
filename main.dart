/// Process Scheduling in OS
/// TODO: explain about project in brief here
import 'dart:io';

import 'models/process.dart';
import 'algorithms/scheduling_algorithms.dart';

void main() {
  // TODO: add comments to your code
  File inputFile = File('input.txt');
  List<String> contents = inputFile.readAsLinesSync();
  List<Process> processList = [];
  for (String content in contents) {
    if (content.contains('#')) continue;
    List<String> processInfoList = content.split(' ');
    processList.add(Process.fromProcessInfoList(processInfoList));
  }
}
