import '../models/algorithm.dart';
import '../models/process.dart';
import '../models/process_queue.dart';

class FCFS extends Algorithm {
  FCFS(List<Process> processList) : super.fromProcessList(processList) {
    // sort the process list on the basis of arrival time
    sortProcessList('arrival');
    
    for (Process process in super.processList) {
      arrivalTimeList.add(process.arrival_time);
    }
    readyQueue = ProcessQueue();
    runningQueue = ProcessQueue();
  }

  @override
  void Execute() {
    int current_time;
    for (int arrival_time in arrivalTimeList) {
      readyQueue.addProcessFromIterable(processList.where((Process process) {
        if (process.arrival_time == arrival_time && process.burst_time != 0)
          return true;
        else
          return false;
      }));
    }
    runningQueue.copyProcessQueue(readyQueue);
    current_time = 0;
    for (Process process in runningQueue) {
      if (runningQueue.isEmpty) print('empty');
      current_time += process.burst_time;
      process.completion_time = current_time;
      process.turnaround_time = process.completion_time - process.arrival_time;
      process.waiting_time = process.turnaround_time - process.burst_time;
    }
    processList = runningQueue.convertToList();
  }

  /// Prints the Gantt Chart for the implemented algorithm
  void printGanttChart() {
    super.GanttChart(processList);
  }
}
