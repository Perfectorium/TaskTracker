//
//  Other Extensions.swift
//  eurojackpot
//
//  Created by Valeriy Jefimov on 13.04.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit


extension Int {
    var asWord:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return "\(formatter.string(from: NSNumber(value:self))!)"
    }
    static func random(from: Int, to: Int) -> Int {
       return Int(arc4random_uniform(UInt32(to))) - from
    }
}

extension Data {
    //    func  decryptWith(password:String) throws -> String {
    //
    //        let decryptedNSData = try RNCryptor.decrypt(data: self,
    //                                                    withPassword: password)
    //        return                 String(data: decryptedNSData,
    //                                      encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
    //    }
    
    func toBase64() -> String {
        return self.base64EncodedString()
    }
}

extension Date {
    
    func isLaterThanNow() -> Bool {
        return self.compare(Date()) == .orderedDescending
    }
    
    func isLaterThanDate() -> Bool {
        return self.compare(Date(timeIntervalSince1970: 1467244800)) == .orderedDescending
    }
    
    func isFriday() -> Bool {
        let calendar        = NSCalendar(calendarIdentifier: .gregorian)
        let components      = calendar!.components([.weekday], from: self)
        return components.weekday ==  6
    }
}

extension String {
    
//    static func className(_ aClass: AnyClass) -> String {
//        return NSStringFromClass(aClass).components(separatedBy: ".").last!
//    }
//    
//    func substring(_ from: Int) -> String {
//        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
//    }
//    
    init(unicodeScalar: UnicodeScalar) {
        self.init(Character(unicodeScalar))
    }
    
    
    init?(unicodeCodepoint: Int) {
        if let unicodeScalar = UnicodeScalar(unicodeCodepoint) {
            self.init(unicodeScalar: unicodeScalar)
        } else {
            return nil
        }
    }
    
    
    static func +(lhs: String, rhs: Int) -> String {
        return lhs + String(unicodeCodepoint: rhs)!
    }
    
    
    static func +=(lhs: inout String, rhs: Int) {
        lhs = lhs + rhs
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    var isValidNumber: Bool {
        guard let num = Int(self)
            else
        {
            return false
        }
        
        return num < 51 &&  num > 0
    }
    
    var isValidENumber: Bool {
        guard let num = Int(self)
            else
        {
            return false
        }
        
        return num < 11 &&  num > 0
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    //
    //
    //
    //    func encryptWith(password:String)-> Data? {
    //        let data: Data      = self.data(using: String.Encoding.utf8)!
    //        let text            = RNCryptor.encrypt(data: data as Data,
    //                                                withPassword: password)
    //        return text
    //    }
    
    
    
    var toDate:NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
        guard dateFormatter.date(from: self) != nil else
        {
            return NSDate.distantPast as NSDate
        }
        return dateFormatter.date(from: self)! as NSDate
    }
    
    var decrementNum :String {
        if let myInteger = Int(self)
        {
            return NSNumber(value:myInteger - 1).toString
        }
        else
        {
            print("'\(self)' did not convert to an Int")
            return ""
        }
    }
    var number :Int {
        if let myInteger = Int(self)
        {
            return myInteger
        }
        else
        {
            print("'\(self)' did not convert to an Int")
            return 0
        }
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    var isValid: Bool {
        let length = self.characters.count
        return (length > 0)
    }
    
    func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "^\\s*[a-zA-Z0-9\\.]+@[a-zA-Z0-9]+(\\-)?[a-zA-Z0-9]+(\\.)?[a-zA-Z0-9]{2,6}?\\.[a-zA-Z]{2,6}\\s*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
}

extension UIColor {
    static func randomColor(withAlpha alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue: CGFloat(drand48()),
                       alpha: alpha)
    }
}

extension UITableView {
    
    func setOffsetToBottom(animated: Bool) {
        let point = CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height)
        self.setContentOffset(point, animated: true)
    }
    
    func scrollToSection(section:Int, scrollPosition: UITableViewScrollPosition,animated: Bool) {
        if section > 0
        {
            let indexPath = NSIndexPath(item: self.numberOfRows(inSection: 0) , section: section - 1)
            self.scrollToRow(at: indexPath as IndexPath, at:scrollPosition , animated: animated)
        }
    }
    
