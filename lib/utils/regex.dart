
class Regex{

  static final emailRegex = RegExp('[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}');
  static final identityNumberRegex = RegExp('^[0-9٠-٩]{10}\$');
  static final copyNumberRegex = RegExp('^[0-9٠-٩]{1,2}\$');
  static final passportNumberRegex = RegExp('^[a-zA-Zء-ي]{1,2}[0-9٠-٩]{6}\$');
  static final visaRegex = RegExp('^[0-9٠-٩]{4,10}\$');
  static final residencyRegex = RegExp('^[0-9٠-٩]{10}\$');
  static final residencyCopyNumberRegex = RegExp('^[0-9٠-٩]{1,2}\$');
  static final driverLicenseRegex = RegExp('^[0-9٠-٩]{10}\$');
  static final mobileRegex = RegExp('[0-9٠-٩]{8,15}\$');
}