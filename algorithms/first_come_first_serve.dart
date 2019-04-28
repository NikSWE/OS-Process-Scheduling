import '../models/process.dart';
import '../models/process_queue.dart';
import '../models/algorithm.dart';

class FCFS with Algorithm {
  FCFS(List<Process> processList) {
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
