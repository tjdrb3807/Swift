//
//  ViewController.swift
//  COVID1901
//
//  Created by 전성규 on 2022/05/18.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchCovidOverview(completionHandler: (Result<CityCovidOverview, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "PZNSIl9uXe5siyA3aHfcp68YDU2BbGnTt"
        ]
        
        AF.request(url, method: .get, parameters: param)
            .response(completionHandler: { response in
                switch.response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
}

