import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/settings/video_tutorial_model.dart';

import '../../constant/img_font_color_string.dart';
import '../../providers/settings/privacy_and_help_provider.dart';
import '../../screens/settings/video_screen.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/no_content_label.dart';

class VideoTutorialScreen extends StatefulWidget {
  const VideoTutorialScreen({super.key});

  @override
  State<VideoTutorialScreen> createState() => _VideoTutorialsState();
}

class _VideoTutorialsState extends State<VideoTutorialScreen> {
  //----------------------------------Variables---------------------------//
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Page int
  int page = 1;

  @override
  void initState() {
    fetchVideoTutorialData();
    super.initState();
  }
  //----------------------------------UI---------------------------//

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StaticString.videoTutorials),
        ),
        body: _buildBody(),
      ),
    );
  }

  //----------------------------------Widgets---------------------------//

  // Body
  Widget _buildBody() {
    return SafeArea(
      child: Consumer<PrivacyAndPolicyProvider>(
        builder: (context, videoTutorial, child) => videoTutorial
                .videoTutorialList.isEmpty
            ? Center(
                child: NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: fetchVideoTutorialData,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      itemCount: videoTutorial.videoTutorialList.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 3.8,
                        // childAspectRatio: 3 / 4.5,
                      ),
                      itemBuilder: (context, index) {
                        return LazyLoadingList(
                          index: index,
                          initialSizeOfItems:
                              videoTutorial.fetchVideoModel!.size,
                          hasMore: videoTutorial.fetchVideoModel!.count >=
                              videoTutorial.videoTutorialList.length,
                          loadMore: () async {
                            page++;
                            await Provider.of<PrivacyAndPolicyProvider>(
                              context,
                              listen: false,
                            ).fetchVideoTutorial(page);
                          },
                          child: InkWell(
                            onTap: () => videoOntapAction(
                              videoTutorial.videoTutorialList[index],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 35,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstants.custGreyEBEAEA,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const CustImage(
                                    imgURL: ImgName.videoImage,
                                    height: 60,
                                    width: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                  txtTitle: videoTutorial
                                      .videoTutorialList[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                        color: ColorConstants.custGrey707070,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  //----------------------------------Helper Function---------------------------//

  // Fetch Video Tutorial Data
  Future<void> fetchVideoTutorialData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await Provider.of<PrivacyAndPolicyProvider>(context, listen: false)
          .fetchVideoTutorial(page);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  void videoOntapAction(VideoTutorials videoTutorials) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => VideoShowingScreen(
          videoUrl: videoTutorials.videoUrl,
        ),
      ),
    );
  }
}
