//login view exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register view exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class MissingEmailAuthException implements Exception {}

//generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
