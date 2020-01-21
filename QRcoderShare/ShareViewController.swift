//
//  ShareViewController.swift
//  QRcoderShare
//
//  Created by higuchi の iMac on 2020/01/21.
//  Copyright © 2020 higuchi の iMac. All rights reserved.
//

import UIKit
import MobileCoreServices

class ShareViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as? NSExtensionItem, let itemProviders = extensionItem.attachments else { return }
        let identifier = "public.url"
        let urlProvider = itemProviders.first(where: { $0.hasItemConformingToTypeIdentifier(identifier)})
        urlProvider?.loadItem(forTypeIdentifier: identifier, options: nil, completionHandler: { [weak self] (item, error) in
            // item に格納されている
            guard let url = item as? String else { return }
            print(url)
            // 最後にこれを呼ばないとフリーズする
            self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        })
    }
}
