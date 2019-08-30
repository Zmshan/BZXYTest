//
//  TestSwiftViewController.swift
//  响应
//
//  Created by open-roc on 2019/8/23.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

import UIKit

class TestSwiftViewController: UIViewController {
    var name = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("swift hello world!")
        // Do any additional setup after loading the view.
        
        //swift调用c函数(无头文件)
        desc3()
        let funcCClassss = sum3(10, 2)
        print("swift调用有头文件的C语言类输出:\(funcCClassss)")//12
        
        
       self.showHelloWithName(name: "")
        
        
    }
    
    
    
    
    
    @objc func showHelloWithName(name : String) -> Void {
        print("OC Hello World")
        let tab  = ZuNiViewController()
        tab.view.frame = self.view.bounds;
        self.view.addSubview(tab.view);
        self.addChild(tab);
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
