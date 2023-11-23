import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/landlord_provider.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/my_properties_list_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';

import '../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../widgets/loading_indicator.dart';

// class InAppPurchaseService {
//   InAppPurchaseService({
//     required this.productIdList,
//     required this.productList,
//     required this.purchasedProductList,
//     required this.purchasedProduct,
//     required this.throwError,
//   }) {
//     initPlatformState();
//   }

//   StreamSubscription? _purchaseUpdatedSubscription;
//   StreamSubscription? _purchaseErrorSubscription;
//   StreamSubscription? _conectionSubscription;

//   final List<String> productIdList;
//   final Function(List<IAPItem>) productList;
//   final Function(PurchasedItem?) purchasedProduct;
//   final Function(List<PurchasedItem>) purchasedProductList;
//   final Function(String) throwError;

//   List<IAPItem> _items = [];
//   List<PurchasedItem> _purchases = [];

//   // Get/Set Product
//   List<IAPItem> get getProducts => List<IAPItem>.from(_items);
//   set setProducts(List<IAPItem> products) {
//     _items = products;
//     productList(getProducts);
//   }

//   // Loading Status notifier...
//   LoadingIndicatorNotifier loadingIndicator = LoadingIndicatorNotifier();

//   // Get/Set Purchased Product
//   List<PurchasedItem> get getPurchasedProducts =>
//       List<PurchasedItem>.from(_purchases);
//   set setPurchasedProducts(List<PurchasedItem> purchasedProducts) {
//     _purchases = purchasedProducts;
//     purchasedProductList(getPurchasedProducts);
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // prepare
//     final result = await FlutterInappPurchase.instance.initialize();
//     print('result: $result');

//     // // refresh items for android
//     // try {
//     //   String msg = await FlutterInappPurchase.instance.consumeAllItems;
//     //   print('consumeAllItems: $msg');
//     // } catch (err) {
//     //   print('consumeAllItems error: $err');
//     // }

//     _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen(
//       (connected) {
//         print('connected: $connected');
//       },
//       onDone: () {
//         loadingIndicator.hide();
//         _conectionSubscription?.cancel();
//       },
//       onError: (purchaseError) {
//         loadingIndicator.hide();
//         throwError(purchaseError?.message ?? "");
//       },
//     );

//     _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen(
//       (productItem) {
//         print('purchase-updated: $productItem');

//         purchasedProduct(productItem);
//         loadingIndicator.hide();
//       },
//       onDone: () {
//         loadingIndicator.hide();
//         _purchaseUpdatedSubscription?.cancel();
//       },
//       onError: (purchaseError) {
//         loadingIndicator.hide();
//         throwError(purchaseError?.message ?? "");
//       },
//     );

//     _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen(
//       (purchaseError) {
//         print('purchase-error: ${purchaseError?.message ?? ""}');
//         loadingIndicator.hide();
//         throwError(purchaseError?.message ?? "");
//       },
//       onDone: () {
//         loadingIndicator.hide();
//         _purchaseErrorSubscription?.cancel();
//       },
//       onError: (purchaseError) {
//         loadingIndicator.hide();
//         throwError(purchaseError?.message ?? "");
//       },
//     );
//   }

//   /// call when user close the app
//   void dispose() {
//     _conectionSubscription?.cancel();
//     _purchaseErrorSubscription?.cancel();
//     _purchaseUpdatedSubscription?.cancel();
//   }

//   // Get Products...
//   Future<void> getProduct() async {
//     try {
//       setProducts =
//           await FlutterInappPurchase.instance.getSubscriptions(productIdList);
//       print(_items);
//     } catch (error) {
//       print("Error fetching products $error");
//       rethrow;
//     }
//   }

//   // Get Purchased products...
//   Future<void> getPurchases() async {
//     try {
//       setPurchasedProducts =
//           await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];
//     } catch (error) {
//       print("Error purchasing products $error");
//       rethrow;
//     }
//   }

