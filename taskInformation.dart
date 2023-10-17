import 'package:flutter/material.dart';
import 'package:tareas/data/TaskData.dart';
import 'package:tareas/main.dart';

class taskInformation extends StatelessWidget {

  final TaskData? ud;

  const taskInformation({Key? key, this.ud}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        backgroundColor: Color.fromARGB(136, 21, 248, 40),
      ),
      body: Center(
        child: ListView(
          children: [
            Text("Task Information", style: TextStyle(color: Colors.black, fontSize: 30, fontStyle: FontStyle.normal),textAlign: TextAlign.center),
            Text("Title: ${ud?.title}", style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),textAlign: TextAlign.center),
            Text("Description: ${ud?.description}", style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),textAlign: TextAlign.center),
            Text("Date: ${ud?.date.toString()}", style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),textAlign: TextAlign.center),
            Text("Priority: ${ud?.priority}", style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),textAlign: TextAlign.center),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 150,
                  height: 29,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(136, 21, 248, 40))
                    ),
                    child: Text("Exit"),
                    onPressed: () {
                      showAlert(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Register"),
          content: Text("¿Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                TitleController.text = "";
                DescriptionController.text = "";
                DateController.text = "";
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }
}