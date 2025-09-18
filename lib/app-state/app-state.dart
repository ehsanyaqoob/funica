
enum ViewState{idle, busy}

abstract class LoaderState{
  ViewState state = ViewState.idle;
  ViewState get viewState => state;
  void setSate(ViewState state);
}