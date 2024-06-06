import 'package:ads_id/text_field.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? advertisingId;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAdsId();
    return Scaffold(
        appBar: AppBar(
          title: Text("Ads id"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(advertisingId ?? "Loading..."),
              const SizedBox(height: 20),
              MyTextField(
                hint: "Enter your phone number",
                icon: Icons.phone,
                inputType: TextInputType.phone,
                controller: controller,
              ),
              const SizedBox(height: 20),
              MyButton(
                press: () async {
                  advertisingId = await AdvertisingId.id(true);
                  print(advertisingId);
                  setState(() {});
                  if (advertisingId == null || controller.text.isEmpty) {
                    return;
                  }
                  var res = await Dio()
                      .post("https://idp.hawkops.io/api/v1/advertising", data: {
                    "phone_number": controller.text,
                    "advertising_id": advertisingId,
                  });
                  print(res.data);
                  if (res.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Submitted successfully")));
                  }
                },
                text: "Submit",
              )
              // Text(advertisingId ?? "Loading..."),
            ],
          ),
        ));
  }

  void getAdsId() async {
    try {
      advertisingId = await AdvertisingId.id(true);
      setState(() {});
    } on PlatformException {
      advertisingId = null;
    }
  }
}
