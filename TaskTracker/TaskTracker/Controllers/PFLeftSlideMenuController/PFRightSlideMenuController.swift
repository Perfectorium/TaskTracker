//
//  PFLeftSlideMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum RightMenu: Int {
    case projects = 0
    case tasks
    case settings
}

protocol RightMenuProtocol : class {
    func changeViewController(_ menu: RightMenu)
}


class PFRightSlideMenuController : UIViewController {
    
    
     // MARK: - Vars & constants
    
    
    @IBOutlet weak var tableView: UITableView!
    var delegate:RightMenuProtocol?
    var menus = ["Projects",
                 "Tasks",
                 "Settings"]
    
    static func storyboardInstance() -> PFRightSlideMenuController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? PFRightSlideMenuController
        return controller

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        self.tableView.registerCellClass(PFLeftTableViewCell.self)

    }
    
    
}

extension PFRightSlideMenuController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return PFRightTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = RightMenu(rawValue: indexPath.row) {
            self.delegate?.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension PFRightSlideMenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = RightMenu(rawValue: indexPath.row) {
            switch menu {
            case .projects, .settings, .tasks:
                let cell = PFRightTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: PFRightTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
