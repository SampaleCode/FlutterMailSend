import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Mail Send',
      home: MailSend(),
    );
  }
}

class MailSend extends StatefulWidget {
  const MailSend({Key? key}) : super(key: key);

  @override
  State<MailSend> createState() => _MailSendState();
}

class _MailSendState extends State<MailSend> {
  final toMailController = TextEditingController();
  final subjectController = TextEditingController();
  final textController = TextEditingController();

  Future<void> sendMail() async {
    String username = "arpicoit@gmail.com"; // Your Email
    String password = "vefndppmoyvsrjrk"; // Your Email Password

    //Create Gmail Server
    final smtpServer = gmail(username, password);

    // Create Gmail Message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(toMailController.text)
      //..ccRecipients.addAll(['abc@gmail.com','pqr@gmail.com','...'])
      //..bccRecipients.add('...')
      ..subject = subjectController.text
      ..text = textController.text;

    try {
      final sendReport = await send(message, smtpServer).then((value) => clear());
      print('Message Sent:' + sendReport.toString());
    } catch (e) {
      print('Message not sent:' + e.toString());
    }
  }

  clear() {
    toMailController.text = '';
    subjectController.text = '';
    textController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mail Send')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: toMailController,
              decoration: InputDecoration(
                hintText: "Please Enter To Mail Address",
                labelText: "To Mail",
              ),
            ),
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: "Please Enter Subject",
                labelText: "Subject",
              ),
            ),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Please Enter Text",
                labelText: "Text",
              ),
              minLines: 5,
              maxLines: 8,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: sendMail,
                      icon: Icon(Icons.send),
                      label: Text('Send')),
                  TextButton.icon(
                      onPressed: clear,
                      icon: Icon(Icons.clear),
                      label: Text('clear'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
