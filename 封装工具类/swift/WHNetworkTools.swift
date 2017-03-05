//
//  WHNetworkTools.swift
//  封装网络工具类
//
//  Created by whong7 on 16/9/1.
//  Copyright © 2016年 whong7. All rights reserved.
//

import UIKit
import AFNetworking


/// 请求方式的枚举
enum WHHttpMethod:String {
    case Get = "GET"
    case Post = "POST"
}

class WHNetworkTools: AFHTTPSessionManager {

    static let sharedTools : WHNetworkTools =
    {
      let tools = WHNetworkTools()
      tools.responseSerializer.acceptableContentTypes?.insert("text/html")
      tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
      return tools
    }()
    
    // 将回调数据的闭包定义成一个别名
    typealias WHRequestCallBack = (Any?, Error?) -> ()
    

    //定义一个请求网络的方法
    func request(method: WHHttpMethod,urlString:String,parameters:Any?,completion:@escaping WHRequestCallBack)  {
        
        
        let successClosure:(URLSessionDataTask, Any?) ->() = { (_,responseObject) in
            //请求成功的回调
            completion(responseObject,nil)
            
        }
        
        let failureClosur:(URLSessionDataTask?, Error) ->() = { (_, error) in
            //请求失败的回调
            completion(nil,error)
        }
        
        //根据不同的请求方式去发送不同的请求
        if method == .Get {
            self.get(urlString, parameters: parameters, progress: nil, success: successClosure, failure: failureClosur)
        }
        else
        {
            self.post(urlString, parameters: parameters, progress: nil, success:successClosure, failure: failureClosur)
        }
        
    }
    
    
    /// 上传文件的方法
    ///
    /// - parameter urlString:  请求地址
    /// - parameter parameters: 请求参数
    /// - parameter fileDict:   文件的参数与二进制数据
    /// - parameter completion: 完成的回调
    func uploadFile(urlString: String, parameters: Any?, fileDict: [String: Data], completion: @escaping WHRequestCallBack) {
        // 定义一个成功的闭包
        let successClosure: (URLSessionDataTask, Any?) -> () = { (_, responseObject) in
            // 请求成功的回调
            completion(responseObject, nil)
        }
        
        let failureClosure: (URLSessionDataTask?, Error) -> () = { (_, error) in
            // 请求失败的回调
            completion(nil, error)
        }
        
        // 发送post请求上传文件
        self.post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            // 遍历传入的文件字典
            for (key,value) in fileDict {
                formData.appendPart(withFileData: value, name: key, fileName: "aaa", mimeType: "application/octet-stream")
            }
            }, progress: nil, success: successClosure, failure: failureClosure)
    }

}
