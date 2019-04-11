import 'dart:collection';

import 'process.dart';

class ProcessQueue extends Iterable {
  Queue<Process> _queue;

  ProcessQueue() {
    _queue = Queue();
  }

  ProcessQueue.fromProcessList(List<Process> processList) {
    _queue = Queue.from(processList);
  }

  void addProcess(Process process) {
    _queue.add(process);
  }

  void addProcessFromIterable(Iterable<Process> processIterable) {
    for (Process process in processIterable) {
      _queue.add(process);
    }
  }

  void removeProcess(Process process) {
    _queue.remove(process);
  }

  List<Process> convertToList() {
    return _queue.toList();
  }

  @override
  String toString() {
    if (_queue.isEmpty) return 'Queue is empty!';
    List<String> processIdList = [];
    _queue.forEach((Process process) {
      processIdList.add('P${process.process_id}');
    });
    return processIdList.toString();
  }

  @override
  Iterator get iterator => _queue.iterator;
}
