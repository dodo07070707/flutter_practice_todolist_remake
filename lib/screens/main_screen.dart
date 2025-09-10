import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int kPrimaryColor = 0xFFF6AD02;

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> todos = [];
  String title = "";
  String searching = "";
  void toggleTodoCompleted(int index) {
    setState(() {
      todos[index]['completed'] =
          !(todos[index]['completed'] as bool? ?? false);
    });
    if (todos[index]['completed']) {
      // 완료된 아이템을 리스트의 맨 아래로 이동
      Map<String, dynamic> completedTodo = todos.removeAt(index);
      todos.add(completedTodo);
    }
    if (!todos[index]['completed']) {
      // 완료되지 않은 아이템을 리스트의 맨 위로 이동
      Map<String, dynamic> incompleteTodo = todos.removeAt(index);
      todos.insert(0, incompleteTodo);
    }
  }

  void removeTodoItem(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.white,
          ),
          child: AlertDialog(
            title: Text(
              "투두리스트 추가",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type Title",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    // 입력중 text color
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text("Ok"),
                onPressed: () {
                  setState(() {
                    todos.insert(0, {
                      'title': title,
                      'completed': false, // 'completed' 값을 false로 초기화
                    });
                  });
                  // 다이얼로그 닫기
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "src/image.png",
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color(0XFFD3D8DB),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'me',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color(0XFFD3D8DB),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'you',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "src/image1.png",
                  width: 322,
                  height: 260,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 105,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'src/box.png',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '먹을거',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: _showDialog,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = todos[index];
                      final bool isCompleted =
                          todo['completed'] ?? false; //할 일이 완료되었는지 여부
                      return SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: Image.asset(
                                isCompleted ? "src/yet.png" : "src/nonyet.png",
                                width: 35,
                                height: 35,
                              ),
                              onTap: () => toggleTodoCompleted(index),
                            ),
                            SizedBox(width: 5),
                            Text(
                              todo['title'] ?? '',
                              style: TextStyle(
                                color: isCompleted ? Colors.grey : Colors.black,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
