//
//  TwitterSelectAccountTableViewController.swift
//  NetNewsWire-iOS
//
//  Created by Maurice Parker on 4/23/20.
//  Copyright © 2020 Ranchero Software. All rights reserved.
//

import UIKit
import Account

class TwitterSelectAccountTableViewController: UITableViewController {
	
	private var twitterFeedProviders = [TwitterFeedProvider]()
	
	var twitterFeedType: TwitterFeedType?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		twitterFeedProviders = ExtensionPointManager.shared.activeExtensionPoints.values.compactMap { $0 as? TwitterFeedProvider }
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return twitterFeedProviders.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = "@\(twitterFeedProviders[indexPath.row].screenName)"
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let twitterFeedType = twitterFeedType else { return }

		let username = twitterFeedProviders[indexPath.row].screenName
		let url = TwitterFeedProvider.buildURL(twitterFeedType, username: username, screenName: nil, searchField: nil)?.absoluteString

		let addViewController = UIStoryboard.add.instantiateViewController(withIdentifier: "AddWebFeedViewController") as! AddFeedViewController
		addViewController.addFeedType = .twitter
		addViewController.initialFeed = url
		navigationController?.pushViewController(addViewController, animated: true)
	}
	
}
