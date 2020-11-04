import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {}
    setState(() => _todoItems.add(task));
  }

  void addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => addTaskTodo(),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mark "${_todoItems[index]}" as done?'),
            actions: [
              FlatButton(
                child: Text('Cancle'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                  child: Text('Mark as done'),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return Container(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: ListTile(
        title: Text(todoText),
        trailing: GestureDetector(
            onTap: () => _promptRemoveTodoItem(index),
            child: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16.0),
                color: Colors.blue,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.yellow,
                      child: Text(
                        'Todo',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'ly',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 1.5),
                      child: _buildTodoList(),
//                      ListView.builder(
//                        itemCount: 10,
//                        shrinkWrap: true,
//                        itemBuilder: (context, index) => Container(
//                          margin: EdgeInsets.all(14),
//                          padding: EdgeInsets.all(14),
//                          color: Colors.white,
//                          child: ListTile(
//                            title: Text(
//                              'Call a friend',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w700, fontSize: 18),
//                            ),
//                            trailing: Icon(Icons.delete, color: Colors.red),
//                          ),
//                        ),
//                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addTaskTodo() {
    return Container(
      padding: EdgeInsets.all(16),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'Enter something',
            ),
          ),
          GestureDetector(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    color: Colors.blue,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Add Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
