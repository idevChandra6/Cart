#FlowerMenu framework
FlowerMenu framework includes an expandable menu with customizable items.

#How to integrate into a project:
1. Drag and drop FlowerMenu.framework into the project.
2. Include FlowerMenu.framework into the project target’s embedded binaries.
3. Import FlowerMenu into the Swift files as necessary.

#How to use FlowerMenu:
1. In your storyboard, select the VC that will should include the menu.
2. Insert a Container View with autolayout constraints as follows:

  ```sh
  Width: 66
  Height: 56
  Vertical Spacing to Bottom Layout Guide: 0
  Center Horizontally in Container
  ```
3. Remove the auto-inserted segue and VC attached to the containerView
4. Insert a Storyboard Reference and set its attributes in the Attributes Inspector on the right hand side as follows:

  ```sh
  Storyboard: MenuMain
  Reference ID: MenuViewController
  Bundle: com.visa.FlowerMenu
  ```
5. Create an embed segue from the containerView to the Storyboard Reference and name it:

  ```sh
  MenuViewControllerSegue
  ```
6. Now, in your menu holder VC, create an IBOutlet to to the containerView and name it:

  ```sh
  menuViewContainer
  ```
7. In the menu holder VC, also create the following variable:

  ```sh
  var menuViewController: MenuViewController?
  ```
8. Implement the prepareForSegue method as follows:

  ```sh
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "MenuViewControllerSegue" {
      if let menuViewController = segue.destination as? MenuViewController {
        self.menuViewController = menuViewController
        self.menuViewController?.delegate = self
        self.menuViewController?.moreItems = [MyMoreItemTitles]
        _ = self.menuViewController?.setIconImages(images: MyIconImages)
      }
    }
  }
  ```
Replace MyIconImages with an array of UIImages. These will be displayed as icons for the icon buttons. You may pass up to 6 images.
Replace MyMoreItemTitles with an array of Strings. These will be displayed as a list under the expanded menu.

9. Implement the MainMenuDelegate methods as follows:

  ```sh
  extension ViewController: MainMenuDelegate {
    func mainMenuExpanded() {
      if let menuView = menuViewController?.view {
        menuView.removeFromSuperview()
        self.view.addSubview(menuView)
        menuView.bindFrameToSuperviewBounds()
      }
    }

    func mainMenuCollapsed() {
      if let menuView = menuViewController?.view {
        menuView.removeFromSuperview()
        self.menuViewContainer.addSubview(menuView)
        menuView.bindFrameToSuperviewBounds()
      }
    }

    func didTapMenuIconItemAtIndex(index: Int) {

    }

    func didTapMenuListItemAtIndex(index: Int) {

    }
  }
  ```

#Requirements:
* iOS 10.0+
* Swift 3.0
* Xcode 8.0
