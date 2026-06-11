import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/cart/presentation/widgets/order_summary_card.dart';
import 'package:food_delivery/src/features/payment/presentation/providers/payment_controller.dart';
import 'package:food_delivery/src/features/payment/presentation/widgets/delivery_address_card.dart';
import 'package:food_delivery/src/features/payment/presentation/widgets/payment_card.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _instructionsController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _onChangeAddress() {
    showGlobalToast(message: AppStrings.changeAddressComingSoon, status: 'info');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    final cart = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        title: const Text(AppStrings.checkoutTitle, style: AppTextStyles.kHeading2),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => OrderSummaryCard(
                subtotal: cart.totalPrice,
                deliveryFee: CartController.deliveryFee,
                discount: cart.discount.value,
                total: cart.total,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            DeliveryAddressCard(
              instructionsController: _instructionsController,
              onChangeAddress: _onChangeAddress,
            ),
            SizedBox(height: AppSpacing.md),
            PaymentCard(
              cardNumberController: _cardNumberController,
              expiryController: _expiryController,
              cvcController: _cvcController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.kCard,
            border: Border(top: BorderSide(color: AppColors.kInputBg)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, color: AppColors.kTextGray, size: 14),
                  SizedBox(width: AppSpacing.xs),
                  const Text(AppStrings.securedByStripe, style: AppTextStyles.kCaption),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              Obx(
                () => AppButton(
                  label: '${AppStrings.payButtonLabel}  \$${cart.total.toStringAsFixed(2)}',
                  isFullWidth: true,
                  height: ButtonSize.large,
                  isLoading: controller.status.value == AppStatus.loading,
                  onPressed: controller.pay,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
