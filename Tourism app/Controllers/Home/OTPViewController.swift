//
//  OTPViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 4/18/23.
//

import UIKit
import SVProgressHUD
class OTPViewController: BaseViewController {

    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var firstTF: UITextField!{
        didSet{
            firstTF.delegate = self
        }
    }
    @IBOutlet weak var secondTF: UITextField!{
        didSet{
            secondTF.delegate = self
        }
    }
    @IBOutlet weak var thirdTF: UITextField!{
        didSet{
            thirdTF.delegate = self
        }
    }
    @IBOutlet weak var forthTF: UITextField!{
        didSet{
            forthTF.delegate = self
        }
    }
    
    var timer: Timer?
    var countDown = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .title
        viewControllerTitle = "OTP"
        
        firstTF.addTarget(self, action: #selector(OTPViewController.textFieldDidChange(_:)), for: .editingChanged)
        secondTF.addTarget(self, action: #selector(OTPViewController.textFieldDidChange(_:)), for: .editingChanged)
        thirdTF.addTarget(self, action: #selector(OTPViewController.textFieldDidChange(_:)), for: .editingChanged)
        forthTF.addTarget(self, action: #selector(OTPViewController.textFieldDidChange(_:)), for: .editingChanged)
        resendButton.isUserInteractionEnabled = false
        countDonwTimer()
    }
    
    func countDonwTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
    }
    
    @objc func action () {
        countDown = countDown - 1
        resendButton.setTitle("\(countDown)", for: .normal)
        if countDown == 1{
            countDown = 60
            timer?.invalidate()
            resendButton.setTitle("Resend", for: .normal)
            resendButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 == 1{
            if textField == firstTF {
                firstTF.resignFirstResponder()
                secondTF.becomeFirstResponder()
            }
            if textField == secondTF {
                secondTF.resignFirstResponder()
                thirdTF.becomeFirstResponder()
            }
            if textField == thirdTF {
                thirdTF.resignFirstResponder()
                forthTF.becomeFirstResponder()
            }
            if textField == firstTF {
                forthTF.resignFirstResponder()
            }
        }
    }
    
    @IBAction func resendBtnAction(_ sender: Any) {
        print(UserDefaults.standard.otpEmail ?? "")
        dataTask = URLSession.shared.request(route: .resendOtp, method: .post, parameters: ["username": UserDefaults.standard.otpEmail ?? ""], model: SuccessModel.self) { result in
            switch result {
            case .success(let otp):
                SVProgressHUD.showSuccess(withStatus: otp.message)
                self.countDonwTimer()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        guard let otp1 = firstTF.text,  let otp2 = secondTF.text,  let otp3 = thirdTF.text,  let otp4 = forthTF.text else { return  }
        fetch(parameters: ["otp": otp1 + otp2 + otp3 + otp4])
    }
    
    func fetch(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .verifyOtp, method: .post, parameters: parameters, model: OTPModel.self) { result in
            switch result {
            case .success(let res):
                if res.success == true{
                    self.view.makeToast(res.message)
                    Switcher.goToLoginVC(delegate: self)
                }
                else{
                    self.view.makeToast(res.message)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension OTPViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField.text?.count == 1{
//            if textField == firstTF {
//                firstTF.resignFirstResponder()
//                secondTF.becomeFirstResponder()
//            }
//        }
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == firstTF {
//            firstTF.resignFirstResponder()
//            secondTF.becomeFirstResponder()
//        }
//    }
}
