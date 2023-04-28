import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../widgets/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseCrashlytics.instance
                        .setCustomKey('example', 'flutterfire');
                    CustomWidgets.buildSnackBar(
                      context,
                      'Custom Key "example: flutterfire" has been set. \n'
                      'Key will appear in Firebase Console once an error has been reported.',
                    );
                  },
                  child: const Text('Set Custom Key'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseCrashlytics.instance.log('This is a log example');
                    CustomWidgets.buildSnackBar(
                      context,
                      'The message "This is a log example" has been logged. \n'
                      'Message will appear in Firebase Console once an error has been reported.',
                    );
                  },
                  child: const Text('Show Log in Firebase'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    CustomWidgets.buildSnackBar(
                      context,
                      'App will crash is 5 seconds \n'
                      'Please reopen to send data to Crashlytics',
                    );
                    sleep(
                      const Duration(seconds: 5),
                    );
                    FirebaseCrashlytics.instance.crash();
                  },
                  child: const Text('Crashlytics Crash'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    CustomWidgets.buildSnackBar(
                      context,
                      'Thrown error has been caught and sent to Crashlytics.',
                    );
                    throw StateError('Uncaught error thrown by app');
                  },
                  child: const Text('Throw Error'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      CustomWidgets.buildSnackBar(
                        context,
                        'Recorded Fatal Error',
                      );
                      throw Error();
                    } catch (e, s) {
                      await FirebaseCrashlytics.instance.recordError(
                        e,
                        s,
                        reason: 'as an example of fatal error',
                        fatal: true,
                      );
                    }
                  },
                  child: const Text('Record Fatal Error'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      CustomWidgets.buildSnackBar(
                        context,
                        'Recorded Non-Fatal Error',
                      );
                      throw Error();
                    } catch (e, s) {
                      await FirebaseCrashlytics.instance.recordError(
                        e,
                        s,
                        reason: 'as an example of non-fatal error',
                      );
                    }
                  },
                  child: const Text('Record Non-Fatal Error'),
                ),
              ],
            ),
          ),
        ),
      );
}
