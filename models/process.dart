class Process {
  int process_id; // process id of a process
  int arrival_time; // arrival time of a process
  int burst_time; // burst time of a process
  int turnaround_time; // turnaround time of a process
  int waiting_time; // waiting time of a process
  int completion_time; // completion time of a process

  Process({this.process_id, this.arrival_time, this.burst_time});

  Process.fromProcessInfo(List<String> processInfo) {
    process_id = int.parse(processInfo[0]);
    arrival_time = int.parse(processInfo[1]);
    burst_time = int.parse(processInfo[2]);
  }

  /// Print the process's detailed information
  void printProcessInfo() {
    print('${process_id}\t${arrival_time}\t${burst_time}\t${turnaround_time}\t${waiting_time}');
  }

  @override
  String toString() {
    return 'P$process_id  $arrival_time  $burst_time';
  }
}
