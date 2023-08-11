//
//  RoutinesViewController.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/27/23.
//

import UIKit

class RoutinesViewController : UIViewController {
    
    struct RoutineHabitIdentifier : Hashable {
        var routineIdentifier : RoutineIdentifierType
        var habitIdentifier : HabitIdentifierType
        init(routineIdentifier: RoutineIdentifierType, habitIdentifier: HabitIdentifierType) {
            self.routineIdentifier = routineIdentifier
            self.habitIdentifier = habitIdentifier
        }
        
        static func == (lhs: RoutineHabitIdentifier, rhs: RoutineHabitIdentifier) -> Bool {
            return lhs.routineIdentifier == rhs.routineIdentifier && lhs.habitIdentifier == rhs.habitIdentifier
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(routineIdentifier)
            hasher.combine(habitIdentifier)
        }
    }
    
    typealias RoutineIdentifierType = HabitTrackerSchema.ID
    typealias HabitIdentifierType = HabitTrackerSchema.ID
    typealias RoutineType = HabitTrackerSchema.GetRoutinesListQuery.Data.GetRoutines.Routine
    typealias HabitType = RoutineType.Habit
    typealias RoutineListQuery = HabitTrackerSchema.GetRoutinesListQuery
    typealias RoutineListSectionIdentifierType = Int

    
    var collectionView : UICollectionView! = nil
    
    let apolloClient = ApolloClient(url: URL(string: "http://127.0.0.1:5000/graphql")!)
    
    let topHeaderElementKind = "top-header-element-kind"
    let followingHeaderElementKind = "following-header-element-kind"
    let trailerElementKind = "trailer-element-kind"
        
    var routines = [RoutineType]()
    
    var sectionToEdit :Int?
    
    var sectionHeaderMap = [RoutinesCollectionHeaderView : Int]()
    
    var dataSource : UICollectionViewDiffableDataSource<RoutineListSectionIdentifierType, RoutineHabitIdentifier>! = nil
    
    var routineListWatcher : GraphQLQueryWatcher<HabitTrackerSchema.GetRoutinesListQuery>! = nil
    
    var habitMap = [HabitIdentifierType : HabitType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureNavbar()
        configureDataSource()
        loadRoutines()
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<RoutinesCollectionViewCell, RoutineHabitIdentifier> { [weak self] (cell, indexPath, identifier) in
            guard let self = self else { return }
            guard let habit = habitMap[identifier.habitIdentifier] else {return}
            cell.titleLabel.text = habit.title
            cell.routineCellDelegate = self
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<RoutinesCollectionFollowingHeaderView>(elementKind: followingHeaderElementKind) { [weak self] (headerView, elementKind, indexPath) in
            let title = self?.routines[indexPath.section].title
            headerView.setTitle(title ?? "DEFAULT")
            headerView.delegate = self
            self?.sectionHeaderMap[headerView] = indexPath.section
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, habit: RoutineHabitIdentifier) -> UICollectionViewCell? in
    
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: habit)
        }
        
