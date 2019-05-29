import 'dart:async';

class Cake{}
class Order{
  String type;
  Order(this.type); //constructor 
}

void main(){
  // ************* se crea la fabrica desde el inicio con anticipacion *******************//
  final controller = new StreamController(); // el Stream es la fabrica, el flujo por donde se ingresa la informacion  
  final order = new Order('vainilla'); // el cliente pide un cake de vainilla 
  final baker = new StreamTransformer.fromHandlers( // es el cheff/panadero/baker
    handleData: (cakeType, sink){
      if(cakeType == 'chocolate'){
        sink.add(Cake());
      }else{
        sink.addError('No puedo hacer ese tipo de Cake!!');
      }
    }
  );
  
  //sink representa al tomador de pedidos 
  controller.sink.add(order); // el tomador de pedidos toma la orden para posteriormente pasarla a la fabrica
  
  //stream representa al inspector de pedidos 
  controller.stream.map((order) => order.type) //al inspector lo unico que el interesa es el tipo, xq lo q se extrae dicha propiedad
    .transform(baker) // envia la propiedad al BAKER 
    .listen((cake) => print('Aqui esta su Cake $cake'), // se crea la tienda de entrega donde retirara el 
     onError: (err) => print(err));  // cliente el CAKE o la notificacion de error
  
}