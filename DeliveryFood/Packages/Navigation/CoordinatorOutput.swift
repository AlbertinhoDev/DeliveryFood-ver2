public protocol CoordinatorOutput {
    var onFinishFlow: (() -> Void)? {get}
}
