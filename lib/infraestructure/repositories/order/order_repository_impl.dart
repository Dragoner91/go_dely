import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/cart_item_mapper.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/mappers/order_mapper.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';
import 'package:go_dely/infraestructure/models/order_db.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class OrderRepositoryImpl extends IOrderRepository{

  final IPetition petition;
  final IAuthRepository auth;
  final IProductRepository productRepository;
  final IComboRepository comboRepository;

  OrderRepositoryImpl({required this.petition, required this.auth, required this.comboRepository, required this.productRepository});

  @override
  Future<Result<String>> createOrder(CreateOrderDto order) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");
    var queryParameters = {
      'address': order.address,
      'paymentMethod': order.paymentMethod,
      'latitude': double.parse(order.latitude),
      'longitude': double.parse(order.longitude),
      'currency': order.currency,
      'total': order.total,
      'products': order.products,
      'combos': order.combos,
      if(order.couponCode != null) 'cupon_code': order.couponCode
    };

    print(queryParameters);

    final result = await petition.makeRequest(
      urlPath: '/order/create',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        final String orderId = data['incremental_id'] != null ? data['incremental_id'].toString() : data['id']; 
        return orderId;
      },
      body: queryParameters
    );
    return result;
  }

  @override
  Future<Result<Order>> getOrderById(GetOrderByIdDto dto) async {  //* CAMBIAR A GetOrderByIdDto

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/order/one/${dto.id}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
          return data;
      },
    );
    Result<Order> resultOrder;

    if(result.isError) print("ERROR DE ORDEN");
    dynamic order = result.unwrap();
    Order orderFinal;
    if (dto.backSelected == "Team Naranja"){
      List<ICart> items = [];
      if (order['products'] != null) {
        for (var e in order['products']) {
          var productResult = await productRepository.getProductById(e['id']);
          var product = productResult.unwrap();
          items.add(
            CartItemMapper.cartItemToEntity(
              CartLocal.fromEntity(
                ProductMapper.productToEntity(
                  ProductDB.fromJson(
                    {
                      "id": product.id,
                      "name": product.name,
                      "description": product.description,
                      "price": product.price,
                      "currency": product.currency,
                      "weight": product.weight,
                      "measurement": product.measurement,
                      "stock": product.stock,
                      "categories": product.categories,
                      "images": product.imageUrl,
                      "discount": product.discount == "No Discount" ? "" : product.discount
                    }
                  )
                ),
                e['quantity'],
                "",
                "Product"
              )
            )
          );
        }
      }
      if (order['combos'] != null) {
        for (var e in order['combos']) {
          var comboResult = await comboRepository.getComboById(e['id']);
          var combo = comboResult.unwrap();
          items.add(
            CartItemMapper.cartItemToEntity(
              CartLocal.fromEntity(
                ComboMapper.comboToEntity(
                  ComboDB.fromJson(
                    {
                      "id": combo.id,
                      "name": combo.name,
                      "description": combo.description,
                      "price": combo.price,
                      "currency": combo.currency,
                      "categories": combo.categories,
                      "images": combo.imageUrl,
                      "discount": combo.discount == "No Discount" ? "" : combo.discount
                    }
                  )
                ),
                e['quantity'],
                "",
                "Combo"
              )
            )
          );
        }
      }
      orderFinal =
        Order(
          uuid: order['id'], 
          id: order['id'], 
          address: order['address'], 
          latitude: order['latitude'].toString(), 
          longitude: order['longitude'].toString(), 
          currency: order['paymentMethod']['currency'], 
          paymentMethod: order['paymentMethod']['paymentMethod'], 
          items: items, 
          total: order['paymentMethod']['total'], 
          status: order['status']
        );
    } else {
      orderFinal = 
        OrderMapper.orderToEntity(
          OrderDB.fromJson(order)
        );
    }
    resultOrder = Result.success(orderFinal);
    return resultOrder;
  }

  @override
  Future<Result<List<Order>>> getOrders(GetOrdersDto dto) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/order/many',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        return data;
      },
    );
    
    Result<List<Order>> resultOrders;

    if(result.isError) print("ERROR DE ORDEN");
    dynamic data = result.unwrap();
    List<Order> orders = [];
    if (dto.backSelected == "Team Naranja"){
      for (var order in data) {
        List<ICart> items = [];

        if (order['products'] != null) {
          for (var e in order['products']) {
            var productResult = await productRepository.getProductById(e['id']);
            var product = productResult.unwrap();
            items.add(
              CartItemMapper.cartItemToEntity(
                CartLocal.fromEntity(
                  ProductMapper.productToEntity(
                    ProductDB.fromJson(
                      {
                        "id": product.id,
                        "name": product.name,
                        "description": product.description,
                        "price": product.price,
                        "currency": product.currency,
                        "weight": product.weight,
                        "measurement": product.measurement,
                        "stock": product.stock,
                        "categories": product.categories,
                        "images": product.imageUrl,
                        "discount": product.discount == "No Discount" ? "" : product.discount
                      }
                    )
                  ),
                  e['quantity'],
                  product.imageUrl[0],
                  "Product"
                )
              )
            );
          }
        }

        if (order['combos'] != null) {
          for (var e in order['combos']) {
            var comboResult = await comboRepository.getComboById(e['id']);
            var combo = comboResult.unwrap();
            items.add(
              CartItemMapper.cartItemToEntity(
                CartLocal.fromEntity(
                  ComboMapper.comboToEntity(
                    ComboDB.fromJson(
                      {
                        "id": combo.id,
                        "name": combo.name,
                        "description": combo.description,
                        "price": combo.price,
                        "currency": combo.currency,
                        "categories": combo.categories,
                        "images": combo.imageUrl,
                        "discount": combo.discount == "No Discount" ? "" : combo.discount
                      }
                    )
                  ),
                  e['quantity'],
                  combo.imageUrl[0],
                  "Combo"
                )
              )
            );
          }
        }

        orders.add(
          Order(
            uuid: order['id'], 
            id: order['id'], 
            address: order['address'], 
            latitude: order['latitude'].toString(), 
            longitude: order['longitude'].toString(), 
            currency: order['paymentMethod']['currency'], 
            paymentMethod: order['paymentMethod']['paymentMethod'], 
            items: items, 
            total: order['paymentMethod']['total'], 
            status: order['status']
          )
        );
      }
    } else {
        for (var order in data) {
          orders.add(
            OrderMapper.orderToEntity(
              OrderDB.fromJson(order)
            )
          );
        }
    }
    resultOrders = Result.success(orders);
    return resultOrders;
  }

  @override
  Future<Result<void>> changeStatus(ChangeStatusDto dto) async {  
    
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    var queryParameters = {
      'status': dto.status,
    };

    final result = await petition.makeRequest(
      urlPath: '/order/change/state/${dto.id}',
      httpMethod: 'PATCH',
      mapperCallBack: (data) {
        return data['message'];
      },
      body: queryParameters
    );
    
    return result;

  }

}