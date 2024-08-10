import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                context.read<AuthProvider>().signIn(email, password);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                context.read<AuthProvider>().register(email, password);
              },
              child: Text('Register'),
            ),
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                if (auth.isLoading) {
                  return CircularProgressIndicator();
                } else if (auth.errorMessage != null) {
                  return Text(auth.errorMessage!, style: TextStyle(color: Colors.red));
                } else if (auth.user != null) {
                  return Text('Welcome, ${auth.user!.email}');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
