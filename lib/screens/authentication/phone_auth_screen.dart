import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';

import '../../services/phone_auth_services.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phone-auth-screen';
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;

  final countryCodeController = TextEditingController(text: '+998');
  final phoneNumController = TextEditingController();

  final PhoneAuthService _service = PhoneAuthService();

  @override
  Widget build(BuildContext context) {
    //Create an instance of ProgressDialog
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: const Color.fromARGB(237, 255, 255, 255),
      textColor: Colors.black,
      loadingText: 'Iltimos kuting...',
      progressIndicatorColor: const Color(0xFF31373D),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF31373D),
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 72, 78, 85),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Kirish',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.lightBlueAccent,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                color: Color(0xFF31373D),
                size: 64,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Telefoningizni kiriting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Biz Sizga maxsus kod yuboramiz',
              style: TextStyle(
                color: Color.fromARGB(235, 255, 255, 255),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: countryCodeController,
                    enabled: false,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    decoration: const InputDecoration(
                      counterText: '10',
                      contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                      counterStyle: TextStyle(fontSize: 18),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 1.5,
                        ),
                      ),
                      label: Text(
                        'Davlat kodi',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      iconColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    maxLength: 9,
                    keyboardType: TextInputType.phone,
                    controller: phoneNumController,
                    autofocus: true,
                    onChanged: (value) {
                      if (value.length == 9) {
                        setState(() {
                          validate = true;
                        });
                      }
                      if (value.length < 9) {
                        setState(() {
                          validate = false;
                        });
                      }
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12, bottom: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                      ),
                      counterStyle: TextStyle(
                          color: Colors.lightBlueAccent, fontSize: 18),
                      label: Text(
                        'Telefon raqam',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      hintText: '00 000-00-00',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      iconColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: AbsorbPointer(
          absorbing: validate ? false : true,
          child: ElevatedButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.lightBlueAccent),
              backgroundColor: validate
                  ? MaterialStateProperty.all(
                      const Color.fromARGB(255, 72, 78, 85))
                  : MaterialStateProperty.all(
                      const Color.fromARGB(255, 55, 59, 65)),
            ),
            onPressed: () {
              progressDialog.show();
              String number =
                  '${countryCodeController.text}${phoneNumController.text}';
              // need to show loading
              Future.delayed(const Duration(seconds: 3)).then((value) => {
                    _service.verifyPhoneNumber(context, number).then(
                          (value) => progressDialog.dismiss(),
                        ),
                  });
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Keyingi',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
