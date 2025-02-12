public protocol CoordinatorOutput {
    var finishFlow: (() -> Void)? {get}
}
