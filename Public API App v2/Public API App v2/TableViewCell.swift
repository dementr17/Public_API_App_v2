//
//  TableViewCell.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 20.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memImageView: UIImageView! {
        didSet {
            memImageView.layer.cornerRadius = memImageView.bounds.height / 10
        }
    }
    
    // MARK: - Public methods
    func configure(with mem: Memes?) {
        nameLabel.text = mem?.name
        DispatchQueue.global().async {
            guard let stringUrl = mem?.url else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.memImageView.image = UIImage(data: imageData)
            }
        }
        
    }
}
