import 'dart:collection';

import 'process.dart';

class ProcessQueue extends Iterable {
  /// Queue to manage processes in the system
  Queue<Process> _queue;

  ProcessQueue() {
    _queue = Queue();
  }

  ProcessQueue.fromProcessList(List<Process> processList) {
    _queue = Queue.from(processList);
  }

  /// Adds a process to process queue
  void addProcess(Process process) {
    _queue.add(process);
  }

  void addProcessFromIterable(Iterable<Process> processIterable) {
    for (Process process in processIterable) {
      _queue.add(process);
    }
  }

  /// Removes a process from the process queue
  void removeProcess(Process process) {
    _queue.remove(process);
  }

  /// Copy the contents of one process queue to another
  void copyProcessQueue(ProcessQueue processQueue){
    _queue = Queue.from(processQueue);
  }

  /// Converts process queue to List of processes
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
