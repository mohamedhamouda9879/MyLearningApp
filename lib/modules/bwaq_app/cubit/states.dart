abstract class BwaqState {}

class BwaqInitialState extends BwaqState{}

class BwaqGetNotesLoadingState extends BwaqState{}

class UserChangePasswordVisibilityStates extends BwaqState{}

class BwaqGetNotesSuccessState extends BwaqState{}

class BwaqGetNotesErrorState extends BwaqState{

  var error;

  BwaqGetNotesErrorState(this.error);
}