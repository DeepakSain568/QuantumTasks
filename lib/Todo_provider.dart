import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class ToDo extends ChangeNotifier {
  String? id;
  String? todoText;
  bool isDone;
  List<ToDo> result = [];
  ToDo({
    this.id,
    this.todoText,
    this.isDone = false,
  });

  List<ToDo> todoList = [];
  List<ToDo> get LIST => result;
  void sethandleToDoChanged(ToDo todo) {
    print('_handleToDoChanged');
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void setOnDeleteItem(String id) {
    print('_onDeleteItem');
    todoList.removeWhere((item) => item.id == id);
    print(todoList);
    notifyListeners();
  }

  List<ToDo> _list() {
    return List.from(todoList);
  }

  void ToAddItem(String text) {
    print('_ToAddItem');
    todoList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: text));
    result = todoList;
    notifyListeners();
    print(todoList);
  }

  void runfilter(String Enteredtext) {
    if (Enteredtext.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(Enteredtext.toLowerCase()))
          .toList();
    }
    print("result list $result");
    notifyListeners();
  }
}
