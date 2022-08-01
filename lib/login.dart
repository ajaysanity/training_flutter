import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/homepage.dart';
import 'package:flutternew/signup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Lesson'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [MyStatefulWidget()],
          ),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> onLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
      snackBar('Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        snackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        snackBar('Wrong password provided for that user.');
      }
    }
  }

  void snackBar (String title) {
    final snackBar = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget socialMedia({ required String imgAsset, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 40,
          width: 40,
          child: Image.asset(
            imgAsset,
            fit: BoxFit.cover,
          ),
      ),
    );
  }
  bool isPassword = true;
  Widget textFormLogin({ required String labelText, required TextEditingController controller, bool obscureText = false}) {
    return Container(
      width: 300.0,
      height: 35.0,
      color: Colors.white12,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration:  InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          suffixIcon:labelText == 'Password' ? IconButton(
              icon: Icon( isPassword ? Icons.visibility : Icons.visibility_off,),
              onPressed: () {setState(() {isPassword = !isPassword;});}) : null,
            ),
      ) ,
    );
  }

  Widget buttonsLogSign( {required String text, required VoidCallback onTap}) {
    return Container(
      width: 300.0,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
              color: Colors.blue,
            ),
          ),

      textFormLogin(labelText: 'Username', controller: emailController),
      textFormLogin(labelText: 'Password',controller: passwordController, obscureText: isPassword),

      buttonsLogSign(text: 'Login', onTap: () {
        onLogin();
      }),
      buttonsLogSign(text: 'SignUp', onTap: () { Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SignUp()));}),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              socialMedia( imgAsset: 'assets/fb.jpg', onTap: () {}),
              socialMedia( imgAsset:'assets/ig.jpg', onTap: () {}),
              socialMedia(imgAsset: 'assets/twt.jpg', onTap: () {}),
            ],
          )
        ],
      ),
    );
  }
}
