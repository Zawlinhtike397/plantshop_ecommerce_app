part of 'network_bloc.dart';

class NetworkState extends Equatable {
  final bool hasInternet;
  final List<ConnectivityResult> connectionTypes;

  const NetworkState({
    required this.hasInternet,
    required this.connectionTypes,
  });

  const NetworkState.initial() : hasInternet = true, connectionTypes = const [];

  NetworkState copyWith({
    bool? hasInternet,
    List<ConnectivityResult>? connectionTypes,
  }) {
    return NetworkState(
      hasInternet: hasInternet ?? this.hasInternet,
      connectionTypes: connectionTypes ?? this.connectionTypes,
    );
  }

  @override
  List<Object?> get props => [hasInternet, connectionTypes];
}
