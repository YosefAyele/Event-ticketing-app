part of 'user_update_bloc.dart';

class UserUpdateState {
  const UserUpdateState({
    required this.isLoading,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.updateFailureOrSuccessOption,
  });

  final bool isLoading;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final Option<Either<UserFailure, Object>> updateFailureOrSuccessOption;

  UserUpdateState copyWith({
    bool? isLoading,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    Option<Either<UserFailure, Object>>? updateFailureOrSuccessOption,
  }) {
    return UserUpdateState(
      isLoading: isLoading ?? this.isLoading,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      updateFailureOrSuccessOption: updateFailureOrSuccessOption ?? this.updateFailureOrSuccessOption,
    );
  }

  // initial state
  factory UserUpdateState.initial() {
    return UserUpdateState(
      isLoading: false,
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      updateFailureOrSuccessOption: none(),
    );
  }
}