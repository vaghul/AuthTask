//
//  WeatherMapView.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class WeatherMapView: BaseView {

    var viewTable: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onCreate()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCreate(){
        self.backgroundColor = .white
        viewTable = UITableView()
        viewTable?.separatorStyle = .none
        viewTable?.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weathercell")
        viewTable?.register(InfoTableViewCell.self, forCellReuseIdentifier: "infocell")
        addSubview(viewTable!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewTable?.frame = CGRect(x: 0, y: getSafeTop(), width: self.getWidth(), height: self.getHeight() - getSafeTop() - getSafeBottom())

    }
}
