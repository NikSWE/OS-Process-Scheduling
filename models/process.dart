class Process {
  int process_id;
  int arrival_time;
  int completion_time;
  int burst_time;
  int turnaround_time;
  int waiting_time;

  Process(this.process_id, this.arrival_time, this.burst_time);

  Process.fromProcessInfoList(List<String> processInfo){
    this.process_id = int.parse(processInfo[0]);
    this.arrival_time = int.parse(processInfo[1]);
    this.burst_time = int.parse(processInfo[2]);
  }

  @override
  String toString() {
    return '$process_id  $arrival_time  $burst_time';
  }
}
