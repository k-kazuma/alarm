

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer

    init() {
    // ModelファイルにつけたSampleModelを指定する
        container = NSPersistentContainer(name: "wakeup")
    // ContainerからStoreを読み込む処理を記述する
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        })
    }
}
