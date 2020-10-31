import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_nav.dart';
import 'bottom_nav_view.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: ButtomNavView(),
    );
  }
}
