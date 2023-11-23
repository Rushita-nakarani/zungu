// To parse this JSON data, do
//
//     final latestJobModel = latestJobModelFromJson(jsonString);

import 'dart:convert';

List<LatestJobModel> latestJobModelFromJson(String str) =>
    List<LatestJobModel>.from(
      json.decode(str).map((x) => LatestJobModel.fromJson(x)),
    );

String latestJobModelToJson(List<LatestJobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestJobModel {
  LatestJobModel({
    this.id = 0,
    this.jobimg = "",
    this.jobHeaderList = const [],
    this.jobIdNo = "",
    this.jobTitle = "",
    this.jobSubtitle = "",
    this.reportedTitle = "",
    this.reportedDate = "",
    this.tenantDescription = "",
    this.quotationName = "",
    this.quotationColor = "",
    this.isFavourite = false,
    this.jobType = "",
    this.contractorRate = "",
    this.price = "",
    this.completedDate = "",
    this.completedTime = "",
    this.feedbackRate = "",
  });

  int id;
  String jobimg;
  List<JobHeaderModel> jobHeaderList;
  String jobIdNo;
  String jobTitle;
  String jobSubtitle;
  String reportedTitle;
  String reportedDate;
  String tenantDescription;
  String quotationName;
  String quotationColor;
  bool isFavourite;
  String jobType;
  String contractorRate;
  String price;
  String completedDate;
  String completedTime;
  String feedbackRate;

  factory LatestJobModel.fromJson(Map<String, dynamic> json) => LatestJobModel(
        id: json["id"] ?? "",
        jobimg: json["job_img"] ?? "",
        jobHeaderList: List<JobHeaderModel>.from(
          (json["job_header_list"] ?? [])
              .map((x) => JobHeaderModel.fromJson(x)),
        ),
        jobIdNo: json["job_id_no"] ?? "",
        jobTitle: json["job_title"] ?? "",
        jobSubtitle: json["job_subtitle"] ?? "",
        reportedTitle: json["reported_title"] ?? "",
        reportedDate: json["reported_date"] ?? "",
        tenantDescription: json["tenant_description"] ?? "",
        quotationName: json["quotation_name"] ?? "",
        quotationColor: json["quotation_color"] ?? "",
        isFavourite: json["is_favourite"] ?? false,
        jobType: json["job_type"] ?? "",
        contractorRate: json["contractor_rate"] ?? "",
        price: json["price"] ?? "",
        completedDate: json["completed_date"] ?? "",
        completedTime: json["completed_time"] ?? "",
        feedbackRate: json["feedback_rate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_img": jobimg,
        "job_header_list":
            List<dynamic>.from(jobHeaderList.map((x) => x.toJson())),
        "job_id_no": jobIdNo,
        "job_title": jobTitle,
        "job_subtitle": jobSubtitle,
        "reported_title": reportedTitle,
        "reported_date": reportedDate,
        "tenant_description": tenantDescription,
        "quotation_name": quotationName,
        "quotation_color": quotationColor,
        "is_favourite": isFavourite,
        "job_type": jobType,
        "contractor_rate": contractorRate,
        "price": price,
        "completed_date": completedDate,
        "completed_time": completedTime,
        "feedback_rate": feedbackRate,
      };
}

class JobHeaderModel {
  JobHeaderModel({
    this.jobHeader = "",
    this.jobHeaderColor = "",
  });

  String jobHeader;
  String jobHeaderColor;

  factory JobHeaderModel.fromJson(Map<String, dynamic> json) => JobHeaderModel(
        jobHeader: json["job_header"],
        jobHeaderColor: json["job_header_color"],
      );

  Map<String, dynamic> toJson() => {
        "job_header": jobHeader,
        "job_header_color": jobHeaderColor,
      };
}

List<Map<String, dynamic>> myJobscreenDummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [],
    "job_id_no": "",
    "job_title": "40 Cherwell Drive ",
    "job_subtitle": "Marston Oxford OX3 0LZ",
    "reported_title": "Replace Tiles",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Bathroom tiles have become undone and isfalling off the wall and needs replacing.",
    "quotation_name": "",
    "quotation_color": "000000",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Private Job",
        "job_header_color": "0xFFFFF000",
      }
    ],
    "job_id_no": "",
    "job_title": "24 Stainer Place",
    "job_subtitle": "Marston Oxford OX3 0LY",
    "reported_title": "Remove and Fit Carpet",
    "reported_date": "15 May 2021",
    "tenant_description":
        "Seeking a flooring expert to remove the carpetand replace with a new Carpet. The total floor is100m2 and would need to be done...",
    "quotation_name": "",
    "quotation_color": "000000",
  },
  {
    "id": 2,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      }
    ],
    "job_id_no": "",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 4PH",
    "reported_title": "Shower Leak",
    "reported_date": "04 Apr 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems likeit is a washer which has deteriorated.",
    "quotation_name": "",
    "quotation_color": "000000",
  }
];

