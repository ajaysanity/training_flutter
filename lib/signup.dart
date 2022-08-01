import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false) ? BackButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
          ) : null,
          title: const Text('Second Lesson'),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(child:
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [MyStatefulWidget()],
          ),
        )),
      );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _personalInfoKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onSignUp() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
      credential.user?.uid;
      snackBar('Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print ('The password provided is too weak.');
        snackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        snackBar('The account already exists for that email.');
      }
    }catch (e) {
      print(e);
    }
  }

  void snackBar (String title) {
    final snackBar = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget signUpForm ({required String labelText}) {
    return       Container(
      width: 300.0,
      height: 35.0,
      color: Colors.white12,
      child: TextFormField (
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personalInfoKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Create a new account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.blue,)
            ),
          signUpForm(labelText: 'First Name'),
          signUpForm(labelText: 'Surname'),
          signUpForm(labelText: 'Email Address'),
          signUpForm(labelText: 'Password'),

        Container(
                width: 300.0,
                child: ElevatedButton(
                  onPressed: () {
                   onSignUp();
                  },
                  child: const Text('Sign Up',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
