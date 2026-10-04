
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class PostFetched extends PostEvent{}

class FilterItem extends PostEvent{
  final String startSearch;
  FilterItem(this.startSearch);
}
