 

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

// sigelton

class AlamoWebServices {
    
  static let shared = AlamoWebServices()
    
//     func requestGetUrlWithoutParams(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
//        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
//            
//            print(responseObject)
//            if responseObject.result.isSuccess {
//                let resJson = JSON(responseObject.result.value!)
//                success(resJson)
//            }
//            if responseObject.result.isFailure {
//                let error : Error = responseObject.result.error!
//                failure(error)
//            }
//        }
//    }
//        
//     func requestPostUrlWithDictionary(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//        
//        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
//            print("POST URL -> \(strURL) \n Params: \(params ?? [:])")
//            print(responseObject)
//            
//            if responseObject.result.isSuccess {
//                let resJson = JSON(responseObject.result.value!)
//                success(resJson)
//            }
//            if responseObject.result.isFailure {
//                let error : Error = responseObject.result.error!
//                
//                failure(error)
//            }
//        }
//    }
//    
//    func requestPostUrlWithBody(_ strURL : String, params : Parameters?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//       
//       Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
//           
//           print("POST URL -> \(strURL) \n Params: \(params ?? [:])")
//           //self.printJsonLogs(JSONparams: params, apiUrl: strURL, headers: headers)
//           print(responseObject)
//           
//           if responseObject.result.isSuccess {
//               let resJson = JSON(responseObject.result.value!)
//               success(resJson)
//           }
//           if responseObject.result.isFailure {
//               let error : Error = responseObject.result.error!
//               
//               failure(error)
//           }
//       }
//   }
//    
//    func requestPutUrl(_ strURL : String, params : Parameters, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//       
//       Alamofire.request(strURL, method: .put, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
//           
//         //  self.printJsonLogs(JSONparams: params, apiUrl: strURL, headers: headers)
//           print("Put URL -> \(strURL) \n Params: \(params ?? [:])")
//           print(responseObject)
//           
//           if responseObject.result.isSuccess {
//               let resJson = JSON(responseObject.result.value!)
//               success(resJson)
//           }
//           if responseObject.result.isFailure {
//               let error : Error = responseObject.result.error!
//               
//               failure(error)
//           }
//       }
//   }
//    
//    
//    func requestPostUrlQueryString(_ strURL : String, params : Parameters, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { (json) in
//            print("POST Query URL -> \(strURL) \n Params: \(params ?? [:])")
//            print(json)
//            
//            if json.result.isSuccess {
//                let resJson = JSON(json.result.value!)
//                success(resJson)
//            }
//            if json.result.isFailure {
//                let error : Error = json.result.error!
//                
//                failure(error)
//            }
//
//        }
//       
//   }
//   
//    func requestGetUrlQueryString(_ strURL : String, params : Parameters?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//        Alamofire.request(strURL, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { (json) in
//            print("Get URL -> \(strURL) \n Params: \(params ?? [:])")
//            print(json)
//            
//            if json.result.isSuccess {
//                let resJson = JSON(json.result.value!)
//                success(resJson)
//            }
//            if json.result.isFailure {
//                let error : Error = json.result.error!
//                
//                failure(error)
//            }
//
//        }
//       
//   }
    
    
    
    func getXdcUsdPrice(success:@escaping (Double) -> Void){

       let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: Constants.Get_xdc_price)!,timeoutInterval: Double.infinity)
        request.addValue("UYIQSLAYpd1i6aOAXL1okajcWJhoDQJr5KX82Zlu", forHTTPHeaderField: "X-API-KEY")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          
           var tempPrice = 0.0
           let response = try! JSONDecoder().decode(GetXDCPrice.self, from:  data)
                         
           if  response.responseData?.count != 0 {
                   
               guard let price = response.responseData?[0].price else {
                   return
               }

             tempPrice = price
           }
           
           
           success(tempPrice)
           
          semaphore.signal()
         
        }

        task.resume()
        semaphore.wait()
        
       
       
    
    }
}
    
    
    
//
//     func getApiWithHeader(_ url : String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//
//        let semaphore = DispatchSemaphore (value: 0)
//
//
//         var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
//         request.addValue("UYIQSLAYpd1i6aOAXL1okajcWJhoDQJr5KX82Zlu", forHTTPHeaderField: "X-API-KEY")
//
//         request.httpMethod = "GET"
//
//         let task = URLSession.shared.dataTask(with: request) { data, response, error in
//           guard let data = data else {
//             print(String(describing: error))
//             semaphore.signal()
//             return
//           }
//
//            let response = try! JSONDecoder().decode(GetXDCPrice.self, from:  data)
//
//            if  response.responseData?.count != 0 {
//
//                guard let price = response.responseData?[0].price else {
//                    return
//                }
//
//                    print(price)
//            }
//
//
//          //  success(JSON(String(data: data, encoding: .utf8)!))
//
//           semaphore.signal()
//
//         }
//
//         task.resume()
//         semaphore.wait()
//
//
//
//     }
  
    
   
    
//
//}
