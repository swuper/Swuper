import UIKit

class RegisterPageViewController: UIPageViewController {
    
    // MARK:- Properties
    var pageControl = UIPageControl()
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "FirstStepViewController"),
            self.getViewController(withIdentifier: "SecondStepViewController"),
            self.getViewController(withIdentifier: "ThirdStepViewController")
        ]
    }()
    
    // MARK:- LifeCyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        //configurePageControl()
        dataSource = self
        delegate = self
        configurePageControl()
        if let firstViewController = pages.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    

    // MARK:- Function
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "MoreView", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 90, width: UIScreen.main.bounds.width,height: 60))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.orange
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.orange
        self.view.addSubview(pageControl)
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

// MARK:- Delegate
extension RegisterPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        if pages.index(of: pageContentViewController) == 0 {
            self.pageControl.isHidden = false
            self.pageControl.currentPage = pages.index(of: pageContentViewController)!
        } else if pages.index(of: pageContentViewController) == 1 {
            self.pageControl.isHidden = false
            self.pageControl.currentPage = pages.index(of: pageContentViewController)!
        } else {
            self.pageControl.isHidden = true
        }
    }
    // 페이지 컨트롤 설정
}

// MARK:- DataSource
extension RegisterPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return pages[nextIndex]
    }
}
