/// The state of the app.
typedef LoginState =
    ({bool isLoading, String error, bool isPassword, int pageCount});

LoginState createLoginState({
  bool isLoading = false,
  bool isPassword = true,
  int pageCount = 0,
  String error = '',
}) => (
  error: error,
  pageCount: pageCount,
  isLoading: isLoading,
  isPassword: isPassword,
);

extension LoginStateExtensions on LoginState {
  /// Copies the login state with the given fields.
  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isPassword,
    int? pageCount,
  }) => createLoginState(
    error: error ?? this.error,
    pageCount: pageCount ?? this.pageCount,
    isLoading: isLoading ?? this.isLoading,
    isPassword: isPassword ?? this.isPassword,
  );
}
