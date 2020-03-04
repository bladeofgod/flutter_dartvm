

import 'dart:io';

import 'package:http_server/http_server.dart';

main(){
  day3();
  //day2();
}
/*
* demo day 3
* */

void day3()async{
  VirtualDirectory staticFiles = new VirtualDirectory('.');
  var requestServer = await HttpServer.bind(InternetAddress.anyIPv6, 8080);

  print("监听端口 : ${requestServer.port}");


  await for(HttpRequest request in requestServer){
    if(request.uri.toString() == '/' || request.uri.toString() == "/index.html"){
      staticFiles.serveFile(new File('../web_app/index.html'), request);
    }else{
      handleMessage(request);
    }
  }

}


/*
* demo day 2
*
*
* */


void day2()async{
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










