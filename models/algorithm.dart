import 'process.dart';
import 'process_queue.dart';
import 'comparable.dart';

mixin Algorithm {
  /// average turnaround time taken by the algorithm
  double _avg_turnaround_time;

  /// average waiting time taken by the algorithm
  double _avg_waiting_time;

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
    _avg_turnaround_time = 0.0;
    for (Process process in runningQueue) {
      _avg_turnaround_time += process.turnaround_time;
    }
    return (_avg_turnaround_time /= runningQueue.length);
  }

  // Get the avg_waiting_time for the algorithm
  double get avg_waiting_time {
    _avg_waiting_time = 0.0;
    for (Process process in runningQueue) {
      _avg_waiting_time += process.waiting_time;
    }
    return (_avg_waiting_time /= runningQueue.length);
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
