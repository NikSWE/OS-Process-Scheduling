import 'dart:collection';

class ProcessQueue {
  Queue _queue;

  ProcessQueue() {
    _queue = Queue();
  }

  ProcessQueue.fromProcessList(List<String> processList) {
    _queue = Queue.from(processList);
  }
}