        dataSource.supplementaryViewProvider = {
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: $2)
        }
                
        routineListWatcher = apolloClient.watch(query: RoutineListQuery()) { [weak self] result in
            guard let self = self else {return}
            guard let data = try? result.get().data else {return}
            
            guard let routineList = data.getRoutines.routines else {return}
            habitMap.removeAll()
            routines = []
            
            var snapshot = NSDiffableDataSourceSnapshot<RoutineListSectionIdentifierType, RoutineHabitIdentifier>()
            
//            snapshot.appendSections([.routine1, .routine2])
            var sectionNumber = 0
            for routine in routineList {
                guard let routine = routine else { continue }
                snapshot.appendSections([sectionNumber])
                sectionNumber += 1
                print(routine.title)
                routines.append(routine)
                guard let habits = routine.habits else { continue }
                var routineHabitList = [RoutineHabitIdentifier]()
                for habit in habits {
                    guard let habit = habit else { continue }
                    print(habit.title)
                    routineHabitList.append(RoutineHabitIdentifier(routineIdentifier: routine.id, habitIdentifier: habit.id))
                    habitMap[habit.id] = habit
                }
                snapshot.appendItems(routineHabitList)
            }
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func loadRoutines(forceReload : Bool = false) {
        let cachePolicy: CachePolicy = forceReload ? .fetchIgnoringCacheData : .returnCacheDataElseFetch
        apolloClient.fetch(query: HabitTrackerSchema.GetRoutinesListQuery(), cachePolicy: cachePolicy) {result in
//            guard let self = self else { return }
            switch result {
            case .success (let graphQLResult):
                print(graphQLResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .systemBackground

        view.addSubview(collectionView!)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemLayout = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            let margin = 8.0
            itemLayout.contentInsets = .init(top:margin, leading: margin, bottom: margin * 3, trailing: margin)
            
            let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.42), heightDimension: .fractionalHeight(0.22)), subitems: [itemLayout])
                        
            let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            //TODO: fix this cause it ain't working
//            let elementKind = sectionIndex == 0 ? self.topHeaderElementKind : self.followingHeaderElementKind
            let elementKind = self.followingHeaderElementKind
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40)), elementKind:elementKind , alignment: .top)
            sectionLayout.boundarySupplementaryItems = [sectionHeader]
            return sectionLayout
        }
        return layout
    }
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: nil)
        title = "My Routines"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        navigationController?.navigationBar.tintColor = .darkGray
    }
}

extension RoutinesViewController : RoutineHeaderDelegate {
    func routineHeaderView(_ headerView: RoutinesCollectionHeaderView, didTapAddHabitButton addHabitButton: UIButton) {
        let viewController = HabitListViewController(mode: .selectionMode, apolloClient: apolloClient)
        viewController.habitListDelegate = self
        let section = sectionHeaderMap[headerView]
        if let section = section {
            sectionToEdit = section
            present(viewController, animated: true)
        }
    }
    
}

extension RoutinesViewController : HabitListViewControllerDelegate {
    
    func habitListViewController(_ viewController: HabitListViewController, didAddHabitWithID id: HabitTrackerSchema.ID) {
        
        guard let section = sectionToEdit else { return }
        let routine = routines[section]
        let routineId = routine.id
        let newIndex = (routine.habits?.count ?? 0) + 1
        apolloClient.perform(mutation: HabitTrackerSchema.AddHabitToRoutineMutation(id: routineId, habit_id: id, index: newIndex)) { [weak self] result in
            guard let self = self else { return }
            switch(result) {
            case .success(_):
                self.loadRoutines(forceReload: true)
            case .failure(_):
                print("ERROR")
            }
        }
    }
}

extension RoutinesViewController : RoutineCellDelegate, HabitCloseupViewControllerDelegate {
    func didCreateNewHabit(withTitle: String, description: String) {
        // no-op
    }
    
    func didUpdateHabit(withId: HabitTrackerSchema.ID, title: String, description: String) {
        //
    }
    
    func closeupViewController(_ viewController: HabitCloseupViewController, didDeleteHabitWithId habit_id: HabitTrackerSchema.ID) {
        //
//        apolloClient.perform(mutation: HabitTrackerSchema.RemoveHabitFromRoutineMutation(habit_id: habit_id, routine_id: viewController.routineID!))
    }
    
    func didSingleTapOnCollectionViewCell(_ cell: RoutinesCollectionViewCell) {
//        guard let indexPath = collectionView?.indexPath(for: cell) else {return}
    
//        guard let routineModel = routines?[indexPath.section] else {return}
//        guard let habitModel = routineModel.habits?[indexPath.item] else {return}
//        let viewController = HabitCloseupViewController(withMode: .editeMode)
//        viewController.viewControllerDelegate = self
//        viewController.titleText = habitModel.title
//        viewController.modelId = habitModel.id
//        viewController.descriptionText = habitModel.description
//        viewController.routineID = routineModel.id
//        present(viewController, animated: true)
    }
    
    func didDoubleTapOnCollectionViewCell(_ cell: RoutinesCollectionViewCell) {
        
    }
    
    
    
}
