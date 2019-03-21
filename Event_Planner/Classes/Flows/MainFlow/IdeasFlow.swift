//
//  IdeasFlow.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 20.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

class IdeasFlow: FlowController {

    private var rootController: UINavigationController?
    private var spaceName: String?
    private var ideaTopicName: String?

    init(rootController: UINavigationController?, spaceName: String?) {
        self.rootController = rootController
        self.spaceName = spaceName
    }

    private lazy var ideasSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.IdeasSB.rawValue, bundle: Bundle.main)
    }()

    private lazy var ideaTopicSB: UIStoryboard = {
        return UIStoryboard.init(name: Strings.IdeaTopicSB.rawValue, bundle: Bundle.main)
    }()

    private var ideasViewController: IdeasController? {
        return ideasSB.instantiateViewController(withIdentifier: String(describing: IdeasController.self)) as? IdeasController
    }

    private var addIdeasController: AddTopicController? {
        return ideasSB.instantiateViewController(withIdentifier: String(describing: AddTopicController.self)) as? AddTopicController
    }

    private var ideaTopic: IdeaTopic? {
        return ideaTopicSB.instantiateViewController(withIdentifier: String(describing: IdeaTopic.self)) as? IdeaTopic
    }

    private var addIdeaController: AddIdea? {
        return ideaTopicSB.instantiateViewController(withIdentifier: String(describing: AddIdea.self)) as? AddIdea
    }

    func start() {
        navigateToIdeas()
    }

    private func navigateToIdeas() {
        guard let vc = ideasViewController else { return }
        let viewModel = IdeasModel(spaceName: spaceName)

        viewModel.addTopicPressed = { [weak self] in
            self?.navigateToAddIdeaTopic()
        }

        viewModel.cellPressed = { [weak self] cellName in
            self?.ideaTopicName = cellName
            self?.navigateToIdeaTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddIdeaTopic() {
        guard let vc = addIdeasController else { return }
        let viewModel = AddTopicModel(spaceName: spaceName)
        viewModel.addTopicPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToIdeaTopics() {
        guard let vc = ideaTopic else { return }
        let viewModel = IdeaTopicModel(topicName: ideaTopicName, spaceName: spaceName)
        viewModel.addPressed = { [weak self] in
            self?.navigateToAddIdea()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddIdea() {
        guard let vc = addIdeaController else { return }
        let viewModel = AddIdeaModel(spaceName: spaceName, topicName: ideaTopicName)
        viewModel.ideaAdded = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
