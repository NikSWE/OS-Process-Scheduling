import '../models/process.dart';
import '../models/algorithm.dart';
import '../models/comparable.dart';
import 'dart:collection';

class SJF extends Algorithm {
  SJF(List<Process> processList) : super.fromProcessList(processList) {
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
      print('Avg Turnaround Time = ${avg_turnaround_time}\tAvg Waiting Time = ${avg_waiting_time}');
      print('***************************************************************');
    }
  }

  @override
  void Execute() {
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
    current_time += firstProcess.burst_time;
    firstProcess.completion_time = current_time;
    firstProcess.turnaround_time = firstProcess.completion_time - firstProcess.arrival_time;
    firstProcess.waiting_time = firstProcess.turnaround_time - firstProcess.burst_time;
    readyQueue.removeProcess(firstProcess);
    runningQueue.addProcess(firstProcess);

    List<Process> tempList = [];
    Queue<Process> tempQueue = Queue();
    while (readyQueue.isNotEmpty) {
      tempQueue.addAll(readyQueue.cast());
      tempList = tempQueue.where((Process process) {
        if (process.arrival_time <= current_time && !tempList.contains(process))
          return true;
        else
          return false;
      }).toList();
      tempList.sort(compareOnBurst);
      current_time += tempList[0].burst_time;
      tempList[0].completion_time = current_time;
      tempList[0].turnaround_time = tempList[0].completion_time - tempList[0].arrival_time;
      tempList[0].waiting_time = tempList[0].turnaround_time - tempList[0].burst_time;
      readyQueue.removeProcess(tempList[0]);
      tempQueue.clear();
      runningQueue.addProcess(tempList[0]);
      tempList.clear();
    }

    if (runningQueue.isEmpty) {
      print('No process in the running queue');
      processList = [];
    } else
      processList = runningQueue.convertToList();
  }
}
