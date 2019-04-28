import 'dart:collection';

import '../models/process.dart';
import '../models/process_queue.dart';
import '../models/algorithm.dart';

class RR with Algorithm {
  int time_quantum;
  RR(List<Process> processList, this.time_quantum) {
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
    
    // sort the process list on the basis of arrival time
    sortProcessList('arrival');
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
      readyQueue.addProcessFromIterable(processList.where((Process process) {
        // find all the process's where arrival time is same, burst time is not 0 and ready queue doen't already contain it
        if (process.arrival_time == arrival_time && process.burst_time != 0 && !readyQueue.contains(process))
          return true;
        else
          return false;
      }));
    }

    Process firstProcess = readyQueue.first;
    int current_time = firstProcess.arrival_time;

    Process tempProcess;
    Process lastRunProcessRan;
    Queue<Process> tempQueue2 = Queue<Process>();
    Queue<Process> tempQueue = Queue<Process>();
    tempQueue2.addAll(readyQueue.cast());

    while (readyQueue.isNotEmpty) {
      tempQueue.addAll(tempQueue2.where((Process process) {
        if (process.arrival_time <= current_time && !tempQueue.contains(process))
          return true;
        else
          return false;
      }));

      tempQueue2.removeWhere((Process process) {
        if (tempQueue.contains(process))
          return true;
        else
          return false;
      });

      if (lastRunProcessRan != null && readyQueue.contains(lastRunProcessRan)) {
        tempQueue.remove(lastRunProcessRan);
        tempQueue.addLast(lastRunProcessRan);
      }

      tempProcess = tempQueue.removeFirst();
      lastRunProcessRan = tempProcess;
      for (int i = 1; i <= time_quantum; i++) {
        if (tempProcess.temp_burst_time != 0)
          tempProcess.temp_burst_time--;
        else {
          tempProcess.completion_time = current_time;
          tempProcess.turnaround_time = tempProcess.completion_time - tempProcess.arrival_time;
          tempProcess.waiting_time = tempProcess.turnaround_time - tempProcess.burst_time;
          readyQueue.removeProcess(tempProcess);
          tempQueue.remove(tempProcess);
          runningQueue.addProcess(tempProcess);
          break;
        }
        current_time++;
      }
      if (tempProcess.temp_burst_time == 0 && readyQueue.contains(tempProcess)) {
        tempProcess.completion_time = current_time;
        tempProcess.turnaround_time = tempProcess.completion_time - tempProcess.arrival_time;
        tempProcess.waiting_time = tempProcess.turnaround_time - tempProcess.burst_time;
        readyQueue.removeProcess(tempProcess);
        tempQueue.remove(tempProcess);
        runningQueue.addProcess(tempProcess);
      }
      if (tempProcess.temp_burst_time != 0) tempQueue.add(tempProcess);
    }
  }
}
