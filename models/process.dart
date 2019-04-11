class Process {
  int process_id;
  int arrival_time;
  int burst_time;
  int turnaround_time;
  int waiting_time;
  int completion_time;

  Process({this.process_id, this.arrival_time, this.burst_time});

  Process.fromProcessInfo(List<String> processInfo){
    process_id = int.parse(processInfo[0]);
    arrival_time = int.parse(processInfo[1]);
    burst_time = int.parse(processInfo[2]);
  }

  void printProcessInfo(){
    print('${process_id}\t${arrival_time}\t${burst_time}\t${turnaround_time}\t${waiting_time}');
  }

  @override
  String toString() {
    return 'P$process_id  $arrival_time  $burst_time';
  }
}
