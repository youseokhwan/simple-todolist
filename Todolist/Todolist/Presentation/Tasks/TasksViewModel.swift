//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRelay
import RxSwift

final class TasksViewModel {
    private let readTaskUseCase: ReadTaskUseCase
    private let writeTaskUseCase: WriteTaskUseCase
    private let disposeBag: DisposeBag

    let allTasks: BehaviorRelay<[Task]>

    init() {
        readTaskUseCase = ReadTaskUseCase()
        writeTaskUseCase = WriteTaskUseCase()
        disposeBag = DisposeBag()

        allTasks = BehaviorRelay(value: readTaskUseCase.allTasks())

        configure()
    }

    private func isFirstFetchOfToday() -> Bool {
        let lastFetchDate = UserDefaultsRepository.lastFetchDate()
        let todayDate = Date.yearMonthDay

        return lastFetchDate < todayDate
    }

    @objc
    func createTask(_ notification: Notification) {
        guard let newTask = notification.userInfo?["newTask"] as? Task else { return }

        allTasks.accept(allTasks.value + [newTask])
    }

    @objc
    func updateTasksAsOfToday() {
        if isFirstFetchOfToday() {
            writeTaskUseCase.updateTasksAsOfToday(tasks: allTasks.value)
        }
    }

    func updateIsDone(of task: Task, value: Bool) {
        writeTaskUseCase.updateIsDone(of: task, value: value)
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        writeTaskUseCase.delete(task: removedTask)
    }

    func moveTask(at sourceRow: Int, to destinationRow: Int) {
        writeTaskUseCase.moveTask(at: sourceRow, to: destinationRow)
    }
}

private extension TasksViewModel {
    func configure() {
        configureBind()
    }

    func configureBind() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createTask(_:)),
                                               name: WriteTaskUseCase.taskCreated,
                                               object: nil)

//        if let taskResults = readTaskUseCase.allTasks(),
//           let orderOfTasksResults = RealmStorage.orderOfTasksResults() {
//            let tasks = Observable.array(from: taskResults)
//            let orderOfTasks = Observable.array(from: orderOfTasksResults)
//
//            Observable.combineLatest(tasks, orderOfTasks)
//                .subscribe(onNext: { [weak self] tasks, orderOfTasks in
//                    guard let ids = orderOfTasks.first?.ids else { return }
//
//                    var reorderedTasks = [Task]()
//
//                    for id in ids {
//                        reorderedTasks.append(contentsOf: tasks.filter { $0.id == id })
//                    }
//
//                    self?.allTasks.accept(reorderedTasks)
//                })
//                .disposed(by: disposeBag)
//        }
    }
}
