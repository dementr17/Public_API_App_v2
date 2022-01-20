//
//  InfoViewController.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 19.01.2022.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView! {
        didSet {
            imageLabel.layer.cornerRadius = imageLabel.frame.width / 10
        }
    }
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var idLabel: UILabel!
        
    
    var url = ""
    var name = "xcs"
    var memsInfo: Memes? {
        didSet{
            url = memesInfo?.url ?? ""
            name = memesInfo?.name ?? ""
            self.loadView()
        }
    }
    var memesInfo: Memes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        DispatchQueue.global().async {
            guard let imageData = NetworkingManager.shared.fetchImage(from: self.memesInfo?.url) else { return }
            DispatchQueue.main.async {
                self.imageLabel.image = UIImage(data: imageData)
            }
        }
        
    }
        
    }

extension InfoViewController {
    func configure() {
            nameLabel.text = memesInfo?.name
            idLabel.text = "ID: \(memesInfo?.id ?? "")"
            sizeLabel.text = String("\(memesInfo?.width ?? 0) x \(memesInfo?.height ?? 0)")
            countLabel.text = String("Box count: \(memesInfo?.box_count ?? 0)")
    }
}
