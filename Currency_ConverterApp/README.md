# Currency-converter
Конвертер валют. В данном приложении Вы можете сравнить курс валют разных стран, представленных ЦБ РФ.
Для того, чтобы начать выберите валюту путем нажатия на соответствующую кнопку. Ввод суммы доступен для обеих валют.
Для того, чтобы начать вводить сумму - выберите ячейку с ней и вводите желаемое количество денег :)
Будет автоматически произведен расчет в противоположной ячейке.

![simulator_screen_shot_-_iphone_11_-_2022-08-29_at_03_01_47 WmOIb](https://user-images.githubusercontent.com/86362091/187092772-ee2af943-ce1d-4ac0-ab05-4e092c0e23f0.png)

Во вкладке "Валюты" Вы можете увидеть актуальный курс по отношению к российскому рублю.

![simulator_screen_shot_-_iphone_11_-_2022-08-29_at_03_02_11 7osJ4](https://user-images.githubusercontent.com/86362091/187092801-03d6fa9b-4c8d-44fb-99cd-6e8d17bd0223.png)

Для того, чтобы добавить в избранное валюту - на экране со всеми валютами свайпните ячейку вправо. 
Повторите действие, если хотите удалить из избранного. Для того, чтобы полностью удалить ненужную валюту - свайпните ячейку влево.

![simulator_screen_shot_-_iphone_11_-_2022-08-29_at_03_02_41 NDPJk](https://user-images.githubusercontent.com/86362091/187092834-bbb4a2c8-81ae-45e5-bc73-b8f37d7bc684.png)

На экране "Избранное" Вы можете увидеть все валюты, которые были помечены, как избранные.

![simulator_screen_shot_-_iphone_11_-_2022-08-29_at_03_03_23 rUacy](https://user-images.githubusercontent.com/86362091/187092881-39785b1b-369b-4064-9140-f168c36c9dea.png)

В основе проекта лежит архитектура MVC. Выбор был обоснован небольшим количеством экранов и не высокой сложностью проекта.
Актуальная информация по валютам получается в следствие парсинга XML данных, полученных с сайта ЦБ РФ. 
В качестве базы данных был использован Realm. Вкладка "Избранное" читается из БД по фильтрации данных, отмеченных как "Избранное".