List<Map<String, dynamic>> sentQuotesScreenDummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [],
    "job_id_no": "",
    "job_title": "40 Cherwell Drive ",
    "job_subtitle": "Marston Oxford OX3 0LZ",
    "reported_title": "Replace Tiles",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Bathroom tiles have become undone and isfalling off the wall and needs replacing.",
    "quotation_name": "EDIT QUOTE AND RESEND",
    "quotation_color": "0xFF017781",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [],
    "job_id_no": "",
    "job_title": "35 Grosvenor Road",
    "job_subtitle": "Risinghurtst Headington OX3 9DY",
    "reported_title": "Install TV Wall Mounting",
    "reported_date": "15 May 2021",
    "tenant_description":
        "I am looking for a handyman who can supply &fit a Television wall mounting for a curved TV. The Vesa mount is 400 x 400.",
    "quotation_name": "QUOTE DECLINED",
    "quotation_color": "0xFFE96254",
  },
  {
    "id": 2,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      }
    ],
    "job_id_no": "",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 4PH",
    "reported_title": "Shower Leak",
    "reported_date": "04 Apr 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems likeit is a washer which has deteriorated.",
    "quotation_name": "QUOTE DECLINED",
    "quotation_color": "0xFFE96254",
  },
  {
    "id": 3,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      }
    ],
    "job_id_no": "",
    "job_title": "52 Park Avenue",
    "job_subtitle": "Hiltown Tower London, EC2 1AA",
    "reported_title": "Plaster Ceiling",
    "reported_date": "04 Apr 2021",
    "tenant_description": "Remove old ceiling and install new moulded panels ",
    "quotation_name": "ACCEPT/DECLINE JOB",
    "quotation_color": "0xFFAFCB1F",
  }
];

List<Map<String, dynamic>> maintenanceNewRequestdummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      }
    ],
    "job_id_no": "",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 3TH",
    "reported_title": "Shower Leak",
    "reported_date": "04 Apr 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems like it is a washer which has deteriorated.",
    "quotation_name": "",
    "quotation_color": "000000",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
    ],
    "job_id_no": "",
    "job_title": "40 Cherwell Drive ",
    "job_subtitle": "Marston Oxford OX3 0LZ",
    "reported_title": "Replace Tiles",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Bathroom tiles have become undone and is falling off the wall and needs replacing.",
    "quotation_name": "",
    "quotation_color": "000000",
  },
];

