//
//  BudgetModel.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 14.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//
/****************************************
BudgetModel
Contains all data functionality for BudgetViewController

 Contains functions:
    *   getData() - gets inital data from database.
    *   reloadData() - listens for changes in database
    *   calculateRemaining() -> Float - returns a float value based on maxSum and all field sum
    *   isMainUser() -> Bool - returns a bool value based on if the user is the main user of this Space
****************************************/

import UIKit

class BudgetModel {

    private var allFieldSum: [Float] = []
    private var spaceKey: String?
    private let budgetService: PBudgetService?
    private let userService: PUserService?
    private let space: SpaceDO?
    
    var navigateToConfigureBudget: ((_ budgetField: BudgetDO?) -> Void)?
    var addTextToFields: (() -> Void)?
    var navigateToAddField: (() -> Void)?
    var totalBudget: String?
    var dataSource: [BudgetDO] = []
    var dataSourceChanged: (() -> Void)?
    var editBudgetPressed: (() -> Void)?
    var remainingBudget: Float?
    var errorMessage: ((String?) -> Void)?

    init(spaceKey: String?, budgetService: PBudgetService?, _ userService: PUserService?, _ space: SpaceDO?) {
        self.budgetService = budgetService
        self.userService = userService
        self.spaceKey = spaceKey
        self.space = space
        getData()
        reloadData()
    }

    func getData() {
//        BudgetService connects to Firebase and has all functions for budget interaction
        budgetService?.getBudgetFields(spaceKey: spaceKey, completionHandler: { [weak self] (budgetField, totalBudget, error) in
            if error == nil {
                if totalBudget == nil {
                    guard let newField = budgetField else { return }
                    self?.dataSource.append(newField)
                    self?.allFieldSum.append((newField.sum as NSString).floatValue)
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.dataSourceChanged?()
                    self?.addTextToFields?()
                } else {
                    self?.totalBudget = totalBudget
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.addTextToFields?()
                }
            } else {
                self?.errorMessage?(error)
            }
        })
    }

    func reloadData() {
//        BudgetService connects to Firebase and has all functions for budget interaction
        budgetService?.reloadBudgetFields(spaceKey: spaceKey, completionHandler: { [weak self] (budgetField, changedTotalBudget, error) in
            if error == nil {
                if changedTotalBudget == nil {
                    guard let newField = budgetField, let key = budgetField?.key else { return }
                    var index: Int?
                    self?.dataSource.enumerated().forEach { (idx, value) in
                        if value.key == key {
                            index = idx
                        }
                    }
                    guard let idx = index else { return }
                    self?.dataSource[idx] = newField
                    self?.allFieldSum[idx] = (newField.sum as NSString).floatValue
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.dataSourceChanged?()
                    self?.addTextToFields?()
                } else {
                    self?.totalBudget = changedTotalBudget
                    self?.remainingBudget = self?.calculateRemaining()
                    self?.addTextToFields?()
                }
            } else {
                self?.errorMessage?(error)
            }
        }) 
    }

    private func calculateRemaining() -> Float {
        guard let totalBudget = (self.totalBudget as NSString?)?.floatValue else { return 0 }
        return totalBudget - allFieldSum.reduce(0, +)
    }

    func isMainUser() -> Bool {
//        UserService connects to Firebase and has all functions for user interaction
        if userService?.isOwner(userID: space?.mainUser) == true {
            return true
        } else { return false }
    }
}
