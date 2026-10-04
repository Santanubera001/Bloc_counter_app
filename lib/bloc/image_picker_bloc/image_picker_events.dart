

import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable{

  const ImagePickerEvent();

  @override
   List<Object> get props=>[];
}

class GalleryImagePickerEvent extends ImagePickerEvent{}

class CameraCaptureEvent extends ImagePickerEvent{}