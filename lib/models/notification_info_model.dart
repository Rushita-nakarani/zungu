NotificationInfoModel notificationInfoModelFromJson(
  Map<String, dynamic> notificaionInfo,
) =>
    NotificationInfoModel.fromJson(notificaionInfo);

class NotificationInfoModel {
  NotificationInfoModel({
    this.notificationData,
    this.notificationBody,
  });

  NotificationDataModel? notificationData;
  NotificationBodyModel? notificationBody;

  factory NotificationInfoModel.fromJson(Map<String, dynamic> json) =>
      NotificationInfoModel(
        notificationData: json["data"] == null
            ? null
            : NotificationDataModel.fromJson(json["data"]),
        notificationBody: json["notification"] == null
            ? null
            : NotificationBodyModel.fromJson(
                json["notification"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "data": notificationData?.toJson(),
        "notification": notificationBody?.toJson(),
      };
}

class NotificationDataModel {
  NotificationDataModel({
    this.storyId = "",
    this.commentId = "",
    this.activityType = "",
  });

  String storyId;
  String commentId;
  String activityType;

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationDataModel(
        storyId: json["id"] ?? "",
        commentId: json["comment_id"] ?? "",
        activityType: json["activity_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": storyId,
        "activity_type": activityType,
        "comment_id": commentId,
      };
}

class NotificationBodyModel {
  NotificationBodyModel({
    this.title = "",
    this.body = "",
  });

  String title;
  String body;

  factory NotificationBodyModel.fromJson(Map<String, dynamic> json) =>
      NotificationBodyModel(
        title: json["title"] ?? "",
        body: json["body"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}

// Android resposne...
// {
// senderId: null, category: null, collapseKey: com.brandboom.goodrep, contentAvailable: false, 
// data: {activity_type: Like, story_id: z7LpjfYth5WPRA3K8T18}, 
// from: 21378161495, messageId: 0:1659093655285890%0fa2b0970fa2b097, 
// messageType: null, mutableContent: false, 
// notification: { title: , titleLocArgs: [], titleLocKey: null, body: Ben Stoke liked your story, 
// bodyLocArgs: [], bodyLocKey: null, android: {channelId: null, clickAction: FLUTTER_NOTIFICATION_CLICK, color: null, count: null, 
// imageUrl: null, link: null, priority: 0, smallIcon: null, sound: default, ticker: null, tag: null, visibility: 0}, apple: null, web: null }, 
// sentTime: 1659093655256, threadId: null, ttl: 2419200
// }

