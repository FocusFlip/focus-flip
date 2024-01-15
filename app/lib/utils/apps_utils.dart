import '../models/trigger_app.dart';

TriggerApp getTriggerAppByName(String name) {
  List<TriggerApp> availableApps = [
    TriggerApp(name: "Instagram", url: "instagram://"),
    TriggerApp(name: "Facebook", url: "fb://"),
    TriggerApp(name: "Twitter", url: "twitter://"),
    TriggerApp(name: "LinkedIn", url: "linkedin://"),
    TriggerApp(name: "YouTube", url: "youtube://"),
    TriggerApp(name: "TikTok", url: "tiktok://"),
    TriggerApp(name: "Snapchat", url: "snapchat://"),
    TriggerApp(name: "Pinterest", url: "pinterest://"),
    TriggerApp(name: "Reddit", url: "reddit://"),
    TriggerApp(name: "Tumblr", url: "tumblr://"),
    TriggerApp(name: "WhatsApp", url: "whatsapp://"),
    TriggerApp(name: "Telegram", url: "telegram://"),
    TriggerApp(name: "Discord", url: "discord://"),
    TriggerApp(name: "Twitch", url: "twitch://"),
    TriggerApp(name: "Spotify", url: "spotify://"),
    TriggerApp(name: "Netflix", url: "nflx://"),
    TriggerApp(name: "Tinder", url: "tinder://"),
    TriggerApp(name: "Grindr", url: "grindr://"),
    TriggerApp(name: "Bumble", url: "bumble://"),
    TriggerApp(name: "Hinge", url: "hinge://"),
    TriggerApp(name: "Uber", url: "uber://"),
    TriggerApp(name: "Lyft", url: "lyft://"),
    TriggerApp(name: "Airbnb", url: "airbnb://"),
    TriggerApp(name: "Amazon", url: "amzn://"),
    TriggerApp(name: "Etsy", url: "etsy://"),
    TriggerApp(name: "Wish", url: "wish://"),
    TriggerApp(name: "AliExpress", url: "aliexpress://"),
    TriggerApp(name: "eBay", url: "ebay://"),
    TriggerApp(name: "Walmart", url: "walmart://"),
    TriggerApp(name: "Target", url: "target://"),
    TriggerApp(name: "Best Buy", url: "bestbuy://"),
    TriggerApp(name: "GameStop", url: "gamestop://"),
    TriggerApp(name: "PlayStation", url: "ps://"),
    TriggerApp(name: "Xbox", url: "xbox://"),
  ];

  if (availableApps.any(
    (TriggerApp triggerApp) => triggerApp.name == name,
  )) {
    TriggerApp? triggerApp = availableApps.firstWhere(
      (TriggerApp triggerApp) => triggerApp.name == name,
    );

    return triggerApp;
  } else {
    throw Exception("Trigger app with name $name not found");
  }
}
