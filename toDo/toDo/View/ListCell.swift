//
//  ListCell.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit
import Cartography
import MGSwipeTableCell
class ListCell: MGSwipeTableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static let height: CGFloat = 55.0
    static let reuseId: String = "ListCellViewId"
    fileprivate var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor.lightGray
            titleLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        }
    }
    fileprivate var borderView: UIView!
    fileprivate var statusView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        initViews()
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    fileprivate func initViews() {
        backgroundColor = UIColor.clear

        borderView = UIView()
        borderView.backgroundColor = UIColor.white
        borderView.layer.borderColor = UIColor.themeBackRoundColor().cgColor
        borderView.layer.borderWidth = 0.1
        borderView.layer.cornerRadius = 5
        contentView.addSubview(borderView)
        self.selectionStyle = .none
        
        statusView = UIView()
        statusView.backgroundColor = UIColor.red
        borderView.addSubview(statusView)

        titleLabel = UILabel()
        borderView.addSubview(titleLabel)
        
    }
    
    fileprivate func initConstraints() {
        let margin: CGFloat = 5
        let statusWidth: CGFloat = 10
        constrain(contentView, borderView, statusView, titleLabel) { root, border, status,  title in
           
            border.left == root.left + margin
            border.right == root.right - margin
            border.top == root.top
            border.bottom == root.bottom - margin/2
            
            status.left == border.left
            status.top == border.top
            status.bottom == border.bottom
            status.width == statusWidth

            title.left ==  status.right + margin
            title.centerY == border.centerY

        }
    }
    
    func render(_ model: toDoModel) {
        titleLabel.text = model.title
        switch model.status {
        case .completed:
            statusView.backgroundColor = UIColor.red
        default:
            statusView.backgroundColor = UIColor.red
        }
    }
    
}
