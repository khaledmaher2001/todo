import 'package:flutter/material.dart';
import 'package:todo/shared/component/constants.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String labelText,
  @required Function validator,
  @required IconData prefix,
  Function suffixShow,
  Function onTap,
  bool obscure = false,
  bool readOnly = false,
  IconData suffix,
}) =>
    TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(onPressed: suffixShow, icon: Icon(suffix)),
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                "${model["time"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${model["date"]}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                }),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );
