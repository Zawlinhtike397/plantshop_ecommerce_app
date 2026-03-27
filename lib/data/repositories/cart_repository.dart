import 'package:hive_ce/hive.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/model/cart_item_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';

class CartRepository {
  final Box<CartItemModel> _cartBox = Hive.box<CartItemModel>('cartBox');
  final Box<AppliedCouponModel> _couponBox = Hive.box<AppliedCouponModel>(
    'couponBox',
  );

  AppliedCouponModel? get appliedCoupon =>
      _couponBox.isEmpty ? null : _couponBox.getAt(0);

  void saveCoupon(AppliedCouponModel coupon) {
    _couponBox.clear();
    _couponBox.add(coupon);
  }

  void clearCoupon() {
    _couponBox.clear();
  }

  List<CartItemModel> getCartItems() {
    return _cartBox.values.toList();
  }

  int _findIndexById(int plantId) {
    return _cartBox.values.toList().indexWhere((e) => e.plantId == plantId);
  }

  void addToCart(CartItemModel item) {
    final existingIndex = _cartBox.values.toList().indexWhere(
      (e) => e.plantId == item.plantId,
    );

    if (existingIndex != -1) {
      final existingItem = _cartBox.getAt(existingIndex)!;
      existingItem.quantity += 1;
      existingItem.save();
    } else {
      _cartBox.add(item);
    }
  }

  void removeItem(int plantId) {
    final index = _findIndexById(plantId);
    if (index != -1) {
      _cartBox.deleteAt(index);
    }
  }

  void increaseQty(int plantId) {
    final index = _findIndexById(plantId);
    if (index == -1) return;

    final item = _cartBox.getAt(index)!;
    item.quantity++;
    item.save();
  }

  void decreaseQty(int plantId) {
    final index = _findIndexById(plantId);
    if (index == -1) return;

    final item = _cartBox.getAt(index)!;

    if (item.quantity > 1) {
      item.quantity--;
      item.save();
    } else {
      _cartBox.deleteAt(index);
    }
  }

  double get subtotal =>
      _cartBox.values.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalQuantity =>
      _cartBox.values.fold(0, (sum, item) => sum + item.quantity);

  void clearCart() => _cartBox.clear();
}