//   // Get Purchase History...
//   Future<void> getPurchaseHistory() async {
//     try {
//       setPurchasedProducts =
//           await FlutterInappPurchase.instance.getPurchaseHistory() ?? [];
//     } catch (error) {
//       print("Error fetching purchased product: $error");
//       rethrow;
//     }
//   }

//   // End Billing Connection...
//   Future<void> endBillingConnection() async {
//     // await FlutterInappPurchase.instance.endConnection;
//     _purchaseUpdatedSubscription?.cancel();
//     _purchaseUpdatedSubscription = null;
//     _purchaseErrorSubscription?.cancel();
//     _purchaseErrorSubscription = null;
//     setPurchasedProducts = [];
//     setProducts = [];
//   }
// }

class PaymentService {
  /// We want singelton object of ``PaymentService`` so create private constructor
  ///
  /// Use PaymentService as ``PaymentService.instance``
  PaymentService._internal();

  static final PaymentService instance = PaymentService._internal();

  /// To listen the status of connection between app and the billing server
  late StreamSubscription<ConnectionResult?> _connectionSubscription;

  /// To listen the status of the purchase made inside or outside of the app (App Store / Play Store)
  ///
  /// If status is not error then app will be notied by this stream
  late StreamSubscription<PurchasedItem?> _purchaseUpdatedSubscription;

  /// To listen the errors of the purchase
  late StreamSubscription<PurchaseResult?> _purchaseErrorSubscription;

  final LoadingIndicatorNotifier loadingIndicator = LoadingIndicatorNotifier();

  /// List of product ids you want to fetch
  final List<String> _productIds = [
    "tradesperson_subscription",
    ...List.generate(50, (index) => 'property_${index + 1}')
  ];

  /// All available products will be store in this list
  List<IAPItem> _products = [];

  /// All past purchases will be store in this list
  List<PurchasedItem> _pastPurchases = [];

  /// view of the app will subscribe to this to get notified
  /// when premium status of the user changes
  final ObserverList<Function> _proStatusChangedListeners =
      ObserverList<Function>();

  /// view of the app will subscribe to this to get errors of the purchase
  final ObserverList<Function(String)> _errorListeners =
      ObserverList<Function(String)>();

  /// logged in user's premium status
  bool _isProUser = false;

  bool get isProUser => _isProUser;

