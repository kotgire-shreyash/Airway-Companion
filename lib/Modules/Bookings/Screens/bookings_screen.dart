import 'package:airwaycompanion/Logic/Bloc/BookingScreenBloc/bookings_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Bookings/Events/bookings_screen_events.dart';
import 'package:airwaycompanion/Modules/Bookings/Screens/bookings_screen_state.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:expandable/expandable.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final bottomBar;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    if (context.read<BookingScreenBloc>().state.bookedTicketsList.isEmpty) {
      context
          .read<BookingScreenBloc>()
          .add(AzureDatabaseRetrieve(isDataBeingUpdated: true));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingScreenBloc, BookingScreenState>(
        builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: widget.bottomBar,
        floatingActionButton: widget.chatbot,
        body: _body(),
      );
    });
  }

  Widget _body() {
    return ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Colors.black,
        useInkWell: true,
        iconSize: 25,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        child: SlidingUpPanel(
          panelBuilder: (sc) {
            return context.read<BookingScreenBloc>().state.isDataBeingUpdated
                ? Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: LoadingAnimationWidget.staggeredDotWave(
                          color: Colors.black, size: 30),
                    ),
                  )
                : SizedBox(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: context
                            .read<BookingScreenBloc>()
                            .state
                            .bookedTicketsList
                            .length,
                        itemBuilder: (context, int index) {
                          Map ticket = context
                              .read<BookingScreenBloc>()
                              .state
                              .bookedTicketsList[index];

                          return TicketCard(ticket: ticket);
                        }),
                  );
          },
          minHeight: MediaQuery.of(context).size.height / 1.6,
          maxHeight: MediaQuery.of(context).size.height / 1.3,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  TicketCard({required this.ticket});
  final Map ticket;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: Center(
                child:
                    context.read<BookingScreenBloc>().state.isDataBeingUpdated
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: LoadingAnimationWidget.staggeredDotWave(
                                color: Colors.black, size: 30),
                          )
                        : Text(ticket["head"]),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  iconColor: Colors.black,
                ),
                collapsed: const Text(
                  "More details",
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "body",
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
