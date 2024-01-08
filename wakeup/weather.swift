//
//  weather.swift
//  wakeup
//
//  Created by 熊谷知馬 on 2024/01/04.
//

/* 
 
 ユーザーが登録している住所を受け取り気象情報を返す。
 
 
 取得したい情報
 １時間ごとの下記項目
　・天気
　・降水確率
　・気温
その日の最高と最低気温
ざっくりしたその日の天気、晴れ、雨のち晴れなど

 
 */

import SwiftUI
import Alamofire

let APIKey = "9de64df7bac4ca44b8831a14aa60d36a"
let latitude = "38.1705275"
let longitude = "140.417219"
let text = "api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey)"
let fulUlr = "api.openweathermap.org/data/2.5/forecast?lat=38.1705275&lon=140.417219&appid=9de64df7bac4ca44b8831a14aa60d36a"
let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

struct WeatherData: Decodable {
    let list: [Forecast]
}

struct Forecast: Decodable {
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}



func getWeather(lat:String, lon:String) {
    let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=9de64df7bac4ca44b8831a14aa60d36a"
    
    
    guard let url = URL(string:url) else {
        print("Invalid URL")
        return
    }
    
    URLSession.shared.dataTask(with: url) {(data, response, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("Invalid data")
            return
        }
        
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            print(weatherData.list.map {$0.main})
        } catch {
            print("Error")
        }
        
//        print(String(data:data, encoding: .utf8)!)
    }.resume()
}

//final class WordFetcher: ObservableObject {
//    private let url = "https://api.openweathermap.org/data/2.5/forecast?lat=38.1705275&lon=140.417219&appid=9de64df7bac4ca44b8831a14aa60d36a"
//    
//    init() {
//        
//        guard let url = URL(string:url) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("Invalid data")
//                return
//            }
//            
//            print(String(data:data, encoding: .utf8)!)
//        }.resume()
//        
//    }
//}
