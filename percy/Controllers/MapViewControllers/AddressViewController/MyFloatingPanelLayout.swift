//
//  MyFloatingPanelLayout.swift
//  percy
//
//  Created by Антон Усов on 28.09.2021.
//

import FloatingPanel

class MyFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition { .bottom }
    var initialState: FloatingPanelState { .tip }
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 250, edge: .bottom, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 104, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 104.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
