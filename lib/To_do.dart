import 'Todo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class To_do extends StatefulWidget {
  const To_do({super.key});

  @override
  State<To_do> createState() => _To_doState();
}

class _To_doState extends State<To_do> {
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDo>(context, listen: false);
    print('build');
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.amber,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SearchBox(),
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'To Do List',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: Consumer<ToDo>(
                        builder: (context, value, child) => ListView(
                          children: [
                            for (ToDo list in value.LIST) ListItems(todo: list)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, right: 15, left: 15),
                        child: TextField(
                          controller: content,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(13),
                              border: InputBorder.none,
                              hintText: 'Add to do task'),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 12, left: 1),
                      child: ElevatedButton(
                        onPressed: () {
                          provider.ToAddItem(content.text);
                          content.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(60, 60)),
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  //Search b
  Widget SearchBox() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          onChanged: (value) {
            Provider.of<ToDo>(context, listen: false).runfilter(value);
          },
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
              contentPadding: EdgeInsets.all(0),
              hintText: 'search',
              hintStyle: TextStyle(color: Colors.black, fontSize: 22),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ));
  }

  // App bar
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white24,
      leading: Icon(
        Icons.menu,
        color: Colors.black87,
        size: 34,
      ),
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }
}

//List Items

class ListItems extends StatelessWidget {
  final ToDo todo;
  ListItems({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    final provider_1 = Provider.of<ToDo>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 8, left: 8),
      child: ListTile(
        onTap: () {
          // print('Clicked on todo item ');
          print(todo.isDone);
          provider_1.sethandleToDoChanged(todo);
          print(todo.isDone);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        leading: Icon(
          todo.isDone == true ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          todo.todoText.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            decoration: todo.isDone == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            provider_1.setOnDeleteItem(todo.id.toString());
          },
        ),
      ),
    );
  }
}
