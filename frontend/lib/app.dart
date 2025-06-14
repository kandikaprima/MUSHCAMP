import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'logic/detection_bloc/detection_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DetectionBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
