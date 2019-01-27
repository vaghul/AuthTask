//
//  InfoTableViewCell.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

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
        
        labelMain = UILabel()
        labelMain?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
        
        labelDescription = UILabel()
        labelDescription?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.semibold)
        
        contentView.addSubview(labelMain!)
        contentView.addSubview(labelDescription!)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        labelMain?.frame = CGRect(x: 16, y: 5, width: self.getWidth() - 32 , height: 18)
        labelDescription?.frame = CGRect(x: 16, y: (labelMain?.calculateOffSetY())! + 5, width: self.getWidth() - 32 , height: 18)
    }
    
    func setCellLabel(main:String,description:String){
        labelMain?.text = main
        labelDescription?.text = (description)
    }
}
