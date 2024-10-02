import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {


  //CREAT
  Future addDetalheTarefa(Map<String, dynamic> infoTarefaMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Tarefa")
        .doc(id)
        .set(infoTarefaMap);
  }
  //READ
  Future<Stream<QuerySnapshot>> getTaskdetalhes() async {
    return await FirebaseFirestore.instance.collection("Tarefa").snapshots();
  }

  //UPDATE
  Future updateTaskDetail(String id, Map<String, dynamic> updateinfo)async{
    return await FirebaseFirestore.instance.collection("Tarefa").doc(id).update(updateinfo);
  }

  //DELETE
  Future deteleTask(String id)async{
    return await FirebaseFirestore.instance.collection("Tarefa").doc(id).delete();
  }
}
