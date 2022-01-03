// Guidelines Source : https://www.newdelhiairport.in/passenger-guide/first-time-flyer

class GuidelineScreenState {
  var guidelineCardList;

  bool isBeingTranslated;
  String prevLanguage;

  GuidelineScreenState({
    this.guidelineCardList = const [
      {
        "image": "travel_checklist_guide.png",
        "title": "The Traveler's Checklist",
        "collapsedBody": " Most Basic Things Required For Air Travel!",
        "body": """
Most Basic Things Required For Air Travel:

• ID card - The most important document for Air travel and Passport for International Travellers

• Tickets - Hard copy / soft copy based on the Airline’s policy

• Boarding Pass - If available or you can print it at the Check-in counters at the Self Kiosk counters at the Airport.

• Mobile phones - with all the necessary travel apps.
       """,
      },
      {
        "image": "luggage.png",
        "title": "Know Your Luggage",
        "collapsedBody": "Luggage is important!",
        "body": """

Travel documents should be placed in your hand baggage because you may be asked for it anytime for verification of identity.
  Travel light for an enjoyable journey. If you wish to carry more, check with your airlines on baggage weight allowed before you travel. Each Airline has its own set of guidelines for luggage. Ensure to check with the Airline's website or call the airline regarding the baggage guidelines to avoid the last minute hassles while checking-in at the Airport. Ensure that you do not carry any prohibited items in your baggage or it’ll be confiscated by the officials at the Airport.
       """,
      },
      {
        "image": "airport_guide.png",
        "title": "Getting to the Airport",
        "collapsedBody": "On arriving at the Airport",
        "body": """

Most Airlines require travellers to check in 2 or three hours before the flight. Check with the Airlines for their regulations.

Accordingly ensure you reach the Airport at least 2 or 3 hours before the scheduled departure of the Aeroplane. This will give you time to check in and collect your boarding pass, check in your baggage, go through the security screening and be at the departure gate in time for your flight.

A Word of Advice: Make use of Public transport to minimise the unwanted delays in parking your own vehicles.
       """,
      },
      {
        "image": "airport_check_in.png",
        "title": "Check-in at the Airport",
        "collapsedBody": "Regarding necessities at the airport",
        "body": """

Upon reaching the Airport, you will be required to show your ID. Officials at the counter will check the required documents to verify your identity. After verification, you will be issued a boarding pass which will have all the details of your travel like Flight number, seat number, scheduled departure time of the flight.

Newbie’s word of advice: Make sure to secure the boarding pass along with your travel documents. There’s a chance that you can miss it in the breathtaking experience of making your maiden flight.
       """,
      },
      {
        "image": "security_check_in.png",
        "title": "Security Checks",
        "collapsedBody": "Security checks for a Safer Journey",
        "body": """

After Checking-in at the Airport, you’ve to undergo a series of security checks. The following will prepare you better for the screening and personal check.

  • Place all your hand baggage for screening.
  • Place cell phones, laptops, electronics etc in the tray provided.
  • The metal objects like belts, bracelets etc are to be placed in the trays provided, as they might set off the alarms.
  • Follow the 3-3-3 rule at the Airport for carrying any liquids. (You’re not allowed to carry more than 3 numbers and not more than 3 fluid ounces) Check Airline rules to clear any doubts.
  • While your luggage is being checked, you'll be required to undergo a personal check at the checking booths.

Once your screening is over, collect your baggage and everything else from the other side of the X ray machines, or screens. Your documents will be verified and the officials at the counters will allow you to move on to the next step in the Airline process.

In case the screening machine detects anything unusual, or the checking authorities require clarification, you and your luggage may be subjected to extra checks and screening measures.

After the procedures, move on to the Immigration and Customs section, in case of an International Flight or move on to the corresponding terminal in case of a domestic flight.
       """,
      },
      {
        "image": "immigration_and_custom_guide.png",
        "title": "Immigration and Customs",
        "collapsedBody": "For International Travel",
        "body": """

For an International flight, you will need to undergo Customs and Immigration checks. Ensure you have all the necessary travel documents (Passport and VISA) and state the reason for your travel to the officials if asked. Ensure that you do not carry any contraband items which are against the law. Always read the list of allowed/ banned items on the Airline's website. Some countries you travel to might require you to carry local currency. So read the destination country policies and make the necessary arrangements accordingly.
       """,
      },
      {
        "image": "airport_stay.png",
        "title": "Waiting Area/Lounge/Shopping",
        "collapsedBody": "Facilities at the Airport",
        "body": """

Irrespective of the type of flight, you have to wait in the waiting area before it is time to board the flight. There are lounges where you can relax before your flight. IGI Airport offers premium Lounges for their passengers who hold a Private Pilot License (PPL).

While waiting you can explore all the facilities of the Airport. At IGI Airport we have innumerable number of shops, eateries and more to keep you engaged. Experience a diverse range of shopping, dining or relaxing at Delhi International Airport.
       """,
      },
      {
        "image": "departure.png",
        "title": "Departing",
        "collapsedBody": "Bye Bye!",
        "body": """

After reaching the final gate, wait in the boarding area to board the flight. You aboard the plane once the final check of your boarding pass is done. Settle in, put on your seat belt and listen carefully to the instructions

Voila, Here you go! Enjoy your flight journey.
       """,
      },
    ],
    this.isBeingTranslated = false,
    this.prevLanguage = "en",
  });

  GuidelineScreenState copyWith(
      {var guidelineCardList, var isBeingTranslated, var prevLanguage}) {
    return GuidelineScreenState(
      guidelineCardList: guidelineCardList ?? this.guidelineCardList,
      isBeingTranslated: isBeingTranslated ?? this.isBeingTranslated,
      prevLanguage: prevLanguage ?? this.prevLanguage,
    );
  }
}
