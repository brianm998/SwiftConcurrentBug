import Foundation

print("Hello, cruel world!")

let maxNumberOfTasks = ProcessInfo.processInfo.activeProcessorCount*10

let maxNumber = 10000000

if #available(macOS 10.15, *) {
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    Task {
        _ = await withTaskGroup(of: Void.self) { taskGroup in

            for _ in 0..<maxNumberOfTasks {
                taskGroup.addTask() {
                    var base = 0
                    for _ in 0..<maxNumber {
                        base += 1
                    }
                }
            }
            
            await taskGroup.waitForAll()
        }
        dispatchGroup.leave()
    }
    dispatchGroup.wait()
    print("success, not dead!")
} else {
    print("cannot run on this version of macos")
}

