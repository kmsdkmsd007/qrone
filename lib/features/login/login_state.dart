/// The state of the app.
typedef LoginState = ({
 bool isLoading,
 bool isPassword,
  int pageCount,
});

LoginState createLoginState({
  bool isLoading = false,
  bool isPassword = true,
  int pageCount = 0,
}) =>
    (  pageCount: pageCount, isLoading: isLoading, isPassword: isPassword);

extension LoginStateExtensions on LoginState {
  /// Copies the login state with the given fields.
  LoginState copyWith({
   bool? isLoading,
    bool? isPassword,
    int? pageCount,
  }) =>
      createLoginState(
        
        pageCount: pageCount ?? this.pageCount,
        isLoading: isLoading ?? this.isLoading,
        isPassword: isPassword ?? this.isPassword,
      );
}
