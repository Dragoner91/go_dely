import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/dto/payment_validator_dto.dart';
import 'package:go_dely/aplication/providers/cart/address_selected_provider.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_dely/aplication/providers/cart/date_selected_provider.dart';
import 'package:go_dely/aplication/providers/cart/payment_method_selected_provider.dart';
import 'package:go_dely/aplication/providers/cart/payment_methods/payment_methods_providers.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/aplication/providers/paymentMethod/payment_method_repository_provider.dart';
import 'package:go_dely/aplication/use_cases/cart/payment_validartor.use_case.dart';
import 'package:go_dely/aplication/use_cases/order/create_order.use_case.dart';
import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/domain/paymentMethod/payment_method.dart';
import 'package:go_dely/presentation/screens/address/address_selector.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
          backgroundColor: primaryColor.withAlpha(124),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withAlpha(124), bottomAppBarColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _Content()
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
                color: bottomAppBarColor
              ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _PlaceOrderButton()
                  ],
                )),
          ),
        ),
      );
  }
}

class _PlaceOrderButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<_PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends ConsumerState<_PlaceOrderButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: FilledButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFF5D9558))),
            onPressed: () async {
              
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Dialog(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 150,
                        width: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
              
              final items = await ref.read(cartItemsProvider.notifier).getAllItemsFromCart();
              final date = ref.read(dateSelected.notifier).state;
              final paymentMethod = ref.read(paymentMethodSelectedId.notifier).state;
              final address = ref.read(addressSelected.notifier).state;
              final total = await ref.read(cartItemsProvider.notifier).calculateTotal();
              // final coupon = ; 

              final paymentValidator = PaymentValidatorUseCase();

              final dto = PaymentValidatorDto(
                paymentMethod: ref.read(paymentMethodSelected.notifier).state,
                cardCVV: ref.read(cardCVVProvider.notifier).state,
                cardExpiryDate: ref.read(cardExpiryDateProvider.notifier).state,
                cardNumber: ref.read(cardNumberProvider.notifier).state,
                pagoMovilReferenceNumber: ref.read(pagoMovilReferenceNumberProvider.notifier).state,
                cashAmount: ref.read(cashAmountProvider.notifier).state
              ); 

              try {
                paymentValidator.validatePaymentMethod(dto);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                  Navigator.of(context).pop();
                  return;
                }
              }

              final List<Map<String, dynamic>> combos = items
                  .where((item) => item.type == 'Combo')
                  .map((item) => {
                        'combo_id': item.id,
                        'combo_price': item.price,
                        'quantity': item.quantity,
                      })
                  .toList();

              final List<Map<String, dynamic>> products = items
                  .where((item) => item.type == 'Product')
                  .map((item) => {
                        'product_id': item.id,
                        'product_price': item.price,
                        'quantity': item.quantity,
                      })
                  .toList();
              
              final CreateOrderDto order = CreateOrderDto(
                address: address.address, 
                combos: combos, 
                latitude: address.coordinates.latitude.toString(),
                longitude: address.coordinates.longitude.toString(),  
                currency: "USD", 
                paymentMethod: paymentMethod, 
                products: products, 
                total: total,
                status: "Active"
              );
              final createOrderUseCase = GetIt.instance.get<CreateOrderUseCase>();
              final response = await createOrderUseCase.execute(order);
              // final response = await ref.read(orderRepositoryProvider).createOrder(order);

              if(response.isError){
                throw response.error;
              } else {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Order Created Succesfully"),
                        content: Text("Order ID: ${response.unwrap()}"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () async {
                              await ref.read(cartItemsProvider.notifier).cleanItems();
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                context.go("/home");
                                context.push("/orderHistory"); 
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: const Text(
              "Place Order",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal
                ),
            )),
      ),
    );
  }
}

class _Content extends ConsumerStatefulWidget {

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {
  late Future<List<PaymentMethod>> _paymentMethodsFuture;

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final paymentMethods = await ref.read(paymentMethodRepositoryProvider).getPaymentMethods();
    return paymentMethods.unwrap();
  }

  @override
  void initState() {
    super.initState();
    _paymentMethodsFuture = getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 275,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AddressSelector(),
            ),
            ),
          ),
          //_Addresses(addresses: addresses,), //*mandarle las direcciones
          const _DatePicker(), //*implementar un provider para toda esta info
          FutureBuilder<List<PaymentMethod>>(
            future: _paymentMethodsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading payment methods'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No payment methods available'));
              } else {
                final paymentMethods = snapshot.data!;
                return _PaymentMethod(paymentMethods: paymentMethods);
              }
            },
          ),
        ],
      )
    );
  }
}