List<Map<String, dynamic>> maintenanceNewQuotesdummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
    ],
    "job_id_no": "",
    "job_title": "40 Cherwell Drive ",
    "job_subtitle": "Marston Oxford OX3 0LZ",
    "reported_title": "Replace Tiles",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Bathroom tiles have become undone and isfalling off the wall and needs replacing.",
    "quotation_name": "AWAITING QUOTES",
    "quotation_color": "500472",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
    ],
    "job_id_no": "",
    "job_title": "35 Croft Meadows",
    "job_subtitle": "Sandhurst Oxford OX1 4PH",
    "reported_title": "Solid Wood Floor Fitting",
    "reported_date": "15 May 2021",
    "tenant_description":
        "Seeking a floor technician to instal engineered wood flooring throughout the property. Thefloor size is 100m2 with wastage all...",
    "quotation_name": "VIEW 2 NEW QUOTES",
    "quotation_color": "000000",
  },
  {
    "id": 2,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      },
    ],
    "job_id_no": "",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 4PH",
    "reported_title": "Shower Leadk",
    "reported_date": "04 Apr 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems likeit is a washer which has deteriorated.",
    "quotation_name": "VIEW 4 NEW QUOTES",
    "quotation_color": "000000",
  },
  {
    "id": 3,
    "job_img": "",
    "job_header_list": [],
    "job_id_no": "",
    "job_title": "39 Rupert Road",
    "job_subtitle": "Cowley Oxfrod OX4 2RB",
    "reported_title": "Yearly Gas Safety Check",
    "reported_date": "15 May 2021",
    "tenant_description": "Yearly gas safety check",
    "quotation_name": "VIEW 2 NEW QUOTES",
    "quotation_color": "000000",
  },
];

List<Map<String, dynamic>> maintenanceAllocatedJobdummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
      {
        "job_header": "Job Declined",
        "job_header_color": "0xFFFF0000",
      },
    ],
    "job_id_no": "#Z85BS210222",
    "job_title": "40 Cherwell Drive ",
    "job_subtitle": "Marston Oxford OX3 0LZ",
    "reported_title": "Replace Tiles",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Bathroom tiles have become undone and isfalling off the wall and needs replacing.",
    "quotation_name": "",
    "quotation_color": "500472",
    "is_favourite": false,
    "job_type": "M Lewis Plumbing",
    "contractor_rate": "3.5",
    "price": "£296.00",
    "completed_date": "20 Mar 2022",
    "completed_time": "16:30",
    "feedback_rate": "",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Awaiting Acceptance",
        "job_header_color": "0xFF160935",
      },
    ],
    "job_id_no": "#ZD7ES270621",
    "job_title": "35 Croft Meadows",
    "job_subtitle": "Sandhurst Oxford OX1 4PH",
    "reported_title": "Solid Wood Floor Fitting",
    "reported_date": "15 May 2021",
    "tenant_description":
        "Seeking a floor technician to instal engineered wood flooring throughout the property. Thefloor size is 100m2 with wastage all...",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "PJ Flooring",
    "contractor_rate": "3.5",
    "price": "£542.00",
    "completed_date": "28 Jun 2021",
    "completed_time": "17:45",
    "feedback_rate": "",
  },
  {
    "id": 2,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      },
      {
        "job_header": "Job Accepted",
        "job_header_color": "0xFF00B604",
      },
    ],
    "job_id_no": "#1CN46270522",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 4PH",
    "reported_title": "Shower Leadk",
    "reported_date": "04 Apr 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems likeit is a washer which has deteriorated.",
    "quotation_name": "VIEW 4 NEW QUOTES",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "M Lewis Plumbing",
    "contractor_rate": "3.5",
    "price": "£296.00",
    "completed_date": "20 Mar 2022",
    "completed_time": "16:00 - 17:30",
    "feedback_rate": "",
  },
  {
    "id": 3,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Landlord Will Repair",
        "job_header_color": "0xFFFF7E00",
      },
    ],
    "job_id_no": "#ZQ87X150521",
    "job_title": "25 Wincanton Road",
    "job_subtitle": "Bicester OX26 1TH",
    "reported_title": "Repair Fence",
    "reported_date": "15 May 2021",
    "tenant_description":
        "I need to erect new fence posts and replace 2 fence panels on the back of the Property",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "Kevin Anderson",
    "contractor_rate": "",
    "price": "",
    "completed_date": "20 May 2021",
    "completed_time": "17:45",
    "feedback_rate": "",
  },
  {
    "id": 4,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Own Tradesmen",
        "job_header_color": "0xFF4B00FF",
      },
    ],
    "job_id_no": "#Z8R5A150521",
    "job_title": "50 Aurora Avenue",
    "job_subtitle": "Sandhurst Oxford OX1 4PH",
    "reported_title": "Redecorate Living Room",
    "reported_date": "15 May 2021",
    "tenant_description":
        "I need a painter and decorator to paint my living room",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "Resi Renovation",
    "contractor_rate": "",
    "price": "£185.00",
    "completed_date": "20 May 2021",
    "completed_time": "17:45",
    "feedback_rate": "",
  },
];

