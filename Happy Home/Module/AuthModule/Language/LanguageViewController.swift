//
//  LanguagePopUpViewController.swift
//  HappyHome
//
//  Created by NGEN on 31/10/2024.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var englishImageView: UIImageView!
    @IBOutlet weak var arabicImageView: UIImageView!
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        switchLabel.text = LocalizationKeys.switchYourAppLanguage.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.Continue.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue{
            selectedLanguageArabic()
        }
        else{
            selectedLanguageEnglish()
        }
    }
    
    var appLanguage: AppLanguage = .english
    
    
    @IBAction func englishButtonAction(_ sender: Any) {
        selectedLanguageEnglish()
    }
    
    private func selectedLanguageEnglish(){
        englishImageView.image = UIImage(named: "selected-box")
        arabicImageView.image = UIImage(named: "card-uncheck")
        appLanguage = .english
    }
    
    @IBAction func arabicLanguageButtonAction(_ sender: Any) {
        selectedLanguageArabic()
    }
    
    private func selectedLanguageArabic(){
        arabicImageView.image = UIImage(named: "selected-box")
        englishImageView.image = UIImage(named: "card-uncheck")
        appLanguage = .arabic
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        if appLanguage == .english{
            setLanguage(code: .en, language: .english, isRTL: 0)
        }
        else{
            setLanguage(code: .ar, language: .arabic, isRTL: 1)
        }
    }
    
    func setLanguage(code: AppLanguagecode, language: AppLanguage, isRTL: Int) {
        UserDefaults.standard.isRTL = isRTL
        UserDefaults.standard.selectedLanguage = language.rawValue
        UserDefaults.standard.languageCode = code.rawValue
        UIView.appearance().semanticContentAttribute = isRTL == 1 ? .forceRightToLeft : .forceLeftToRight
        Switcher.gotoHome(delegate: self)
    }
}
