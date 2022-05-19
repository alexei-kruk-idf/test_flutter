import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/custom_widget/builder_data.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BuilderData(),
        child: Consumer<BuilderData>(
          builder: (context, value, child) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          if (Provider.of<BuilderData>(context).count % 2 ==
                              0) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.red,
                            );
                          } else {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.blue,
                            );
                          }
                        },
                      ),
                      ElevatedButton(
                          onPressed:
                              Provider.of<BuilderData>(context, listen: false)
                                  .inc,
                          child: Text('Inc'))
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
