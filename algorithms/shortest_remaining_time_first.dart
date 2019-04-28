import 'dart:collection';

import '../models/process.dart';
import '../models/process_queue.dart';
import '../models/algorithm.dart';

class SRTF with Algorithm {
  SRTF(List<Process> processList) {
    this.processList = List.from(processList);
    arrivalTimeList = List<int>();
    burstTimeList = List<int>();
    readyQueue = ProcessQueue();
    runningQueue = ProcessQueue();
    for (Process process in this.processList) {
      arrivalTimeList.add(process.arrival_time);
      burstTimeList.add(process.burst_time);
    }
    arrivalTimeList.sort();
    burstTimeList.sort();
    
    // sort the process list on the basis of arrival time and burst time
    sortProcessList('both');
  }

  @override
  void printGanttChart() {
    if (processList.isNotEmpty) {
      print('************************* Gantt Chart *************************');
      print('P_ID\tP_AT\tP_BT\tP_TAT\tP_WT');
      processList.forEach((Process process) {
        process.printProcessInfo();
      });
      print('***************************************************************');
      print('Avg Turnaround Time = ${avg_turnaround_time.toStringAsFixed(3)}\tAvg Waiting Time = ${avg_waiting_time.toStringAsFixed(3)}');
      print('***************************************************************');
    }
  }

  @override
  void Execute() {
    for (Process process in this.processList) {
      process.temp_burst_time = process.burst_time;
    }
    for (int arrival_time in arrivalTimeList) {
      for (int burst_time in burstTimeList) {
        if (burst_time == 0) continue;
        readyQueue.addProcessFromIterable(processList.where((Process process) {
          if (process.arrival_time == arrival_time && process.burst_time == burst_time && !readyQueue.contains(process))
            return true;
          else
            return false;
        }));
      }
    }

    Process firstProcess = readyQueue.first;
    int current_time = firstProcess.arrival_time;

    List<Process> tempList = [];
    Queue<Process> tempQueue = Queue();
    tempQueue.addAll(readyQueue.cast());
    
    while (readyQueue.isNotEmpty) {
      tempList = tempQueue.where((Process process) {
        if (process.arrival_time <= current_time && !tempList.contains(process))
          return true;
        else
          return false;
      }).toList();

      tempQueue.removeWhere((Process process) {
        if (tempList.contains(process))
          return true;
        else
          return false;
      });

      tempList.sort((Process a, Process b) {
        if (a.temp_burst_time < b.temp_burst_time)
          return -1;
        else if (a.temp_burst_time == b.temp_burst_time) {
          if (a.arrival_time > b.arrival_time)
            return 1;
          else
            return 0;
        } else
          return 1;
      });

      if (--tempList[0].temp_burst_time == 0) {
        tempList[0].completion_time = current_time + 1;
        tempList[0].turnaround_time = tempList[0].completion_time - tempList[0].arrival_time;
        tempList[0].waiting_time = tempList[0].turnaround_time - tempList[0].burst_time;
        readyQueue.removeProcess(tempList[0]);
        runningQueue.addProcess(tempList[0]);
        tempList.remove(tempList[0]);
      }
      tempQueue.addAll(tempList);
      tempList = [];
      current_time++;
    }
    
    if (runningQueue.isEmpty) {
      print('No process in the running queue');
      processList = [];
    } else
      processList = runningQueue.convertToList();
  }
}
