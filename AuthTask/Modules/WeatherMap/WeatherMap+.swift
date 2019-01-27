//
//  WeatherMap.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit
import Kingfisher

extension WeatherMapViewController:WeatherMapModelDelegate {
    func recievedResponce(_ value: [String : AnyObject], method: String) {
        if method == "weatherdetails"{
            myView?.viewTable?.delegate = self
            myView?.viewTable?.dataSource = self
            myView?.viewTable?.reloadData()
        }
    }
    
    func errorResponce(_ value: String, method: String) {
        
        let alert = UIAlertController(title: "Something Went Wrong !!!", message: value, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension WeatherMapViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return model?.arrayweather.count ?? 0
        }else{
            return model?.arrayinfo.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let Headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.getWidth(), height: 50))
        Headerview.backgroundColor = UIColor(white: 245.0 / 255.0, alpha: 1.0)
        Headerview.isUserInteractionEnabled = true
        let labelTitle = UILabel(frame: CGRect(x: 16, y: 16, width: self.view.getWidth() , height: 20))
        labelTitle.textAlignment = .left
        var labelholder = "Info - "
        if section == 0 {
            labelholder = "Weather - "
        }
        if model?.country != nil {
            labelTitle.text = "\(labelholder)\(model?.city ?? ""),\(model?.country ?? "")"
        }else{
            labelTitle.text = "\(labelholder)\(model?.city ?? "")"
        }
        Headerview.addSubview(labelTitle)
        return Headerview
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if cell is WeatherTableViewCell {
                let cellValue = cell as! WeatherTableViewCell
                cellValue.imageIcon?.kf.cancelDownloadTask()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weathercell") as! WeatherTableViewCell
            let dict = model?.arrayweather[indexPath.row] as! [String:AnyObject]
            cell.setCellLabel(main: dict["main"] as! String, description: dict["description"] as! String)
            if dict["icon"] != nil {
                let icon = dict["icon"] as? String
                let url = "http://openweathermap.org/img/w/\(icon!).png"
                let urlValue = URL(string: url)
                cell.imageIcon?.kf.setImage(with: urlValue, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infocell") as! InfoTableViewCell
            let dict = model?.arrayinfo[indexPath.row] as! [String:AnyObject]
            cell.setCellLabel(main: dict["key"] as! String, description: dict["value"] as! String)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 56
        }else{
            return 51
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



