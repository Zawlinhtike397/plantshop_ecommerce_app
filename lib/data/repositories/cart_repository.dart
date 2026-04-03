import 'package:hive_ce/hive.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';

class CartRepository {
  Box<CartItemModel>? _cartBox;
  Box<AppliedCouponModel>? _couponBox;

  String? _currentUserId;
  // final Box<CartItemModel> _cartBox = Hive.box<CartItemModel>('cartBox');
  // final Box<AppliedCouponModel> _couponBox = Hive.box<AppliedCouponModel>(
  //   'couponBox',
  // );

  Future<void> initForUser(String userId) async {
    _currentUserId = userId;

    _cartBox = await Hive.openBox<CartItemModel>('cartBox_$userId');
    _couponBox = await Hive.openBox<AppliedCouponModel>('couponBox_$userId');
  }

  AppliedCouponModel? get appliedCoupon {
    if (_couponBox == null || _couponBox!.isEmpty) {
      return null;
    }
    return _couponBox!.getAt(0);
  }

  List<CartItemModel> getCartItems() {
    return _cartBox?.values.toList() ?? [];
  }

  // int _findIndexById(int plantId) {
  //   return _cartBox.values.toList().indexWhere((e) => e.plantId == plantId);
  // }

  int _findIndexById(int plantId) {
    if (_cartBox == null) return -1;

    for (int i = 0; i < _cartBox!.length; i++) {
      final item = _cartBox!.getAt(i);
      if (item != null && item.plantId == plantId) {
        return i;
      }
    }
    return -1;
  }

  void addToCart(CartItemModel item) {
    if (_cartBox == null) return;
    final existingIndex = _findIndexById(item.plantId);

    if (existingIndex != -1) {
      final existingItem = _cartBox!.getAt(existingIndex)!;
      existingItem.quantity += 1;
      existingItem.save();
    } else {
      _cartBox!.add(item);
    }
  }

  void removeItem(int plantId) {
    if (_cartBox == null) return;

    final index = _findIndexById(plantId);
    if (index != -1) {
      _cartBox!.deleteAt(index);
    }
  }

  void increaseQty(int plantId) {
    if (_cartBox == null) return;
    final index = _findIndexById(plantId);
    if (index == -1) return;

    final item = _cartBox!.getAt(index)!;
    item.quantity++;
    item.save();
  }

  void decreaseQty(int plantId) {
    if (_cartBox == null) return;

    final index = _findIndexById(plantId);
    if (index == -1) return;

    final item = _cartBox!.getAt(index)!;

    if (item.quantity > 1) {
      item.quantity--;
      item.save();
    } else {
      _cartBox!.deleteAt(index);
    }
  }

  double get subtotal {
    if (_cartBox == null) return 0;
    return _cartBox!.values.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalQuantity {
    if (_cartBox == null) return 0;
    return _cartBox!.values.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> clearCart() async {
    await _cartBox?.clear();
  }

  void saveCoupon(AppliedCouponModel coupon) {
    _couponBox?.clear();
    _couponBox?.add(coupon);
  }

  void clearCoupon() {
    _couponBox?.clear();
  }
}
