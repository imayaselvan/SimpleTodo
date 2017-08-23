//
//  CompletedView.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit
import Cartography
import MGSwipeTableCell
enum ListViewAction {
    case textBeginEditing()
    case textEndEditing(text:String)

}
protocol ListViewActions: class {
    func viewDidAction(_ action: ListViewAction)
}

class CompletedView: UIView {
    
    fileprivate var tableView: UITableView!
    fileprivate var lists: ToDoCollection!
    
    init() {
        super.init(frame: CGRect.zero)
        initViews()
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initViews() {
        backgroundColor = UIColor.lightGray
        
        tableView = UITableView()
        self.tableView = tap(UITableView()) {
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = UITableViewCellSeparatorStyle.none
            $0.keyboardDismissMode = .onDrag

        }
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseId)

        self.addSubview(tableView)
    }
    
    fileprivate func initConstraints() {
        _ = Cartography.constrain(self, tableView) { root, collection in
            fill(collection, superview: root)
        }
    }
    
    func renderList(items: ToDoCollection) {
        self.lists = items
        tableView.reloadData()
    }
    
    func render(status:TodoStatus) {
        switch status {
        case .pending:
           let filterdArray = self.lists.models.filter({ (model) -> Bool in
            if model.status == status {
                return true
            }
            else {
                return false
            }
            })
            self.lists.models = filterdArray
        case .completed  :
            print("")
    }
    }
    
}

extension CompletedView : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Stay Safe
        if let items = self.lists {
          return  items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseId, for: indexPath) as? ListCell {
            cell.render(self.lists.at(indexPath.row))
            cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"completed"), backgroundColor: .clear){
                (sender: MGSwipeTableCell!) -> Bool in
                self.changetoCompleted(model: self.lists.at(indexPath.row))
                return true
                }]
            cell.leftSwipeSettings.transition = .clipCenter
            
            cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"delete"), backgroundColor: .clear){
                (sender: MGSwipeTableCell!) -> Bool in
                self.deleteTask(model: self.lists.at(indexPath.row))
                return true
                }]
            cell.rightSwipeSettings.transition = .clipCenter
            
            return cell
        }
        return UITableViewCell()

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableHeaderView()
        headerView.actions = self
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ListCell.height
    }

}


extension CompletedView: ListViewActions {
    internal func viewDidAction(_ action: ListViewAction) {
        switch action {
        case .textBeginEditing():
            print("")
        case .textEndEditing(let value):
            let model = toDoModel.init(title: value, status: .pending)
            self.lists.appendSingle(model)
            self.tableView.reloadData()
        }
    }
    
    func deleteTask(model: toDoModel) {
        self.lists.delete(model)
        //TODO : Need to remove the specific row
        self.tableView.reloadData()
    }
    
    func changetoCompleted(model: toDoModel) {
        model.status = .completed
        self.render(status: .pending)
        self.tableView.reloadData()
    }
    
}


class tableHeaderView: UIView , UITextFieldDelegate{
    weak var actions: ListViewActions?

    fileprivate var inputTitle: UITextField! {
        didSet {
            inputTitle.placeholder = "Add a to-do......"
            inputTitle.font = UIFont(name: "ProximaNova-Medium", size: 17)
            inputTitle.textColor = UIColor.lightGray
            inputTitle.delegate = self
            inputTitle.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    fileprivate var borderView: UIView!

    
    init() {
        super.init(frame: CGRect.zero)
        initViews()
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initViews() {
        backgroundColor = UIColor.white

        borderView = UIView()
        borderView.layer.opacity = 0.8
        borderView.backgroundColor = UIColor.themeBackRoundColor()
        addSubview(borderView)
        
        inputTitle = UITextField()
        borderView.addSubview(inputTitle)
    }
    
    fileprivate func initConstraints() {
        let margin: CGFloat = 5
        _ = Cartography.constrain(self, borderView, inputTitle) { root, border, input in
            
            border.top == root.top + margin
            border.left == root.left + margin
            border.right == root.right - margin
            border.bottom == root.bottom - margin
            
            input.left == border.left + margin/2
            input.right == root.right - margin
            input.centerY == border.centerY
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text?.characters.count)! > 1 {
            actions?.viewDidAction(.textEndEditing(text: textField.text!))
            textField.text = ""
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        actions?.viewDidAction(.textBeginEditing())
    }
    
}

