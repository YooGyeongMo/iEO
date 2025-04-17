//
//  Coordinator.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//
//
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
