String textEmpty = 'Please enter the value';

class Validates {
  static emptyValidate(value) {
    if (value.toString().isEmpty) {
      return 'please enter value';
    }
    return null;
  }
}
