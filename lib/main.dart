import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'swifty_companion',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.black54),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
      ),
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    if (_controller.text == 'valid_user') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileView()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid login credentials. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        elevation: 0,
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[50]!, Colors.indigo[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text(
                'Please sign in to continue',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter your login',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorText: _errorMessage,
                ),
              ),
              SizedBox(height: 40),
              PasswordField(
                color: Colors.blue,
                passwordConstraint: r'.*[@$#.*].*',
                //inputDecoration: PasswordDecoration(),
                hintText: 'must have special characters',
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(width: 2, color: Colors.red.shade200),
                  ),
                ),
                errorMessage:
                    'must contain special character either . * @ # \$',
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = {
      'login': 'valid_user',
      'email': 'user@example.com',
      'mobile': '123-456-7890',
      'level': 'Intermediate',
      'location': 'New York',
      'wallet': '1000 USD',
      'evaluations': '5',
      'profilePicture': 'https://via.placeholder.com/150',
      'skills': [
        {'name': 'Flutter', 'level': 'Advanced', 'percentage': 90},
        {'name': 'Dart', 'level': 'Intermediate', 'percentage': 75},
      ],
      'projects': [
        {'name': 'Project A', 'status': 'Completed'},
        {'name': 'Project B', 'status': 'Failed'},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        elevation: 0,
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user['profilePicture'] as String),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              Text('Login: ${user['login']}'),
              Text('Email: ${user['email']}'),
              Text('Mobile: ${user['mobile']}'),
              Text('Level: ${user['level']}'),
              Text('Location: ${user['location']}'),
              Text('Wallet: ${user['wallet']}'),
              Text('Evaluations: ${user['evaluations']}'),
              SizedBox(height: 20),
              Text(
                'Skills',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              ... (user['skills'] as List<dynamic>).map<Widget>((skill) {
                return ListTile(
                  title: Text(skill['name']),
                  subtitle: Text('Level: ${skill['level']}'),
                  trailing: Text('${skill['percentage']}%'),
                );
              }).toList(),
              SizedBox(height: 20),
              Text(
                'Projects',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              ... (user['projects'] as List<dynamic>).map<Widget>((project) {
                return ListTile(
                  title: Text(project['name']),
                  subtitle: Text('Status: ${project['status']}'),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
