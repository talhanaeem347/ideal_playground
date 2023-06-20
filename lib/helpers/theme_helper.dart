
class ThemeHelper{
  static bool isDarkMode = false;

  toggleTheme(){
    isDarkMode = !isDarkMode;
  }

  static get isDark => isDarkMode;

}