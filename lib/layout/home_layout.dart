import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/module/tasks/tasks_screen.dart';
import 'package:todo/shared/component/component.dart';
import 'package:todo/shared/component/constants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: state is! AppGetDatabaseLoadingState
                ? cubit.screens[cubit.currentIndex]
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );

                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                  }
                  return null;
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  labelText: "Task Title",
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Title Must Not be Empty";
                                    }
                                  },
                                  prefix: Icons.title_outlined,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultTextFormField(
                                    readOnly: true,
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    labelText: "Task Date",
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Date Must Not be Empty";
                                      }
                                    },
                                    prefix: Icons.date_range_outlined,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2023-10-30"),
                                      ).then((value) {
                                        print(DateFormat.yMMMd().format(value));

                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                      });
                                    }),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultTextFormField(
                                    readOnly: true,
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    labelText: "Task Time",
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Time Must Not be Empty";
                                      }
                                    },
                                    prefix: Icons.watch_later_outlined,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        print(value.format(context).toString());
                                        timeController.text =
                                            value.format(context).toString();
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                        elevation: 30,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });

                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: bottomItems,
            ),
          );
        },
      ),
    );
  }
}
