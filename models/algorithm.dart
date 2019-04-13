import 'process.dart';
import 'process_queue.dart';

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

  Algorithm();

  Algorithm.fromProcessList(List<Process> processList) {
    this.processList = List.from(processList);
    this.arrivalTimeList = [];
    for (Process process in this.processList) {
      arrivalTimeList.add(process.arrival_time);
    }
    arrivalTimeList.sort();
  }

  /// sort process list on the basis of `'arrival', 'burst', 'both'`
  bool sortProcessList(String sortBasis) {
    // check basis on which sorting will be performed
    if (sortBasis == 'arrival') {
      processList.sort((Process a, Process b) {
        if (a.arrival_time < b.arrival_time)
          return -1;
        else if (a.arrival_time == b.arrival_time) {
          if (a.process_id > b.process_id)
            return 1;
          else
            return 0;
        } else
          return 1;
      });
      return true;
    } else if (sortBasis == 'burst') {
      processList.sort((Process a, Process b) {
        if (a.burst_time < b.burst_time)
          return -1;
        else if (a.burst_time == b.burst_time) {
          return 0;
        } else
          return 1;
      });
      return true;
    } else if (sortBasis == 'both') {
      processList.sort((Process a, Process b) {
        if (a.arrival_time < b.arrival_time)
          return -1;
        else if (a.arrival_time == b.arrival_time) {
          if (a.burst_time > b.burst_time)
            return 1;
          else
            return 0;
        } else
          return 1;
      });
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
  void GanttChart(List<Process> processList) {
    print('************************* Gantt Chart *************************');
    print('P_ID\tP_AT\tP_BT\tP_TAT\tP_WT');
    processList.forEach((Process process) {
      process.printProcessInfo();
    });
    print('***************************************************************');
    print('Avg Turnaround Time = ${this.avg_turnaround_time}\tAvg Waiting Time = ${this.avg_waiting_time}');
    print('***************************************************************');
  }

  /// executes the algorithm to schedule the processes in the system
  void Execute(){
    return null;
  }
}
