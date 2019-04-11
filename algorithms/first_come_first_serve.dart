import '../models/algorithm.dart';
import '../models/process.dart';
import '../models/process_queue.dart';

class FCFS extends Algorithm {
  FCFS(List<Process> processList) : super.fromProcessList(processList) {
    sortProcessList('arrival');
    readyQueue = ProcessQueue();
    runningQueue = ProcessQueue();
  }

  void Execute() {
    int i = 0;
    List<Process> toRemove = [];
    for (Process process in processList) {
      runningQueue.addProcessFromIterable(processList.where((Process process) {
        if (process.arrival_time == i && process.burst_time != 0)
          return true;
        else
          return false;
      }));
      toRemove.add(process);
      i++;
    }
    processList.removeWhere((Process process) => toRemove.contains(process));
    i = 0;
    for (Process process in runningQueue) {
      if (runningQueue.isEmpty) print('empty');
      i += process.burst_time;
      process.completion_time = i;
      process.turnaround_time = process.completion_time - process.arrival_time;
      process.waiting_time = process.turnaround_time - process.burst_time;
    }
    processList = runningQueue.convertToList();
  }

  void printGanttChart() {
    super.GanttChart(processList);
  }
}
