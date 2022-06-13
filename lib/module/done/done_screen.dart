import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/component/component.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.get(context).doneTasks.length <= 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.playlist_add_check_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "No Done Tasks Yet, Please Done Some Tasks",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => buildTaskItem(
                    AppCubit.get(context).doneTasks[index], context),
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                itemCount: AppCubit.get(context).doneTasks.length);
      },
    );
  }
}
