//
//  ViewStates.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public enum ViewState<Data> {
    case loading
    case empty
    case showingData(Data)
    case error
}

extension ViewState where Data == Void {
    static var showingData: ViewState {
        return .showingData(())
    }
}
