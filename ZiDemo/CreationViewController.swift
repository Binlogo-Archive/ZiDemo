//
//  CreationViewController.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/6.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit
import Alamofire

let kTitleCellHeight: CGFloat = 44
let kContentCellHeight: CGFloat = 190

class CreationViewController: UIViewController {
    
    var templetes = [Templete]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        templetes = fakeRequestTemplete()
    }
}

extension CreationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let titleCell = { () -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTitleCell")
            
            return cell
        }
        
        let creationCell = { () -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreationContentCell") as? CreationShowcaseCell
            cell?.backgroundColor = UIColor.red
            return cell!
        }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = titleCell()!
                cell.textLabel?.text = "选择模板"
                cell.detailTextLabel?.text = "显示全部"
                return cell
            case 1:
                let cell = creationCell()! as? CreationShowcaseCell
                cell?.templetes = self.templetes
                cell?.clickedAt = { [weak self] index in
                    self?.performSegue(withIdentifier: "showPreviewTemplete", sender: self?.templetes[index])
                }
                return cell!
            case 2:
                let cell = titleCell()!
                cell.textLabel?.text = "我的创作"
                cell.detailTextLabel?.isHidden = true
                cell.accessoryType = .none
                return cell
            case 3:
                let cell = creationCell()! as? CreationShowcaseCell
                cell?.templetes = self.templetes
                cell?.clickedAt = { [weak self] index in
                    self?.performSegue(withIdentifier: "showEditCreation", sender: self?.templetes[index])
                }
                return cell!
            default:
                return tableView.dequeueReusableCell(withIdentifier: "SectionTitleCell")!
            }
        } else {
            let cell = titleCell()!
            cell.textLabel?.text = "我的草稿"
            cell.detailTextLabel?.isHidden = true
            return cell
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1, 3:
            return kContentCellHeight
        default:
            return kTitleCellHeight
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showPreviewTemplete":
            let vc = segue.destination as! PreviewTempleteViewController
            vc.templete = sender as? Templete
            vc.hidesBottomBarWhenPushed = true
        case "showEditCreation":
            let vc = segue.destination as! EditCreationViewController
            vc.template = sender as? Templete
            vc.hidesBottomBarWhenPushed = true
        default:
            return
        }
    }
}
