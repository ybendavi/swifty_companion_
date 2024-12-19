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
