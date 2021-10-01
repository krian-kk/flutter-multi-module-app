import 'package:flutter/cupertino.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_text.dart';

class MapView extends StatefulWidget {
  final AllocationBloc bloc;
  MapView(this.bloc, {Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.84,
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  children: [
                    CustomAppbar(
                      titleString: 'Map View',
                      showClose: true,
                    )
                  ],
                ),
              )
              );
              });
  }
}