class _Addresses extends ConsumerStatefulWidget {

  final List<String> addresses;

  const _Addresses({required this.addresses});

  @override
  ConsumerState<_Addresses> createState() => _AddressesState();
}

class _AddressesState extends ConsumerState<_Addresses> {
  final int selected = 0;

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).colorScheme;
    ref.watch(addressSelected);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text("Shipping To", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            height: 225,
            child: ListView.builder(
              itemCount: widget.addresses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) { 
                return _Address(address: widget.addresses[index],);
                }, //*meterle una direccion
            ),
          ),
    
    
          //* agregar boton para nueva direccion y lo que involucre
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                child: Text("Add New Address", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor.primary
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
                child: Text("Use Another Address", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor.primary
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Address extends ConsumerStatefulWidget {
  final String address;
  const _Address({required this.address});

  @override
  ConsumerState<_Address> createState() => _AddressState();
}

class _AddressState extends ConsumerState<_Address> {
  @override
  Widget build(BuildContext context) {

    final selectedColor = Theme.of(context).splashColor;
    final unselectedColor = Theme.of(context).scaffoldBackgroundColor;
    final bool selected = ref.watch(addressSelected.notifier).state == widget.address;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: selected == true ? selectedColor : unselectedColor,
          border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                shape: const CircleBorder(),
                value: selected,
                onChanged: (value) {
                  // ref.read(addressSelected.notifier).update((state) => widget.address);
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.address,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(widget.address), //*arreglar esto cuando las direcciones reales esten listas
                  Text('${widget.address}, ${widget.address} ${widget.address}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                //* implementar editar direccion del usuario
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePicker extends ConsumerStatefulWidget {
  const _DatePicker({super.key});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends ConsumerState<_DatePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      print(picked.toString());
      ref.read(dateSelected.notifier).update((state) => picked.toString(),);  //*ARREGLAR ESTO
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      print(picked.format(context));
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final backgroundColor = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Preferred Delivery Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: selectedDate != null ? backgroundColor.highlightColor : backgroundColor.canvasColor,
                    border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: selectedTime != null ? backgroundColor.highlightColor : backgroundColor.canvasColor,
                    border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      selectedTime == null
                          ? 'Select Time'
                          : '${selectedTime!.hour}:${selectedTime!.minute}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod extends ConsumerStatefulWidget {

  final List<PaymentMethod> paymentMethods;

  const _PaymentMethod({required this.paymentMethods});

  @override
  ConsumerState<_PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends ConsumerState<_PaymentMethod> {
  String? expiryDate;

  Future<void> _selectExpiryDate(BuildContext context) async {
    final pickedDate = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (pickedDate != null) {
        setState(() {
          expiryDate = '${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
        });
        ref.read(cardExpiryDateProvider.notifier).update((state) => expiryDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedMethod = ref.watch(paymentMethodSelected);
    final theme = Theme.of(context);
    print("reset");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.paymentMethods.length,
            itemBuilder: (context, index) {
              final method = widget.paymentMethods[index].name;
              return Column(
                children: [
                  RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: selectedMethod,
                    onChanged: (String? value) {
                      setState(() {
                        ref.read(paymentMethodSelectedId.notifier).update((state) => widget.paymentMethods[index].id);
                        ref.read(paymentMethodSelected.notifier).update((state) => value!);
                      });
                    },
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  ),
                  if (selectedMethod == method) ...[
                    if (method == 'Credit Card' || method == 'Debit Card') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                            prefixIcon: const Icon(Icons.credit_card),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            ref.read(cardNumberProvider.notifier).update((state) => value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  _selectExpiryDate(context);
                                },
                                child: AbsorbPointer(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Expiry Date',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: theme.colorScheme.surface,
                                      prefixIcon: const Icon(Icons.date_range),
                                    ),
                                    controller: TextEditingController(text: expiryDate),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'CVV',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: theme.colorScheme.surface,
                                  prefixIcon: const Icon(Icons.lock),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ref.read(cardCVVProvider.notifier).update((state) => value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (method == 'Mobile Payment') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Reference Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                            prefixIcon: const Icon(Icons.confirmation_number),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            ref.read(pagoMovilReferenceNumberProvider.notifier).update((state) => value);
                          },
                        ),
                      ),
                    ] else if (method == 'Cash') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Cash Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            print("reset");
                            ref.read(cashAmountProvider.notifier).update((state) => double.tryParse(value) ?? 0.0);
                          },
                        ),
                      ),
                    ],
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}