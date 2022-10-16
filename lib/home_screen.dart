import 'package:todo/model/model.dart';
import 'package:todo/widgets/add_job.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController _taskController=TextEditingController();
  TextEditingController _desController=TextEditingController();
 
List <JobPost> items=[];
int? editIndex;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todoey App'),),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child:Text('${editIndex!=null?'Update':'Add'}'),
        onPressed: (){
            if (_taskController.text.isNotEmpty && _desController.text.isNotEmpty)
            {
                 
           setState(() {
            if (editIndex==null) {
               items.add(JobPost(_taskController.text, _desController.text));
            
            }
            else{
              var exixtingJobIndex=items[editIndex!];
              exixtingJobIndex.task=_taskController.text;
              exixtingJobIndex.description=_desController.text;
              setState(() {
                items[editIndex!]=exixtingJobIndex;
                editIndex=null;
               
              });
             
            }
             [
                _taskController,
                _desController,
              ].forEach((element) {element.clear();});
            
            
            
      
           });
            }
      
        },
        
        ),
      body:Column(
        
        children: [
          SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              
              controller: _taskController,
              decoration:  InputDecoration(

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                
               labelText: 'Task'
              
              ),
          ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: _desController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Description',
              ),
          ),
           ),
           Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:items.isNotEmpty? Text('Your tasks',style: TextStyle(fontSize: 30),):Text(''),
                    ),
         Expanded(
           child: items.isNotEmpty?  ListView.builder(
              itemCount: items.length,
              itemBuilder:(context,index){
                return Card(
                  shape:OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0
                    )
                    
                  ) ,
                  color: Colors.grey.shade100,
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(items[index].task,style: TextStyle(fontSize: 25),),
                            SizedBox(height: 5,),
                            Text(items[index].description ,style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                             setState(() {
                                items.removeAt(index);
                             });
                            },
                            child: const Icon(Icons.delete_forever_sharp,color: Colors.red,size: 35,)),
                           const SizedBox(height: 5,),
                          GestureDetector(
                            onTap: (){
                             setState(() {
                                _taskController.text=items[index].task;
                                _desController.text=items[index].description;
                                
                                editIndex=index;
                                
                             });
                            },
                            child:const Icon(Icons.edit_calendar,color: Colors.green,size: 35,)),
                        ],
                      )
                    ],
                  ),
                );
              },
         
              ):const Center(
          child: Text('Add your task here ',style: TextStyle(fontSize: 40),),
         )
        ),
        ],
      )
    );
  }

  // Navigator.of(context).push(
  //   MaterialPageRoute(builder: (context)=>AddJob())
  //   );
}






  