import '../models/algorithm.dart';
import '../models/process.dart';
import '../models/process_queue.dart';

class SJF extends Algorithm {
  SJF(List<Process> processList) : super.fromProcessList(processList) {
    // sort the process list on the basis of arrival time and burst time
    sortProcessList('burst');
  }

  @override
  void Execute() {
    int current_time;
    for (int burst_time in burstTimeList) {
      if (burst_time == 0) continue;
      readyQueue.addProcessFromIterable(processList.where((Process process) {
        if (process.burst_time == burst_time && !readyQueue.contains(process))
          return true;
        else
          return false;
      }));
    }
    runningQueue.copyProcessQueue(readyQueue);
    Process firstProcess = runningQueue.first;
    current_time = firstProcess.arrival_time;
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
