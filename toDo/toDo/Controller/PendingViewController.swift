//
//  PendingViewController.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit
import Cartography
class PendingViewController: UIViewController {
    fileprivate var pendingView: CompletedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "toDo"
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initViews()
        initConstraints()
        render()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initViews() {
        pendingView = CompletedView()
        view.addSubview(pendingView)
    }
    
    fileprivate func initConstraints() {
        _ = Cartography.constrain(view, pendingView) { root, home in
            fill(home, superview: root)
        }
    }
    
    func render() {
        //Testing Purpose //Need to render from api
        let model = toDoModel.init(title: "Sample", status: .pending)
        let collection = ToDoCollection.init(model: [model])
        pendingView.renderList(items: collection)
    }
    
}
