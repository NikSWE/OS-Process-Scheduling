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
  // To load 'testcases.txt' replace it with 'input.txt'
  File inputFile = File('input.txt');
  List<String> contents = inputFile.readAsLinesSync();

  // Contains the processes given in the file
  List<Process> processList = [];

  // Time quantum for round robin algorithm
  int time_quantum = 1;

  // Add processes to processList
  for (String content in contents) {
    // ignore all the comments mentioned in the file
    if (content.contains('#')) continue;

    // get the time quantum from the file
    if (content.contains('RR')) {
      time_quantum = int.parse(content.split(' ')[1]);
      continue;
    }

    // extract the process information from the content
    // by splitting it on 'space'.
    // the list contains 'process_id', 'arrival_time', 'burst_time'
    List<String> processInfo = content.split(' ');
    // create a new process from the process info
    // add the process to process list
    processList.add(Process.fromProcessInfo(processInfo));
  }
  // Check input file for process details
  // if no process are given by user, display an error message
  // else execute the scheduling algorithms
  if (processList.length == 0) {
    // Process List is empty
    print('Input file is empty!'); // Prompt user with the error message
  } else {
    // executing scheduling algorithms
    String bestAlgorithm; // best algorithm to implement for the given processes
    String worstAlgorithm; // worst algorithm to implement for the given processes
    FCFS fcfs = FCFS(processList);
    fcfs.Execute();
    fcfs.printGanttChart();
  }
}
