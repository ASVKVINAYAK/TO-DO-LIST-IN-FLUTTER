import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Myhomepage extends StatefulWidget {
  @override
  createState() => Todo();

}

class Todo extends State<Myhomepage> {
  List<String> _todoItems = [];
  bool isSwitched = true;
  void _addTodoItem(String task) {
      setState(() => _todoItems.add(task));
  }
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:  Text('SERVICES'),
              actions: <Widget>[
                FlatButton(
                    child: Text('update'),
                    onPressed: () {
                      _pushAddTodoScreen();
                      _removeTodoItem((index));

                    }
                ),
                FlatButton(
                    child:  Text('Delete'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                ),
                FlatButton(
                    child:  Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

// Build the whole list of todo items
  Widget _buildTodoList() {
    return  ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }

      },
    );
  }
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.orange,
      border: Border.all(
          width: 3.0,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(27.0),
      ),
    );
  }
// Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    String s="\n";
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    todoText="=> "+todoText+s+s+s+formattedTime+s+formattedDate;
    return Container(
        margin: const EdgeInsets.all(18.0),
      decoration: myBoxDecoration(),
      child: Card(

          child: ListTile(

    title:  Text(todoText ),
              selected: false,
              trailing: Column(

                  children: <Widget>[

                     Switch(
                      value: isSwitched,

                      onChanged: (value) {
                      onTap: () {
                        setState(() {
                          isSwitched = value;
                        });
                      };
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,

                    ),

                  ],
              ),

              onTap: () => _promptRemoveTodoItem(index)
      ),
    ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("VINAYAK'S TO-DO LIST "),

      ),
      body: _buildTodoList(),
      floatingActionButton:  FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child:  Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
        MaterialPageRoute(
            builder: (context) {
              return  Scaffold(
                  appBar:  AppBar(
                      title:  Text('Add a new task')
                  ),
                  body:  TextField(
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration:  InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }
}
