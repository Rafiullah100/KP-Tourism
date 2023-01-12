//
//  BlogDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
class BlogDetailViewController: BaseViewController {

    @IBOutlet weak var blogTitleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var likeLabel: UILabel!
    var blogDetail: Blog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = blogDetail?.title
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (blogDetail?.thumbnailImage ?? "")))
//        autherLabel.text =
        textView.text = blogDetail?.blogDescription
        blogTitleLabel.text = blogDetail?.title
        autherLabel.text = "Author: \(blogDetail?.users.name ?? "")"
        likeLabel.text = "\(blogDetail?.likes.likesCount ?? 0) Liked"
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        var objectsToShare = [Any]()
        guard let imageUrl = URL(string: Route.baseUrl + (blogDetail?.thumbnailImage ?? "")) else {
            print("Invalid url!")
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data) else{ return }
            objectsToShare.append(image)
            guard let blogDescription: String = self.blogDetail?.blogDescription else {return}
            objectsToShare.append(blogDescription)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            DispatchQueue.main.async {
                self.present(activityViewController, animated: true, completion: nil)
            }
        }.resume()
    }

}
