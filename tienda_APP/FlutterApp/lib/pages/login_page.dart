import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController(text: 'Luis@gmail.com');
  final _passCtrl = TextEditingController(text: 'Luis123');
  String error = '';
  bool loading = false;

  Future<void> login() async {
    setState(() {
      loading = true;
      error = '';
    });
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    final res = await ApiService.login(email, pass);
    setState(() => loading = false);
    if (res['success'] == true) {
      // Navigate to home page; pass user info if needed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomePage(user: res['user']),
        ),
      );
    } else {
      setState(() {
        error = res['message'] ?? 'Error al iniciar sesión';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(labelText: 'Email')),
          TextField(
              controller: _passCtrl,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true),
          SizedBox(height: 12),
          ElevatedButton(
              onPressed: loading ? null : login,
              child: loading
                  ? SizedBox(
                      width: 20, height: 20, child: CircularProgressIndicator())
                  : Text('Ingresar')),
          if (error.isNotEmpty)
            Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(error, style: TextStyle(color: Colors.red)))
        ]),
      ),
    );
  }
}
