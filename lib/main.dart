import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/product_provider.dart';
import 'providers/theme_provider.dart';
import 'routes/app_router.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const ProductCatalogueApp());
}

class ProductCatalogueApp extends StatelessWidget {
  const ProductCatalogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          final themeProvider = context.watch<ThemeProvider>();
          return MaterialApp.router(
            title: 'Product Catalogue',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
