import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tareas/data/TaskData.dart';
import 'package:tareas/pages/taskInformation.dart';

void main() {
  runApp(MyApp());
}

TextEditingController DateController = TextEditingController();
TextEditingController TitleController = TextEditingController();
TextEditingController DescriptionController = TextEditingController();
String dropwdowncurrentvalue = "High";

final _formKey = GlobalKey<FormState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Register",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    DateController.text = "";
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 250, 244, 244)),
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleApp(),
              TextField(
                controller: TitleController,
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  labelText: "Enter the task name"),
              ),
              TextField(
                controller: DescriptionController,
                decoration: InputDecoration(
                  icon: Icon(Icons.comment),
                  labelText: "Enter the task description"),
              ),
              TextField(
                controller: DateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Select the date"
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (context, child){
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            primarySwatch: Colors.green
                          ),
                        ), 
                        child: child!,
                      );
                    }
                  );
                  if(pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      DateController.text = formattedDate;
                    });
                  }else{
                    null;
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.priority_high_outlined),
                  suffixIcon: DropdownButtonFormField<String>(
                    items: [
                      DropdownMenuItem(
                        child: Text("High Priority"),
                        value: "High",
                      ),
                      DropdownMenuItem(
                        child: Text("Medium Priority"),
                        value: "Medium",
                      ),
                      DropdownMenuItem(
                        child: Text("Low Priority"),
                        value: "Low",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropwdowncurrentvalue = value.toString();
                      });
                    },
                  )
                ),
              ),
              options(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleApp() {
  return Center(
    child: Text(
      "Register your task",
      style: TextStyle(
        color: Colors.black, fontSize: 30, fontStyle: FontStyle.normal
      ),
    ),
  );
}

Widget registryTask(BuildContext context) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(136, 21, 248, 40))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.app_registration),
            SizedBox(
              width: 7,
            ),
            Text("Register Task"),
          ],
        ),
        onPressed: () {
          if (TitleController.text.isEmpty || DescriptionController.text.isEmpty || DateController.text.isEmpty) {
            AlertDialog alerta = AlertDialog(
              title: Text("Task Register"),
              content: Text("Fill out all the fields"),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    TitleController.text = "";
                    DescriptionController.text = "";
                    DateController.text = "";
                    Navigator.pop(context);
                  },
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (context) => alerta,
            );
          }else{
            AlertDialog _alerta = AlertDialog(
              title: Text("Task Register"),
              content: Text("The task has been successfully registered"),
              actions: [
                TextButton(
                  child: Text("Aceptar"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/taskInformation', );
                  },
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (context) => _alerta,
            );
          }
        },
      )
    )
  );
}

Widget options(BuildContext context) {
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        viewTasks(context),
        SizedBox(
          width: 10,
        ),
        registryTask(context)
      ],
    ),
  );
}

Widget viewTasks(BuildContext context) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(136, 21, 248, 40))
        ),
        child: Row(
          children: [
            Icon(Icons.remove_red_eye),
            SizedBox(
              width: 7,
            ),
            Text("View Tasks"),
          ],
        ),
        onPressed: () {
          if (TitleController.text.isEmpty || DescriptionController.text.isEmpty || DateController.text.isEmpty){
            AlertDialog alerta = AlertDialog(
              title: Text("Task Register"),
              content: Text("Fill out all the fields"),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    TitleController.text = "";
                    DescriptionController.text = "";
                    DateController.text = "";
                    Navigator.pop(context);
                  },
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (context) => alerta,
            );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => taskInformation(
                  ud: TaskData(
                    title: TitleController.text,
                    description: DescriptionController.text,
                    date: DateTime.parse(DateController.text),
                    priority: dropwdowncurrentvalue
                  )
                )
              )
            );
          }
        },
      )
    )
  );
}