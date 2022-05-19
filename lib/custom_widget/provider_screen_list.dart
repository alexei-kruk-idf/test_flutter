import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/custom_widget/builder_data.dart';
import 'package:test_flutter/custom_widget/list_data.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ListData(),
        child: Consumer<ListData>(
          builder: (context, value, child) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  Provider.of<ListData>(context).list[index],
                              separatorBuilder: (context, index) => Divider(),
                              itemCount:
                                  Provider.of<ListData>(context).list.length),
                        ),
                        ElevatedButton(
                            onPressed: () =>
                                Provider.of<ListData>(context, listen: false)
                                    .add(
                                  Center(
                                    child: Text(
                                      Provider.of<ListData>(
                                        context,
                                        listen: false,
                                      ).list.length.toString(),
                                    ),
                                  ),
                                ),
                            child: Text('Add'))
                      ]),
                ),
              ),
            );
          },
        ));
  }
}
