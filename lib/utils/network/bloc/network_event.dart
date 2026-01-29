part of 'network_bloc.dart';

sealed class NetworkEvent {}

class NetworkRequested extends NetworkEvent {}

class NetworkStatusChanged extends NetworkEvent {
  final List<ConnectivityResult> results;
  NetworkStatusChanged(this.results);
}