    func scrollToLastRow(animated: Bool) {
        self.scrollToSection(section: self.numberOfSections , scrollPosition:.bottom , animated: animated)
    }
    
}
extension UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    
    func addBorderView(width:CGFloat = 0.0,
                       color:CGColor){
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
    
    func addShadowView(width:CGFloat = 0.0,
                       height:CGFloat = 2.0,
                       Opacidade:Float = 0.7,
                       maskToBounds:Bool = false,
                       radius:CGFloat = 0.5){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
    func blink() {
        self.blink(scale: 1.1)
    }
    
    func blink(scale:CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 6.0,
                           options: .curveEaseIn, animations: {
                            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
                           completion: nil)
            
        })
        
    }
    public func blink(color:UIColor) {
        let previosColor       = self.backgroundColor!
        self.blink(scale: 1.05)
        UIView.animate(withDuration: 0.3,
                       delay: 0.01,
                       options: [.curveEaseOut],
                       animations: {
                        self.backgroundColor           = color
        }) { (suc:Bool) in
            self.backgroundColor                       = previosColor
            
        }
    }
}


extension UIScrollView {
    
    func fitView() {
        var contentRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
    }
}

extension UITextField {
    
    var isValidENumber: Bool {
        guard let num = Int(self.text!)
            else
        {
            return false
        }
        
        return num < 11 &&  num > 0
    }
    
    var isValidNumber: Bool {
        guard let num = Int(self.text!)
            else
        {
            return false
        }
        
        return num < 51 &&  num > 0
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
}


extension UIButton {
    
    @IBInspectable var borderColor: UIColor {
        set {
            
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    func blinkAndRepeatStart (){
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.9
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    func blinkAndRepeatFinish () {
        UIView.animate(withDuration: 0.5) {
            self.layer.removeAllAnimations()
            
        }
    }
    
    override func blink(scale:CGFloat) {
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0,
                                options: [.allowUserInteraction],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.15,
                                                       animations: {
                                                        self.transform = CGAffineTransform(scaleX: scale, y: scale )
                                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.15,
                                                       relativeDuration: 0.15,
                                                       animations: {
                                                        self.transform = CGAffineTransform(scaleX: 1, y: 1 )
                                                        
                                    })
        }) { (suc) in
            
        }
    }
    
    
    func setButtonBold()  {
        self.titleLabel?.font = UIFont(name: "Titillium-Bold", size: 18)
    }
}

public extension UIDevice {
    
    public func platform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    public var hasHapticFeedback: Bool {
        return ["iPhone9,1", "iPhone9,3", "iPhone9,2", "iPhone9,4"].contains(platform())
    }
}

public extension Array {
    
    func filterDuplicates( includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor:  self.borderColor!)
        }
    }
}

extension UITextField {
    
    public  func blinkBorder(color:UIColor) {
        self.layer.masksToBounds        = true;
        let previosColor                = self.layer.borderUIColor
        let colorAnimation              = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue        = color
        colorAnimation.toValue          = color.cgColor
        self.layer.borderColor          = color.cgColor
        
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue        = 1
        widthAnimation.toValue          = 1
        widthAnimation.duration         = 4
        self.layer.borderWidth          = 1
        
        let bothAnimations              = CAAnimationGroup()
        bothAnimations.repeatCount      = 2
        bothAnimations.duration         = 0.3
        bothAnimations.animations       = [colorAnimation, widthAnimation]
        bothAnimations.timingFunction   = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.layer.add(bothAnimations, forKey: "color and width")
        self.layer.borderUIColor                    = previosColor
        
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                            attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
extension NSNumber{
    
    var toString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: self)!
    }
}

extension UIViewController {
    
    
    
    func showAlert(title:String,
                   message:String,
                   buttonTitle:String,
                   completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title.localized,
                                          message: message.localized,
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: buttonTitle.localized,
                                          style: .destructive,
                                          handler: { (action) in
                                            completionHandler()
            }))
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title.localized,
                                      message: message.localized,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Try again".localized,
                                      style: .destructive,
                                      handler: nil))
        
        self.present(alert, animated: true,
                     completion: nil)
    }
}

extension UINavigationBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
}

