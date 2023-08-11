//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/17/23.
//

import UIKit
import Apollo



class HabitListViewController: UIViewController {
    
    enum HabitListMode {
        case standardMode //for standard list use
        case selectionMode //for adding habits to routines
    }
    
    enum Section {
        case main
    }
    
    //Layout Constants
    let myHabitsMinimumLineSpacing = 4.0

    //List Mode (for modal display vs full screen)
    var mode : HabitListMode
    
    //CollectionView & DataSource properties
    private var collectionView : UICollectionView! = nil
    private var updateManger = HabitListUpdateManager<Section, HabitIdentifierType>()
    private var dataSource : UICollectionViewDiffableDataSource<Section, HabitIdentifierType>! = nil
    private var habitMap = [HabitTrackerSchema.ID : HabitTrackerSchema.GetHabitsListQuery.Data.GetHabits.Habit]()
    private var habitListWatcher : GraphQLQueryWatcher<HabitListQueryType>! = nil
    private var apolloClient : ApolloClient
    
    //Delegates
    var habitListDelegate : HabitListViewControllerDelegate?

        
    init(mode: HabitListMode, apolloClient: ApolloClient) {
        self.mode = mode
        self.apolloClient = apolloClient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        configureNavbar()
        configureDataSource()
        loadHabits()
        
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<HabitSummaryCollectionViewCell, HabitIdentifierType> { [weak self] (cell, indexPath, identifier) in
            guard let self = self else { return }
            guard let habit = habitMap[identifier] else {return}
            cell.titleLabel.text = habit.title
            if let lastCompleted = habit.last_completed {
                cell.lastCompleted = "Last Completed: \(lastCompleted)"
            }
            if let isComplete = habit.is_complete {
                cell.isCompleted = isComplete
            }
            if let streakCount = habit.streak_count {
                let fireEmoji = "\u{1F525}"
                cell.streakLabel.text = "\(fireEmoji) \(streakCount)"
            }
            cell.routineLabels = (habit.routines?.compactMap{$0?.title})!
            cell.configure() // remove this later
            cell.habitSummaryDelegate = self
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, habit: HabitIdentifierType) -> UICollectionViewCell? in
    
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: habit)
        }
                
        habitListWatcher = apolloClient.watch(query: HabitListQueryType()) { [weak self] result in
            guard let self = self else {return}
            guard let data = try? result.get().data else {return}
            
            guard let habitsList = data.getHabits.habits else {return}
            habitMap.removeAll()
            let compactMap = habitsList.compactMap { [weak self] element in
                if let element = element {
                    self?.habitMap[element.id] = element
                    return element.id
                }
                return nil
            }
            
            var snapshot = dataSource.snapshot()
            if snapshot.sectionIdentifiers.isEmpty {
                snapshot.appendSections([.main])
            }
            updateManger.updateSnapshot(&snapshot, withIdentifiers: compactMap)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func habitModelForCell(_ cell : UICollectionViewCell) -> HabitType? {
        guard let indexPath = collectionView.indexPath(for: cell) else {return nil}
        guard let id = dataSource.itemIdentifier(for: indexPath) else {return nil}
        return habitMap[id]
    }
    
    private func loadHabits(forceReload : Bool = false) {
        let cachePolicy: CachePolicy = forceReload ? .fetchIgnoringCacheData : .returnCacheDataElseFetch
        apolloClient.fetch(query: HabitTrackerSchema.GetHabitsListQuery(), cachePolicy: cachePolicy)
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.size.width , height: 100)
        layout.minimumLineSpacing = myHabitsMinimumLineSpacing
        return layout
    }
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapNewHabitButton))
        title = "My Habit Goals"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    @objc private func didTapNewHabitButton() {
        let habitCloseupViewController = HabitCloseupViewController(withMode: .createMode)
        habitCloseupViewController.viewControllerDelegate = self
        self.present(habitCloseupViewController, animated: true)
    }
    
    private func completeHabit(forCloseupViewCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let identifier = dataSource.itemIdentifier(for: indexPath) else {return}
        updateManger.willCompleteHabit(withId: identifier)
        apolloClient.perform(mutation: HabitTrackerSchema.CompleteHabitMutation(id: identifier))
    }


}

extension HabitListViewController : HabitSummaryDelegate {
    
    func didSingleTapOnCollectionViewCell(_ cell: HabitSummaryCollectionViewCell) {
        guard let habit = habitModelForCell(cell) else {return}
        switch(mode) {
        case .standardMode:
            let viewController = HabitCloseupViewController(withMode: .editeMode)
            viewController.viewControllerDelegate = self
            viewController.titleText = habit.title
            viewController.descriptionText = habit.description
            viewController.modelId = habit.id
            present(viewController, animated: true)
        case .selectionMode:
            habitListDelegate?.habitListViewController(self, didAddHabitWithID: habit.id)
            dismiss(animated: true)
        }
    }
    
    func didDoubleTapOnCollectionViewCell(_ cell: HabitSummaryCollectionViewCell) {
        completeHabit(forCloseupViewCell: cell)
    }
}

extension HabitListViewController : HabitCloseupViewControllerDelegate {

    func didUpdateHabit(withId id: HabitTrackerSchema.ID, title: String, description: String) {
        updateManger.willEditHabit(withId: id)
        apolloClient.perform(mutation: HabitTrackerSchema.UpdateHabitMutation(id: id, title: GraphQLNullable(stringLiteral: title), description: GraphQLNullable(stringLiteral: description), lastCompleted: "blah"))
    }
    
    func closeupViewController(_ viewController: HabitCloseupViewController, didDeleteHabitWithId habit_id: HabitTrackerSchema.ID) {
        apolloClient.perform(mutation: HabitTrackerSchema.DeleteHabitMutation(id: habit_id)) { [weak self] result in
            guard let self = self else {return }
            switch result {
                
            case .success(let response):
                self.loadHabits(forceReload: true)
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func didCreateNewHabit(withTitle title: String, description: String) {
        apolloClient.perform(mutation: HabitTrackerSchema.CreateHabitMutation(title: title, description: description)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let graphQLResponse):
                guard let habit = graphQLResponse.data?.createHabit.habits?.first! else {return}
                updateManger.willCreateHabit(withId: habit.id)
                loadHabits(forceReload: true)
            case .failure(let error):
                print(error)
            }
        }
    }
}

