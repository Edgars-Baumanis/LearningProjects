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
    private var spaceKey: String?
    private var ideaTopic: TopicDO?
    private var userServices: PUserService?
    private var ideaServices: PIdeaService?

    init(rootController: UINavigationController?, spaceKey: String?, userServices: PUserService?, ideaService: PIdeaService?) {
        self.userServices = userServices
        self.rootController = rootController
        self.spaceKey = spaceKey
        self.ideaServices = ideaService
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

    private var ideaTopicController: IdeaTopic? {
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
        let viewModel = IdeasModel(spaceKey: spaceKey, ideaService: ideaServices)

        viewModel.navigateToAddTopic = { [weak self] in
            self?.navigateToAddIdeaTopic()
        }

        viewModel.navigateToIdea = { [weak self] cellName in
            self?.ideaTopic = cellName
            self?.navigateToIdeaTopics()
        }

        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddIdeaTopic() {
        guard let vc = addIdeasController else { return }
        let viewModel = AddTopicModel(spaceKey: spaceKey, ideaService: ideaServices)
        viewModel.addTopicPressed = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToIdeaTopics() {
        guard let vc = ideaTopicController else { return }
        let viewModel = IdeaTopicModel(topicName: ideaTopic, spaceKey: spaceKey, userServices: userServices, ideaService: ideaServices)
        viewModel.addPressed = { [weak self] in
            self?.navigateToAddIdea()
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }

    private func navigateToAddIdea() {
        guard let vc = addIdeaController else { return }
        let viewModel = AddIdeaModel(spaceKey: spaceKey, topicName: ideaTopic)
        viewModel.ideaAdded = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        vc.viewModel = viewModel
        rootController?.pushViewController(vc, animated: true)
    }
}
