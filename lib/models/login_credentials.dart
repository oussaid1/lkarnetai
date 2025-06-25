// class for login credentials
class LoginCredentials {
  String? username;
  String? password;
  String? get error {
    if (username == null || username!.isEmpty) {
      return 'Username is required';
    }
    if (password == null || password!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  set error(String? value) {
    error = value;
  }

  String? get validateUsername {
    if (username == null || username!.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? get validatePassword {
    if (password == null || password!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  LoginCredentials({
    this.username,
    this.password,
  });

  /// check if the credentials are valid
  bool get isValid {
    return isValidPassword && isValidUsername;
  }

  /// validate username
  bool get isValidUsername {
    bool _isValid = false;
    _isValid = password != null && password!.isNotEmpty;
    return _isValid;
  }

  /// validate password
  bool get isValidPassword {
    bool _isValid = false;
    _isValid = password != null && password!.isNotEmpty;
    return _isValid;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  } // to map

  // from map
  LoginCredentials.fromMap(Map<String, dynamic> map) {
    username = map['username'];

    password = map['password'];
  }
}

class SignUpCredentials {
  String? username;
  String? email;
  String? password;

  SignUpCredentials({
    this.username,
    this.email,
    this.password,
  });
  // to map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  } // to map

  // from map
  SignUpCredentials.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    email = map['email'];
    password = map['password'];
  }

  /// check if the credentials are valid
  bool get isValid {
    return isValidPassword && isValidUsername && isValidEmail;
  }

  /// validate username
  bool get isValidUsername {
    bool _isValid = false;
    _isValid = username != null && username!.isNotEmpty;
    return _isValid;
  }

  /// validate password
  bool get isValidPassword {
    bool _isValid = false;
    _isValid = password != null && password!.isNotEmpty;
    return _isValid;
  }

  /// validate email
  bool get isValidEmail {
    bool _isValid = false;
    _isValid = email != null && email!.isNotEmpty;
    return _isValid;
  }
}
