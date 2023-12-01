class AuthenticationState {
  AuthenticationState({
    this.uuid,
  });

  factory AuthenticationState.initial() => AuthenticationState(
        uuid: ' ',
      );

  String? uuid;
}
