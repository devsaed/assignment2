import 'package:flutter/material.dart';

import 'Task.dart';
import 'TaskMock.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('ToDo App'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text(
                'All Tasks',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              child: Text(
                'Completed',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              child: Text(
                'Uncompleted',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: task
                  .map((e) => TermsWidget(e, () {
                        setState(() {});
                      }))
                  .toList(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: task
                  .where((element) => element.isComplete)
                  .map((e) => TermsWidget(e, () {
                        setState(() {});
                      }))
                  .toList(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: task
                  .where((element) => !element.isComplete)
                  .map((e) => TermsWidget(e, () {
                        setState(() {});
                      }))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsWidget extends StatefulWidget {
  Task task;
  Function fun;

  TermsWidget(this.task, this.fun);

  @override
  _TermsWidgetState createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.task.color == bgTask.red ? Colors.red : Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.task.title,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Checkbox(
              value: widget.task.isComplete,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (val) {
                setState(() {
                  widget.task.isComplete = val;
                  val
                      ? widget.task.color = bgTask.green
                      : widget.task.color = bgTask.red;
                });
                widget.fun();
              })
        ],
      ),
    );
  }
}

enum bgTask { red, green }
