/// Created by Nikhil Anand on 11/04/19
/// ===================================================================================
/// CPU Scheduling in OS
/// --------------------
/// This project simulates scheduling algorithms used by Operating Systems
/// to resolve which process should be assigned to CPU.
///
/// Scheduling algorithms used are mentioned below
/// 'First Come First Serve (FCFS)'
/// 'Shortest Job First (SJF)'
/// 'Shortest Remaining Time First (SRTF)'
/// 'Round Robin (RR)'
/// ===================================================================================
import 'dart:io';

import 'models/process.dart';
import 'algorithms/scheduling_algorithms.dart';

void main() {
  // Get the input file reference
  // To load testcases.txt instead of input.txt
  // replace input.txt with testcases.txt
  File inputFile = File('input.txt');

  // reading the contents of the inputFile line by line synchronously
  List<String> contents = inputFile.readAsLinesSync();

  // Contains the processes given in the inputFile
  List<Process> processList = List<Process>();

  // Time quantum for round robin algorithm
  // as mentioned in the inputFile
  // by default it is set to 1
  int time_quantum = 1;

  // Adding processes to processList
  for (String content in contents) {
    // ignore all the comments mentioned in the inputFile
    if (content.startsWith('#')) continue;

    // get the time quantum from the inputFile
    if (content.contains('RR')) {
      time_quantum = int.parse(content.split(' ')[1]);
      continue;
    }

    // extract the process information from the content
    // by splitting it on 'space'.
    // the processInfo contains 'process_id', 'arrival_time', 'burst_time'
    List<String> processInfo = content.split(' ');

    // create a new process from the process information
    // and add this process to process list
    processList.add(Process.fromProcessInfo(processInfo));
  }

  // Check input file for process details
  // if no process are given by user, display an error message
  if (processList.isEmpty) {
    // Process List is empty
    print('Input file is empty!'); // Prompt user with the error message
  }
  // else execute the scheduling algorithms
  else {
    // executing scheduling algorithms
    FCFS fcfs = FCFS(processList);  // create an object of FCFS algorithm
    SJF sjf = SJF(processList); // create an object of SJF algorithm
    SRTF srtf = SRTF(processList); // create an object of SRTF algorithm
    srtf.Execute();
    srtf.printGanttChart();
  }
}
