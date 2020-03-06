library add_thumbnail;

import 'package:add_thumbnail/src/add_thumbnail_widget.dart';
import 'package:add_thumbnail/src/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A Calculator.
class ThumbnailAdder {
  static Future<String> addLink({
    BuildContext context,
    Function(String) onLinkAdded,
  }) async {
    // BuildContext context1;
    // var builder = Builder(builder: (context){
    //   context1 = context;
    // });
    var link = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
                child: MultiBlocProvider(
              providers: [
                BlocProvider<ThumbnailBloc>(
                  create: (BuildContext context) => ThumbnailBloc(),
                ),
              ],
              child: AddMediaDialogContent(),
            )
                // BlocProvider.value(
                //   value: BlocProvider.of<ThumbnailBloc>(context),
                //   child: AddMediaDialogContent(),

                //   //  AddMediaDialogContent(),
                // ),
                );
          },
        ));
    if (link != null && link.isNotEmpty) {
      onLinkAdded(link);
    }
  }
}
