import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:open_file/open_file.dart';

class FilePage extends StatelessWidget {
  
  List<PlatformFile?> file;
  ValueChanged<PlatformFile> openFile;

  FilePage({Key? key, required this.file,required this.openFile}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Files"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(itemCount: file.length,itemBuilder: (_,index){

            final kb=file[index]!.size/1024;
            final mb=kb/1024;
            final fileSize= mb>=1?'${mb.toStringAsFixed(2)} MB':'${mb.toStringAsFixed(2)} KB';
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 50,width: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Center(
                      child: Text(".${file[index]!.extension}"),
                    ),
                  ),
                  title: Text(file[index]!.name),
                  trailing: Text(fileSize),
                  onTap: (){
                    OpenFile.open(file[index]!.path);
                  },
                ),
               const Divider(color: Colors.black,)
              ],
            );
          }),
        ),
      ),
    );
  }
}