import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkBloc() : super(NetworkState.initial()) {
    on<NetworkRequested>(_onNetworkRequested);
    on<NetworkStatusChanged>(_onStatusChanged);
  }

  void _onNetworkRequested(
    NetworkRequested event,
    Emitter<NetworkState> emit,
  ) async {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (results) => add(NetworkStatusChanged(results)),
    );

    final initial = await _connectivity.checkConnectivity();
    add(NetworkStatusChanged(initial));
  }

  Future<void> _onStatusChanged(
    NetworkStatusChanged event,
    Emitter<NetworkState> emit,
  ) async {
    final hasInternet = await _hasRealInternet();

    emit(
      state.copyWith(hasInternet: hasInternet, connectionTypes: event.results),
    );
  }

  Future<bool> _hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) return false;
    return _hasRealInternet();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
