import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_n1/pages/tasks.dart';
import 'package:flutter_n1/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tarefacontrolador = TextEditingController();
  TextEditingController dificuldadecontrolador = TextEditingController();
  TextEditingController pontoscontrolador = TextEditingController();
  Stream? TaskStream;

  getontheload() async {
    TaskStream = await DataBaseMethods().getTaskdetalhes();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allTaskDetails() {
    return StreamBuilder(
      stream: TaskStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Tarefa : " + ds["Tarefa"],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        tarefacontrolador.text = ds["Tarefa"];
                                        dificuldadecontrolador.text =
                                            ds["Dificuldade"];
                                        pontoscontrolador.text = ds["Pontos"];
                                        EditTaskDetail(ds["ID"]);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      )),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      await DataBaseMethods().deteleTask(ds["ID"]);
                                    },
                                    child: Icon(Icons.delete, color: Colors.red))
                                ],
                              ),
                              Text(
                                "Dificuldade : " + ds["Dificuldade"],
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Pontos :" + ds["Pontos"],
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ));
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Tasks()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faxi",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Nex",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allTaskDetails()),
          ],
        ),
      ),
    );
  }

  Future EditTaskDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel)),
                      SizedBox(
                        width: 60.0,
                      ),
                      Text(
                        "Editar ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Tarefa",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Tarefa",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: tarefacontrolador,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Dificuldade",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: dificuldadecontrolador,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Pontos",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: pontoscontrolador,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> updateinfo = {
                              "Tarefa": tarefacontrolador.text,
                              "Dificuldade": dificuldadecontrolador.text,
                              "ID": id,
                              "Pontos": pontoscontrolador.text,
                            };
                            await DataBaseMethods()
                                .updateTaskDetail(id, updateinfo)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Editar Tarefa")))
                ],
              ),
            ),
          ));
}
