class AppStrings{
  static AppStrings i = AppStrings();

  static String get email => "Email";
  static String get password => "Password";
  static String get confirmPassword => "Confirm Password";
  static String get signUp => "Register";
  static String get signingUp => "Signing Up ...";
  static String get logIn => "Log In";
  static String get loggingIn => "Logging In ...";
  static String get appName => "Ideal Playground";
  static String get invalidEmail => "Invalid Email";
  static String get invalidPassword => "Invalid Password";
  static String get passNoMatch => "Passwords do not match";
  static String get createAccount => "Create Account";
  static String get dontHaveAnAccount => "Don't have an account?";
  static String get alreadyHaveAccount => "Already have an account?";
  static String get logInHere => "Log In Here";
  static String get signUpFailure => "Sign Up Failed";
  static String get logInFailure => "Log In Failed";
  static String get invalidEmailAndPasswordCombination => "Invalid Email and Password Combination";
  static String get failureMessage => "Something went wrong";
  static String get submitting => "Submitting ...";
  static String get name => "Name";
  static String get invalidName  => "Invalid Name";
  static String get enterDateOfBirth => "Enter Date of Birth";
  static String get yourGender => "Your Gender";
  static String get interestedIn => "Interested In";
  static String get save => "Save";
  static String get profile => "Profile";
  static DateTime get minDate => DateTime(1900, 1, 1);
  static DateTime get maxDate => DateTime(DateTime.now().year - 18, 12, 31);
  static String get phone => "Phone";
  static String get invalidPhone => "Invalid Phone";
  static String get country => "Country";
  static String get state => "State";
  static String get city => "City";
  static String get invalidCity => "Invalid City";
  static String get invalidState => "Invalid State";
  static String get invalidCountry => "Invalid Country";
  static String get isMarried => "Are you married?";
  static String get yes => "Yes";
  static String get no => "No";
  static String get isOpenForRelationship => "Open for relationship?";



}