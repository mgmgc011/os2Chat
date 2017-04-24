//
//  ChatLogCollectionView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/15/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class ChatLogCollectionView : UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let cellId = "cellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.alwaysBounceVertical = true
        self.backgroundColor = .white
        self.register(ChatLogCollectionCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfItems(inSection section: Int) -> Int {
        return 4
    }

    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCollectionCell
        cell.backgroundColor = .black
        
        return cell
        
    }
    
    
}
