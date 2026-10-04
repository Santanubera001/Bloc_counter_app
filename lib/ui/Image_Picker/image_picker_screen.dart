
import 'dart:io';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_events.dart';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Image Picker"),
      ),
      body:
      // Center(
      //   child: BlocBuilder<ImagePickerBloc,ImagePickerStates>(builder:(context,state){
      //    if(state.file==null)
      //      {
      //        return InkWell(
      //          onTap: (){
      //            context.read<ImagePickerBloc>().add(GalleryImagePickerEvent());
      //          },
      //          child: CircleAvatar(
      //            child: Icon(Icons.camera_alt_outlined),
      //          ),
      //        );
      //      }
      //    else{
      //      return  Image.file(File(state.file!.path.toString()));
      //    }
      //   }
      //   ),
      // ),
      Center(
        child: BlocBuilder<ImagePickerBloc , ImagePickerStates>(
            builder: (context, state){
              return state.file == null ? InkWell(
                onTap: (){
                  context.read<ImagePickerBloc>().add(GalleryImagePickerEvent());
                },
                child: const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.camera),

                ),
              ) : Image.file(File(state.file!.path.toString()),height: 200,width: 200,);
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
      ),
    );
  }
}
