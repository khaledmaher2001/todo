import 'package:flutter/material.dart';
import 'package:todo/module/archived/archived_screen.dart';
import 'package:todo/module/done/done_screen.dart';
import 'package:todo/module/tasks/tasks_screen.dart';

List<BottomNavigationBarItem> bottomItems = [
  BottomNavigationBarItem(
    label: 'Tasks',
    icon: Icon(Icons.work_outline),
  ),
  BottomNavigationBarItem(
    label: 'Done',
    icon: Icon(Icons.done),
  ),
  BottomNavigationBarItem(
    label: 'Archived',
    icon: Icon(Icons.archive_outlined),
  ),
];
