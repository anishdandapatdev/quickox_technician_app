/// Country code model for phone number inputs
class CountryCode {
  const CountryCode({
    required this.flag,
    required this.code,
    required this.iso,
    required this.name,
  });

  final String flag;
  final String code;
  final String iso;
  final String name;

  static const defaultCountry = CountryCode(
    flag: '🇮🇳',
    code: '+91',
    iso: 'IN',
    name: 'India',
  );

  static const List<CountryCode> supportedCountries = [
    CountryCode(flag: '🇮🇳', code: '+91', iso: 'IN', name: 'India'),
    CountryCode(flag: '🇺🇸', code: '+1', iso: 'US', name: 'United States'),
    CountryCode(flag: '🇬🇧', code: '+44', iso: 'GB', name: 'United Kingdom'),
    CountryCode(flag: '🇦🇪', code: '+971', iso: 'AE', name: 'United Arab Emirates'),
    CountryCode(flag: '🇦🇺', code: '+61', iso: 'AU', name: 'Australia'),
    CountryCode(flag: '🇨🇦', code: '+1', iso: 'CA', name: 'Canada'),
    CountryCode(flag: '🇸🇬', code: '+65', iso: 'SG', name: 'Singapore'),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryCode && runtimeType == other.runtimeType && iso == other.iso;

  @override
  int get hashCode => iso.hashCode;
}
