//
//  MainViewController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, MainViewControllerImportsDelegate {

  var presenter: MainViewPresenterDelegate?

  lazy var importController: ImportController = {
    let controller = ImportController()
    controller.presenter = ImportPresenter(
      importControllerDelegate: controller,
      parent: self)
    return controller
  }()

  lazy var decoderController: DecoderViewController = {
    let controller = DecoderViewController()
    controller.presenter = DecodeViewPresenter(
      controller: controller,
      parent: self)
    return controller
  }()

  override func loadView() {
    view = NSView()
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.frame = AppDelegate.size

    addChild(importController)
    addChild(decoderController)
    view.addSubview(importController.view)
    view.addSubview(decoderController.view)
    let padding = NSEdgeInsets(top: 40, left: 8, bottom: 8, right: 8)
    importController.view.anchorInSuperViewDisregarding(
      edges: .trailing,
      padding: padding)
    decoderController.view.anchorInSuperViewDisregarding(
      edges: .leading,
      padding: padding)
    decoderController.view.leadingAnchor.constraint(
      equalTo: importController.view.trailingAnchor,
      constant: 10).isActive = true

    importController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: (AppDelegate.size.width / 2) - 8).isActive = true
    decoderController.view.widthAnchor.constraint(equalTo: importController.view.widthAnchor).isActive = true
  }

  override func viewWillAppear() {
    super.viewWillAppear()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(handle),
      name: .flatAeroError,
      object: nil)
  }

  override func viewWillDisappear() {
    super.viewWillDisappear()
    NotificationCenter.default.removeObserver(self)
  }
}

extension MainViewController: MainViewControllerDecodeDelegate {

  func fetchData() -> SelectedData {
    importController.presenter.fetchData()
  }
}

extension MainViewController: MainViewControllerPresenterDelegate {

  @objc
  func handle(_ notification: Notification) {
    DispatchQueue.main.async {
      guard notification.name == .flatAeroError, let err = notification.object as? Errors else { return }
      Logging.logger.error(err)
      let alert = NSAlert()
      alert.messageText = "Error"
      alert.informativeText = err.errorDescription ?? "Unknown Error Occurred"
      alert.alertStyle = .warning
      alert.addButton(withTitle: "OK")
      alert.runModal()
    }
  }
}
