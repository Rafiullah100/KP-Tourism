//
//  PostViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/28/23.
//

import UIKit

class PostViewController: UIViewController {

    var postType: PostType?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch postType {
        case .post:
            label.text = "Create Post"
        case .story:
            label.text = "Highlight"
        default:
            label.text = "Create Post"
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
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
