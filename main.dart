

import 'dart:io';

main()async{
  var requestServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

  await for(HttpRequest request in requestServer){
//    request.response
//        ..write("hello world")
//        ..close();
  handleMessage(request);

  }

}

void handleMessage(HttpRequest request){
  try{
    if(request.method == "GET"){
      handleGET(request);

    }else if(request.method == "POST"){
      handlePOST(request);

    }else{
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
          ..write("不支持此请求")
          ..close();
    }

  }catch(e){
    print("出现了一个异常, ${request.toString()}");
  }
}


handleGET(HttpRequest request){

  request.headers.forEach((key,values){
    for(String v in values){
      print("header value : $v");
    }
  });

  var id = request.uri.queryParameters["id"];
  request.response
    ..statusCode = HttpStatus.ok
    ..write("查询ID是 $id")
    ..close();
}

handlePOST(HttpRequest request){}










