
import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_events.dart';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_states.dart';
import 'package:bloc_counter_app/utlis/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent,ImagePickerStates> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils):super(ImagePickerStates()){
   on<CameraCaptureEvent>(cameraCapture);
   on<GalleryImagePickerEvent>(galleryImagePickerEvent);

  }

   void cameraCapture(CameraCaptureEvent event,Emitter<ImagePickerStates>emit)async{
    XFile? file=await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
   }


  void galleryImagePickerEvent(GalleryImagePickerEvent event,Emitter<ImagePickerStates>emit) async {
    XFile? file=await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}