//
//  WeatherTableViewCell.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    var imageIcon:UIImageView?
    private var labelMain:UILabel?
    private var labelDescription:UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.onCreate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCreate(){
        
        imageIcon = UIImageView()
        imageIcon?.contentMode = .scaleAspectFit
        imageIcon?.clipsToBounds = true

        labelMain = UILabel()
        labelMain?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.bold)
        
        labelDescription = UILabel()
        labelDescription?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
        
        contentView.addSubview(imageIcon!)
        contentView.addSubview(labelMain!)
        contentView.addSubview(labelDescription!)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageIcon?.frame = CGRect(x: 16, y: 5, width: 46, height: 46)
        labelMain?.frame = CGRect(x: (imageIcon?.calculateOffSetX())! + 4, y: 5, width: self.getWidth() - ((imageIcon?.calculateOffSetX())! + 4 + 16) , height: 20)
        labelDescription?.frame = CGRect(x: (imageIcon?.calculateOffSetX())! + 4, y: (labelMain?.calculateOffSetY())! + 4, width: self.getWidth() - ((imageIcon?.calculateOffSetX())! + 4 + 16) , height: 18)
    }
    
    func setCellLabel(main:String,description:String){
        labelMain?.text = main
        labelDescription?.text = "Weather condition - \(description)"
    }
}
