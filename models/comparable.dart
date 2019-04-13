import 'process.dart';

int compareOnArrival(Process a, Process b) {
  if (a.arrival_time < b.arrival_time)
    return -1;
  else if (a.arrival_time == b.arrival_time) {
    if (a.process_id > b.process_id)
      return 1;
    else
      return 0;
  } else
    return 1;
}

int compareOnBurst(Process a, Process b) {
  if (a.burst_time < b.burst_time)
    return -1;
  else if (a.burst_time == b.burst_time) {
    return 0;
  } else
    return 1;
}

int compareOnArrivalAndBurst(Process a, Process b) {
  if (a.arrival_time < b.arrival_time)
    return -1;
  else if (a.arrival_time == b.arrival_time) {
    if (a.burst_time > b.burst_time)
      return 1;
    else
      return 0;
  } else
    return 1;
}
