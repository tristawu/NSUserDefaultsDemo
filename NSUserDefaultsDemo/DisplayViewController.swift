//
//  DisplayViewController.swift
//  NSUserDefaultsDemo
//
//  Created by Trista on 2021/2/14.
//

import UIKit

//選擇iOS > Source > Cocoa Touch Class這個模版的檔案，繼承自UIViewController的子類別，新增DisplayViewController
class DisplayViewController: UIViewController {
    
    // 取得螢幕的尺寸
    let fullSize = UIScreen.main.bounds.size
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設置底色
        self.view.backgroundColor = UIColor.white
                
        //取得儲存的預設資料
        let myUserDefaults = UserDefaults.standard
        
        
        //建立一個 UILabel 來顯示資訊
        let myLabel = UILabel(frame: CGRect(
                                x: 0, y: 0,
                                width: fullSize.width, height: 40))
        myLabel.textColor = UIColor.brown
        myLabel.textAlignment = .center
        myLabel.center = CGPoint(
            x: fullSize.width * 0.5,
            y: fullSize.height * 0.25)
        
        //使用 NSUserDefaults 的方法object(forKey defaultName: String) -> Any? 來取得資訊，不只可以儲存單純文字，可將它先轉為字串再作後續使用
        if let info = myUserDefaults.object(forKey: "info") as?
            String {
            myLabel.text = info
        }
        else {
            myLabel.text = "尚未儲存資訊"
            myLabel.textColor = UIColor.red
        }

        self.view.addSubview(myLabel)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
