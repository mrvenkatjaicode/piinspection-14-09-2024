import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnovapi/utils/constant.dart';

import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';
import '../../screens/pi_detail/pi_detail_screen.dart';

class SpeedDailFabWidget extends StatefulWidget {
  const SpeedDailFabWidget({super.key});

  @override
  State<SpeedDailFabWidget> createState() => _SpeedDailFabWidgetState();
}

class _SpeedDailFabWidgetState extends State<SpeedDailFabWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is LocationFetchedAndNavigateState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PIDetailScreen(
                  preinsid: "",
                  hitapiflow: false,
                  iseditable: state.isOwnFlow,
                  otherflow: state.isOtherFlow,
                  ownflow: state.isOwnFlow,
                  position: state.position,
                  place: state.place,
                );
              },
            ),
          );
        } else if (state is LocationPermissionDeniedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return SpeedDial(
          icon: Icons.menu,
          activeIcon: Icons.close,
          buttonSize: const Size(56, 56),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          elevation: 8.0,
          shape: const CircleBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              foregroundColor:
                  const Color(0xFF000000), // Replace with kAppTheme
              label: 'Own PI Intimation',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {
                context.read<DashboardBloc>().add(const OwnFlowNavigateEvent());
              },
              onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              foregroundColor:
                  const Color(0xFF000000), // Replace with kAppTheme
              label: 'Assign PI Intimation to others',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {
                context
                    .read<DashboardBloc>()
                    .add(const OtherFlowNavigateEvent());
              },
              onLongPress: () => debugPrint('SECOND CHILD LONG PRESS'),
            ),
          ],
        );
      },
    );
  }
}
