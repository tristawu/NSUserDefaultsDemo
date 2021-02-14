//
//  ViewController.swift
//  NSUserDefaultsDemo
//
//  Created by Trista on 2021/2/14.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //取得螢幕的尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    
    //建立2個屬性
    var myUserDefaults :UserDefaults!
    var myTextField: UITextField!
    
    
    //依據委任的協定來建立應該要實作的方法:按下return按鈕時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //更新資訊
        self.updateInfo()
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設置底色
        self.view.backgroundColor = UIColor.white

        //取得儲存的預設資料
        myUserDefaults = UserDefaults.standard
        
        
        //刪除內建的 Main.Storyboard ，在SceneDelegate類別手動建立一個 UIWindow，將rootViewController設為一個 UINavigationController。建立 UINavigationController，使用Navigation Bar上 button中建立一個自定義的按鈕切換頁面。
        //導覽列標題
        self.title = "首頁"

        //導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.lightGray
        
        //導覽列是否半透明
        //需要在導覽列沒有設置底色時才有這個效果。
        //還影響到內部視圖的原點位置，true則原點與導覽列的原點一樣，都是整個畫面的左上角，false則內部視圖的原點則會被設在導覽列下方
        self.navigationController?.navigationBar.isTranslucent = false

        //導覽列右邊按鈕設置為一個自定義文字
        //設置導覽列按鈕是使用UIBarButtonItem()方法，而不是原始的UIButton()
        let rightButton = UIBarButtonItem(
            title:"顯示",style:.plain,
          target:self,action:#selector(ViewController.display))
        //加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton

        
        //使用 UITextField(frame:) 建立一個 UITextField
        myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        //設置於畫面的中間偏上位置
        myTextField.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.2)
        
        //尚未輸入時的預設顯示提示文字
        myTextField.placeholder = "請輸入文字"

        //輸入框的樣式 這邊選擇圓角樣式
        myTextField.borderStyle = .roundedRect

        //輸入框右邊顯示清除按鈕時機:選擇當編輯時顯示
        myTextField.clearButtonMode = .whileEditing

        //輸入框適用的鍵盤
        myTextField.keyboardType = .default

        //鍵盤上的 return 鍵樣式:選擇 Done
        myTextField.returnKeyType = .done

        //輸入文字的顏色
        myTextField.textColor = UIColor.white

        //輸入文字的排列方式
        myTextField.textAlignment = .left
        
        //UITextField 的背景顏色
        myTextField.backgroundColor = UIColor.lightGray
        
        //輸入內容的鍵盤上會有一個完成的按鈕(通常位於鍵盤的右下角Return鍵)。不會實際把按下完成按鈕會做什麼事寫死在元件裡，而是設計成委任模式
        //表示有一個事件(即按下完成後要做的事)待完成，交給委任的對象來實作:交由 self 也就是 ViewController 本身
        //交付委任對象的方式，就是要設置delegate屬性
        myTextField.delegate = self
        
        //加入畫面
        self.view.addSubview(myTextField)
        
        
        //建立更新與刪除按鈕
        var myButton = UIButton(frame: CGRect(
          x: 0, y: 0,width: 120, height: 40))
        myButton.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.3)
        myButton.setTitle("更新", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.addTarget(
            self,
            action: #selector(ViewController.updateInfo),
            for: .touchUpInside)
        
        self.view.addSubview(myButton)
        
        
        myButton = UIButton(frame: CGRect(
          x: 0, y: 0, width: 120, height: 40))
        myButton.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.4)
        myButton.setTitle("刪除", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.addTarget(
            self,
            action: #selector(ViewController.removeInfo),
            for: .touchUpInside)
        
        self.view.addSubview(myButton)
        
        
        //如果已經存有值時,則填入輸入框
        //使用 NSUserDefaults 的方法object(forKey:) 來取得資訊，因為不只可以儲存單純文字，所以這邊會將它先轉為字串( String )再作後續使用
        if let info = myUserDefaults.object(forKey: "info") as?
            String {
            myTextField.text = info
        }
        
    }

    
    //導覽列按鈕執行動作的方法
    @objc func display() {
        //UINavigationController切換頁面的方法為pushViewController()，參數分別為要前往的頁面的ViewController及是否要有過場動畫
        self.navigationController?.pushViewController(DisplayViewController(), animated: true)
        
    }
    
    
    //按下更新按鈕執行動作的方法
    @objc func updateInfo() {
        print("update info")

        //結束編輯 把鍵盤隱藏起來
        self.view.endEditing(true)
        
        //儲存資訊是使用 NSUserDefaults 的方法 set(_ value: Any?, forKey defaultName: String)
        //兩個參數分別為要儲存的資訊以及 key 值，像是字典的鍵值對 key : value
        //尚未有這個key值資訊時就會新增，已經有了的話，則是會更新它。
        myUserDefaults.set(myTextField.text, forKey: "info")
        
        //設置好新的值後，有時系統不會即時更新儲存內容，讓資訊確實儲存就是使用 NSUserDefaults 的方法synchronize()
        myUserDefaults.synchronize()
    }
    
    
    //按下移除按鈕執行動作的方法
    @objc func removeInfo() {
        print("remove info")

        //移除資訊是使用 NSUserDefaults 的方法 removeObject(forKey defaultName: String)，依照傳入的 key 值移除資訊
        myUserDefaults.removeObject(forKey: "info")

        myTextField.text = ""
    }

}

