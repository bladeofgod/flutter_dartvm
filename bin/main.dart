

import 'dart:io';
import 'package:path/path.dart';
import 'package:http_server/http_server.dart';

main(){

  day4();

  //day3();
  //day2();
}


void day4()async{
  //绝对路径
  var mainPath = Platform.script.toFilePath();
  //dirname 可以获取上级目录名字
  var webPath = dirname(dirname(Platform.script.toFilePath())) + "/web_app";

  VirtualDirectory staticFiles = new VirtualDirectory(webPath);
  //允许监听目录，按照目录去请求
  staticFiles.allowDirectoryListing = true;
  //目录处理  当请求根目录时 会返回该地址
  staticFiles.directoryHandler = (dir,request){
    var indexUri = new Uri.file(dir.path).resolve('index.html');
    staticFiles.serveFile(new File(indexUri.toFilePath()), request);
  };

  var requestServer = await HttpServer.bind(InternetAddress.anyIPv6, 8080);

  await for(HttpRequest request in requestServer){
    staticFiles.serveRequest(request);
  }

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










