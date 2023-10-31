import 'package:bloc/bloc.dart';
import 'package:fav_place/data/authentication_remot_ds.dart';
import 'package:meta/meta.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBlocBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final AuthenticationRemotDS remotDs;
  AuthenticationBlocBloc(this.remotDs) : super(AuthenticationBlocInitial()) {
    on<AuthenticationBlocEvent>((event, emit) async {
      try {
        if (event is AuthenticationSignUpEvent) {
          emit(AuthenticationBlocLoadingState());
          await remotDs.signUp(event.email, event.password);
          emit(AuthenticationBlocAuthorizedState());
        } else if (event is AuthenticationSignInEvent) {
          emit(AuthenticationBlocLoadingState());
          await remotDs.signIN(event.email, event.password);
          emit(AuthenticationBlocAuthorizedState());
        } else if (event is AuthenticationSignOutEvent) {
          emit(AuthenticationBlocLoadingState());
          await remotDs.signOut();
          emit(AuthenticationBlocNotAuthorizedState());
        } else if (event is AuthenticationIsSignedInEvent) {
          emit(AuthenticationBlocLoadingState());
        bool isSign=  remotDs.isSignedIn();
          emit(isSign?AuthenticationBlocAuthorizedState():AuthenticationBlocNotAuthorizedState());
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
