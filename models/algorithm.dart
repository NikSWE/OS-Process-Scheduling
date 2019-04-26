import 'process.dart';
import 'process_queue.dart';
import 'comparable.dart';

abstract class Algorithm {
  /// average turnaround time taken by the algorithm
  double _avg_turnaround_time = 0.0;

  /// average waiting time taken by the algorithm
  double _avg_waiting_time = 0.0;

  /// contains processes ready for execution by CPU
  ProcessQueue readyQueue;

  /// contains processes executed by CPU
  ProcessQueue runningQueue;

  /// processes to be scheduled by OS
  List<Process> processList;

  /// arrival time of all the processes
  List<int> arrivalTimeList;

  /// burst time of all the processes
  List<int> burstTimeList;

  Algorithm();

  Algorithm.fromProcessList(List<Process> processList) {
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
  }

  /// sort process list on the basis of `'arrival', 'burst', 'both'`
  bool sortProcessList(String sortBasis) {
    // check basis on which sorting will be performed
    if (sortBasis == 'arrival') {
      processList.sort(compareOnArrival);
      return true;
    } else if (sortBasis == 'burst') {
      processList.sort(compareOnBurst);
      return true;
    } else if (sortBasis == 'both') {
      processList.sort(compareOnArrivalAndBurst);
      return true;
    } else
      return false;
  }

  // Get the avg_turnaround_time for the algorithm
  double get avg_turnaround_time {
    for (Process process in processList) {
      _avg_turnaround_time += process.turnaround_time;
    }
    return (_avg_turnaround_time /= processList.length);
  }

  // Get the avg_waiting_time for the algorithm
  double get avg_waiting_time {
    for (Process process in processList) {
      _avg_waiting_time += process.waiting_time;
    }
    return (_avg_waiting_time /= processList.length);
  }

  /// generate Gantt Chart for the given process list
  void printGanttChart() {
    return null;
  }

  /// executes the algorithm to schedule the processes in the system
  void Execute() {
    return null;
  }
}