List<Map<String, dynamic>> maintenanceCompletedJobdummyData = [
  {
    "id": 0,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Tenant",
        "job_header_color": "0xFF2AC4EF",
      },
      {
        "job_header": "Urgent",
        "job_header_color": "0xFFFF0000",
      },
      {
        "job_header": "Job Completed",
        "job_header_color": "0xFF500472",
      },
    ],
    "job_id_no": "#1CN46270522",
    "job_title": "121 Cowley Road",
    "job_subtitle": "Littlemore Oxford OX4 4PH",
    "reported_title": "Shower Leak",
    "reported_date": "27 Jun 2021",
    "tenant_description":
        "Shower has a leak from the faucet, it seems likeit is a washer which has deteriorated. The hose also seems to be worn badly and will...",
    "quotation_name": "",
    "quotation_color": "500472",
    "is_favourite": false,
    "job_type": "Oxflooring UK",
    "contractor_rate": "3.5",
    "price": "£296.00",
    "completed_date": "20 Mar 2022",
    "completed_time": "16:00",
    "feedback_rate": "0",
  },
  {
    "id": 1,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Job Completed",
        "job_header_color": "0xFF500472",
      },
    ],
    "job_id_no": "#A8M04270622",
    "job_title": "35 Croft Meadows",
    "job_subtitle": "Sandhurst Oxford OX1 4PH",
    "reported_title": "Solid Wood Floor Fitting",
    "reported_date": "15 May 2021",
    "tenant_description":
        "Seeking a floor technician to instal engineered wood flooring throughout the property. Thefloor size is 100m2 with wastage all...",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "Oxflooring UK",
    "contractor_rate": "3.5",
    "price": "£675.00",
    "completed_date": "20 Mar 2022",
    "completed_time": "18:00",
    "feedback_rate": "4",
  },
  {
    "id": 2,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Own Tradesmen",
        "job_header_color": "0xFF4B00FF",
      },
    ],
    "job_id_no": "#Z8R5A150521",
    "job_title": "50 Aurora Avenue",
    "job_subtitle": "Sandhurst Oxford OX1 4PH",
    "reported_title": "Redecorate Living Room",
    "reported_date": "15 May 2021",
    "tenant_description":
        "I need a painter and decorator to paint my living room",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "Resi Renovation",
    "contractor_rate": "",
    "price": "£185.00",
    "completed_date": "20 Mar 2022",
    "completed_time": "17:45",
    "feedback_rate": "",
  },
  {
    "id": 3,
    "job_img": "",
    "job_header_list": [
      {
        "job_header": "Own Job",
        "job_header_color": "0xFFFFFC00",
      },
      {
        "job_header": "Landlord Will Repair",
        "job_header_color": "0xFFFF7E00",
      },
    ],
    "job_id_no": "#ZQ87X150521",
    "job_title": "25 Wincanton Road",
    "job_subtitle": "Bicester OX26 1TH",
    "reported_title": "Repair Fence",
    "reported_date": "15 May 2021",
    "tenant_description":
        "I need to erect new fence posts and replace 2 fence panels on the back of the Property",
    "quotation_name": "",
    "quotation_color": "000000",
    "is_favourite": false,
    "job_type": "Kevin Anderson",
    "contractor_rate": "",
    "price": "",
    "completed_date": "20 Mar 2021",
    "completed_time": "17:45",
    "feedback_rate": "",
  },
];
