

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weather: UILabel!
    var city = String()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = city
        getTodayResult(cityName: city)
        
        func getTodayResult(cityName: String) {
            if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0f6112b1d663b03202ffabe9788c51ef") {
                
                let request = URLRequest(url: url)
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if error == nil {
                        if let incomingData = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                //print(json)
                                
                                if let main = json["main"] as? NSDictionary {
                                                              
                                                              if let temp = main["temp"] as? Double {
                                                                 
                                                                  let state = Int(temp - 273.15)
                                                                  
                                                                  DispatchQueue.main.sync {
                                                                      self.weather.text = String(state) + "°C"
                                                                  }
                                                                  
                                                              }
                                                          }
                            } catch {
                                print("hata olustu")
                            }
                        }
                    }
                    
                }
                
                task.resume()
                
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

}
