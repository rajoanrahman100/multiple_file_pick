import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker_example/file_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


class HomePage extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("File Picker"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MaterialButton(minWidth: 200.0,onPressed:()async{
                
                final results=await FilePicker.platform.pickFiles();
                if(results==null){
                  log("No File Pick Up");
                  return;
                }
                else{
                  final file=results.files.first;
                  // log("Name: ${file.name}");
                  // log("Size: ${file.size}");
                  // log("Byte: ${file.bytes}");
                  // log("Path: ${file.path}");

                  final newFile=await saveFilePermanantly(file);

                  log("new File: ${newFile!.path}");
                  log("old File: ${file.path}");
                  //openFile(file);
                }

              },color: Colors.amber,shape: const StadiumBorder(),child: const Text("Pick File"),),

              MaterialButton(onPressed:()async{
                final results=await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  //Custom type file
                   
                  // type: FileType.custom,
                  // allowedExtensions: ['pdf','mp4']
                  );
                if(results==null){
                  log("No File Pick Up");
                  return;
                }
                else{
                  openMultipleFile(context, results.files);
                }
              },color: Colors.blueAccent,minWidth: 200,shape:const StadiumBorder(),child: const Text("Pick Multiple File"),)
            ],
          ),
        ),
      ),

    );
    
  }

  void openFile(PlatformFile file){
    OpenFile.open(file.path);
  }

  //Open multiple files
  void openMultipleFile(BuildContext context,List<PlatformFile?> files){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>FilePage(file: files,openFile: openFile,)));
  }

  //Save the file permanantly

  Future<File?> saveFilePermanantly(PlatformFile file)async{
    final appStorage=await getApplicationDocumentsDirectory();
    final newFile=File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

}
