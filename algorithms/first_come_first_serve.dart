import '../models/process.dart';
import '../models/algorithm.dart';

class FCFS extends Algorithm {
  FCFS(List<Process> processList) : super.fromProcessList(processList) {
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
      print('Avg Turnaround Time = ${avg_turnaround_time}\tAvg Waiting Time = ${avg_waiting_time}');
      print('***************************************************************');
    }
  }

  @override
  void Execute() {
    for (int arrival_time in arrivalTimeList) {
      readyQueue.addProcessFromIterable(processList.where((Process process) {
        // find all the process's where arrival time is same, burst time is not 0 and ready queue doen't already contain it
        if (process.arrival_time == arrival_time && process.burst_time != 0 && !readyQueue.contains(process))
          return true;
        else
          return false;
      }));
    }
    runningQueue.copyProcessQueue(readyQueue);
    int current_time = arrivalTimeList[0];
    for (Process process in runningQueue) {
      current_time += process.burst_time;
      process.completion_time = current_time;
      process.turnaround_time = process.completion_time - process.arrival_time;
      process.waiting_time = process.turnaround_time - process.burst_time;
    }
    if (runningQueue.isEmpty) {
      print('No process in the running queue');
      processList = [];
    } else
      processList = runningQueue.convertToList();
  }
}
