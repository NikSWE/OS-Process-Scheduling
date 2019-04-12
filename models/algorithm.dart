import 'process.dart';
import 'process_queue.dart';

abstract class Algorithm {
  /// average turnaround time taken by the algorithm
  int avg_turnaround_time;

  /// average waiting time taken by the algorithm
  int avg_waiting_time;

  /// contains processes ready for execution by CPU
  ProcessQueue readyQueue;

  /// contains processes executed by CPU
  ProcessQueue runningQueue;

  /// processes to be scheduled by OS
  List<Process> processList;

  Algorithm();

  Algorithm.fromProcessList(this.processList);

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

  /// generate Gantt Chart for the given process list
  void GanttChart(List<Process> processList) {
    print('*************** Gantt Chart ***************');
    print('P_ID\tP_AT\tP_BT\tP_TAT\tP_WT');
    processList.forEach((Process process) {
      process.printProcessInfo();
    });
    print('*******************************************');
  }
}
