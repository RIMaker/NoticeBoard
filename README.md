# NoticeBoard
Данный проект был выполнен в рамках тестового задания в Avito.

# Стек технологий
* UIKit
* MVP+Router
* URLSession

## Инструкция по сборке проекта
Для запуска проекта склонируйте репозиторий на ваш ПК, затем просто откройте файл с расширением `.xcodeproj` и начните процесс сборки:

# Реализация
- Для отображения списка на главном экране, а также для отображения экрана с детальной информацией используется `UICollectionView` (см. `NoticeBoard/Common/Core/NBCollectionView`)
- У каждого экрана есть свойство `state`, которое наследуется от суперкласса `NBViewController` (см. `NoticeBoard/Common/Core/NBViewController/NBViewController.swift`)
- Для загрузки изображений используется класс `UIImageLoader` (см. `NoticeBoard/Common/Util/UIImageLoader.swift`), который сжимает загруженные изображения с помощью добавленного в класс `UIImage` метода `scale(newWidth:)` (см. `NoticeBoard/Common/Extension/UIImage + scale.swift`) и кэширует их в `NSCache`
- Работа с сетью, обработка потери сети / отсутствия соединения имплементировано в классе `NetworkClientImpl` (см. `NoticeBoard/Common/Data/Networking/NetworkClient/NetworkClient.swift`)
- Для конфигурации экранов используется паттерн `Factory` в классе `FeatureFactoryImpl` (см. `NoticeBoard/Common/Assembler/FeatureFactory.swift`)
- Для переходов между экранами используется слой `Router`
- Работа с многопоточностью происходит через `GCD`