  /// view can subscribe to _proStatusChangedListeners using this method
  void addToProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.add(callback);
  }

  /// view can cancel to _proStatusChangedListeners using this method
  void removeFromProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.remove(callback);
  }

  /// view can subscribe to _errorListeners using this method
  void addToErrorListeners(Function callback) {
    _errorListeners.add(
      (p0) => callback(),
    );
  }

  /// view can cancel to _errorListeners using this method
  void removeFromErrorListeners(Function callback) {
    _errorListeners.remove(
      (p0) => callback(),
    );
  }

  /// Call this method to notify all the subsctibers of _proStatusChangedListeners
  void _callProStatusChangedListeners() {
    for (final callback in _proStatusChangedListeners) {
      callback();
    }
  }

  /// Call this method to notify all the subsctibers of _errorListeners
  void _callErrorListeners(String? error) {
    for (final callback in _errorListeners) {
      callback(error ?? "Something went wrong!");
    }
  }

  /// Call this method at the startup of you app to initialize connection
  /// with billing server and get all the necessary data
  Future<void> initConnection() async {
    try {
      await FlutterInappPurchase.instance.initialize();
      _connectionSubscription = FlutterInappPurchase.connectionUpdated.listen(
        (connected) {
          print('connected: $connected');
        },
        onDone: () {
          loadingIndicator.hide();
        },
        onError: (purchaseError) {
          loadingIndicator.hide();
          showAlert(context: getContext, message: purchaseError);
        },
      );

      _purchaseUpdatedSubscription =
          FlutterInappPurchase.purchaseUpdated.listen(
        _handlePurchaseUpdate,
        onDone: () {
          loadingIndicator.hide();
          _purchaseUpdatedSubscription.cancel();
        },
        onError: (purchaseError) {
          loadingIndicator.hide();
          showAlert(context: getContext, message: purchaseError);
        },
      );

      _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen(
        _handlePurchaseError,
        onDone: () {
          loadingIndicator.hide();
          _purchaseErrorSubscription.cancel();
        },
        onError: (purchaseError) {
          loadingIndicator.hide();
          showAlert(context: getContext, message: purchaseError);
        },
      );

      await _getItems();
      await _getPastPurchases();
    } catch (e) {
      showAlert(context: getContext, message: e);
    }
  }

  /// call when user close the app
  void dispose() {
    _connectionSubscription.cancel();
    _purchaseErrorSubscription.cancel();
    _purchaseUpdatedSubscription.cancel();
    // FlutterInappPurchase.instance.endConnection;
  }

  void _handlePurchaseError(PurchaseResult? purchaseError) {
    _callErrorListeners(purchaseError?.message);
    showAlert(context: getContext, message: purchaseError?.message);
    loadingIndicator.hide();
  }

  /// Called when new updates arrives at ``purchaseUpdated`` stream
  Future<void> _handlePurchaseUpdate(PurchasedItem? productItem) async {
    if (productItem != null) {
      if (Platform.isAndroid) {
        await _handlePurchaseUpdateAndroid(productItem);
      } else {
        await _handlePurchaseUpdateIOS(productItem);
      }
    }
  }

  Future<void> _handlePurchaseUpdateIOS(PurchasedItem purchasedItem) async {
    switch (purchasedItem.transactionStateIOS) {
      case TransactionState.deferred:
        // Edit: This was a bug that was pointed out here : https://github.com/dooboolab/flutter_inapp_purchase/issues/234
        // FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.failed:
        _callErrorListeners("Transaction Failed");
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);

        break;
      case TransactionState.purchased:
      case TransactionState.restored:
        await _verifyAndFinishTransaction(purchasedItem);
        break;
      case TransactionState.purchasing:
        break;
      // case TransactionState.restored:
      //   await FlutterInappPurchase.instance
      //       .requestSubscription(purchasedItem.productId ?? "");
      //   break;
      default:
    }
  }

  /// three purchase state https://developer.android.com/reference/com/android/billingclient/api/Purchase.PurchaseState
  /// 0 : UNSPECIFIED_STATE
  /// 1 : PURCHASED
  /// 2 : PENDING
  Future<void> _handlePurchaseUpdateAndroid(PurchasedItem purchasedItem) async {
    switch (purchasedItem.purchaseStateAndroid?.index) {
      case 1:
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
        }
        break;
      default:
        _callErrorListeners("Something went wrong");
    }
  }

  String? usetPropertyId;

  LandlordDashboradProvider get getLandlordDashboardProvider =>
      Provider.of<LandlordDashboradProvider>(getContext, listen: false);

  LandlordProvider get getmyPropertiesProvider =>
      Provider.of<LandlordProvider>(getContext, listen: false);

  Future<void> Function()? _afterTradespersonPaymnet;

  /// Call this method when status of purchase is success
  /// Call API of your back end to verify the reciept
  /// back end has to call billing server's API to verify the purchase token
  Future<void> _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
    bool isValid = false;
    try {
      // Call API
      // isValid = await _verifyPurchase(purchasedItem);
      print(purchasedItem);

      if (usetPropertyId != null) {
        String? transactionReceipt = purchasedItem.transactionReceipt;
        if (Platform.isAndroid) {
          transactionReceipt = transactionReceipt != null
              ? jsonDecode(transactionReceipt)['purchaseToken'].toString()
              : transactionReceipt.toString();
        }
        await Provider.of<AuthProvider>(getContext, listen: false)
            .subscriptionVerifiy(
          productId: purchasedItem.productId,
          transactionId: purchasedItem.transactionId,
          transactionDate: purchasedItem.transactionDate?.toString(),
          transactionReceipt: transactionReceipt,
          propertyDetailID: usetPropertyId!,
          subscriptionType: _afterTradespersonPaymnet != null
              ? SubscriptionType.Tradesperson
              : SubscriptionType.Property,
        );
        isValid = true;
        await FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        if (_afterTradespersonPaymnet != null) {
          await _afterTradespersonPaymnet!();
        } else {
          await Provider.of<LandlordProvider>(getContext, listen: false)
              .addProperty(usetPropertyId!);
          getLandlordDashboardProvider.fetchLandlordDashboardList();
          getmyPropertiesProvider.fetchPropertiesStaticData();
          loadingIndicator.hide();
          Navigator.of(getContext).pop();
          Navigator.of(getContext).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const MyPropertiesListScren(),
            ),
          );
        }
      }
      loadingIndicator.hide();
    } on SocketException {
      _callErrorListeners("No Internet");
      return;
    } on Exception {
      _callErrorListeners("Something went wrong");
      return;
    } finally {
      loadingIndicator.hide();
    }

    if (isValid) {
      FlutterInappPurchase.instance.finishTransaction(purchasedItem);
      _isProUser = true;
      // save in sharedPreference here
      _callProStatusChangedListeners();
    } else {
      _callErrorListeners("Varification failed");
    }
  }

  Future<List<IAPItem>> get products async {
    if (_products == null) {
      await _getItems();
    }
    return _products;
  }

  Future<void> _getItems() async {
    final List<IAPItem> items =
        await FlutterInappPurchase.instance.getSubscriptions(_productIds);
    _products = [];
    for (final item in items) {
      _products.add(item);
    }
  }

  Future<void> _getPastPurchases() async {
    // remove this if you want to restore past purchases in iOS
    if (Platform.isIOS) {
      return;
    }
    final List<PurchasedItem> purchasedItems =
        await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];

    for (final purchasedItem in purchasedItems) {
      bool isValid = false;

      if (Platform.isAndroid && purchasedItem.transactionReceipt != null) {
        final Map map = json.decode(purchasedItem.transactionReceipt!);
        // if your app missed finishTransaction due to network or crash issue
        // finish transactins
        if (!map['acknowledged']) {
          // isValid = await _verifyPurchase(purchasedItem);
          isValid = true;
          if (isValid) {
            FlutterInappPurchase.instance.finishTransaction(purchasedItem);
            _isProUser = true;
            _callProStatusChangedListeners();
          }
        } else {
          _isProUser = true;
          _callProStatusChangedListeners();
        }
      }
    }

    _pastPurchases = [];
    _pastPurchases.addAll(purchasedItems);
  }

  Future<void> buyProduct(IAPItem item, String propertyId) async {
    try {
      if (item.productId != null) {
        usetPropertyId = propertyId;
        // final bool isSub = await FlutterInappPurchase.instance
        //     .checkSubscribed(sku: item.productId!);
        // print("is Sub: $isSub");
        // if (isSub) {

        // }
        _afterTradespersonPaymnet = null;
        await FlutterInappPurchase.instance.requestPurchase(
          item.productId!,
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> buyTradespersonProduct(
    String propertyId,
    Future<void> Function()? afterPaymentTap,
  ) async {
    try {
      final List<IAPItem> _prod = await products;
      final List<IAPItem> _items = _prod
          .where((element) => element.productId == "tradesperson_subscription")
          .toList();
      if (_items.isNotEmpty) {
        final IAPItem item = _items.first;
        if (item.productId != null) {
          _afterTradespersonPaymnet = afterPaymentTap;
          usetPropertyId = propertyId;

          await FlutterInappPurchase.instance.requestPurchase(
            item.productId!,
          );
        }
      }
    } catch (error) {
      rethrow;
    }
  }
}
