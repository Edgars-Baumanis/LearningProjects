//
//  PBudgetService.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 28.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import Foundation

protocol PBudgetService {
    func getBudgetFields(spaceKey: String?, completionHandler: @escaping (BudgetDO?, String?, String?) -> Void)
    func reloadBudgetFields(spaceKey: String?, completionHandler: @escaping (BudgetDO?, String?, String?) -> Void)
    func addField(spaceKey: String?, fieldName: String?, fieldSum: String?, completionHandler: (String?) -> Void)
    func addTotalSum(spaceKey: String?, totalSum: String?, completionHandler: (String?) -> Void)
    func changeField(spaceKey: String?, fieldName: String?, fieldSum: String?, fieldKey: String?, completionHandler: (String?) -> Void)
}
