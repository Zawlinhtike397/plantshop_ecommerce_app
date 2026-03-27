import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/applied_cupon_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;

  DiscountBloc({required this.discountRepository}) : super(DiscountInitial()) {
    on<FetchDiscounts>(_fetchDiscounts);
    on<UploadDiscounts>(_uploadDiscounts);
    on<ApplyCoupon>(_applyCoupon);
  }

  Future<void> _fetchDiscounts(
    FetchDiscounts event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      emit(DiscountLoading());

      final discounts = await discountRepository.fetchDiscounts();

      emit(DiscountLoaded(discounts));
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _uploadDiscounts(
    UploadDiscounts event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      emit(DiscountUploading());

      await discountRepository.uploadDiscounts();

      emit(DiscountUploaded());
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _applyCoupon(
    ApplyCoupon event,
    Emitter<DiscountState> emit,
  ) async {
    try {
      final currentState = state;

      if (currentState is! DiscountLoaded) return;

      /// 1. Get discount by code
      final discount = await discountRepository.getDiscountByCode(event.code);

      if (discount == null) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "Invalid coupon code",
          ),
        );
        return;
      }

      /// 2. Validate coupon
      final now = DateTime.now();

      if (!discount.isActive) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "Coupon is inactive",
          ),
        );
        return;
      }

      if (now.isAfter(discount.validUntil)) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "Coupon expired",
          ),
        );
        return;
      }

      if (event.cartTotal < discount.minAmount) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "Minimum amount is ${discount.minAmount} MMK",
          ),
        );
        return;
      }

      final hasUsedAnyCoupon = await discountRepository.hasUserUsedAnyCoupon(
        event.userId,
      );

      final isFirstTimeUser = !hasUsedAnyCoupon;

      if (discount.firstTimeOnly && !isFirstTimeUser) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "Only for first-time users",
          ),
        );
        return;
      }

      final alreadyUsed = await discountRepository.hasUserUsedCoupon(
        userId: event.userId,
        code: event.code,
      );

      if (alreadyUsed) {
        emit(
          currentState.copyWith(
            status: DiscountStatus.error,
            message: "You already used this coupon",
          ),
        );
        return;
      }

      final discountAmount = (event.cartTotal * discount.percentage) / 100;

      final newTotal = event.cartTotal - discountAmount;

      print('newTotal is $newTotal');

      /// 5. Save usage
      await discountRepository.saveCouponUsage(
        userId: event.userId,
        code: event.code,
      );

      // final cartRepo = CartRepository();

      // cartRepo.saveCoupon(
      //   AppliedCouponModel(code: discount.code, discountAmount: discountAmount),
      // );

      emit(
        currentState.copyWith(
          status: DiscountStatus.success,
          message: "Coupon applied",
          discountAmount: discountAmount,
          newTotal: newTotal,
          appliedDiscount: discount,
        ),
      );
    } catch (e) {
      if (state is DiscountLoaded) {
        emit(
          (state as DiscountLoaded).copyWith(
            status: DiscountStatus.error,
            message: e.toString(),
          ),
        );
      }
    }
  }
}
