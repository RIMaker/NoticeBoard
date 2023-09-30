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

# Скриншоты
- <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/9e685ba3-ed0c-4fad-975d-48efb52a7746" width="300" /> <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/cd7714d1-5222-431a-a5b4-e728433b9b21" width="300" />
- <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/a2e1b3b8-d682-4c33-9922-67782e4a8cfb" width="300" /> <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/82f65c7c-d233-457a-beb2-718fd1b986ff" width="300" /> 
- <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/11b0fffb-61fc-42aa-bb5c-76eb0d87f69a" width="300" /> <img src="https://github.com/RIMaker/NoticeBoard/assets/35456855/eea7891d-aca5-4875-a685-1030602f90d6" width="300" />
