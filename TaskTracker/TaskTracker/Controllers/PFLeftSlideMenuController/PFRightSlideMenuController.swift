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
    case chats
    case calendar
}

protocol RightMenuProtocol : class {
    func changeViewController(_ menu: RightMenu)
}


class PFRightSlideMenuController : UIViewController {
    
    
    // MARK: - Vars & constants
    
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectAvatarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var delegate:RightMenuProtocol?
    var menus = ["Projects",
                 "Tasks",
                 "Chats",
                 "Calendar",
                 "Settings"]
    
    static func storyboardInstance() -> PFRightSlideMenuController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? PFRightSlideMenuController
        return controller
    }
    
    
    // MARK: - LifeCycle
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskProjectAvatarWith(image: #imageLiteral(resourceName: "romb+logo "))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("rotated")
        self.tableView.reloadData()
    }
    
    
  // MARK: - Masking
    
    
    private func maskProjectAvatarWith(image:UIImage) {
        let projectMask = #imageLiteral(resourceName: "romb black@1x-1")
        projectAvatarImageView.image = image
        projectAvatarImageView.mask = UIImageView(image: projectMask)
        projectAvatarImageView.mask?.frame = projectAvatarImageView.bounds
    }
    
}

extension PFRightSlideMenuController : UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PFRightTableViewCell.heigth()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = RightMenu(rawValue: indexPath.row) {
            switch menu {
            case .projects, .settings, .tasks, .calendar, .chats:
                let cell    = tableView.dequeueReusableCell(withIdentifier: PFRightTableViewCell.identifier,
                                                            for: indexPath) as! PFRightTableViewCell
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
