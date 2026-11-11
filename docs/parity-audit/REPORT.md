# Сверка функциональности старой и новой программы УЗИ

Первичная инвентаризация: 8 ноября 2026 года. Текущее выполнение исправлений: [IMPLEMENTATION-STATUS.md](IMPLEMENTATION-STATUS.md). **Полного функционального соответствия сейчас нет.**

Сверены 546 файлов исходников и классов: 457 файлов экранов/шаблонов, 132 ветки действий PHP, 33 класса Java-команд и 187 версии форм. Это инвентаризация файлов и сценариев, а не заявление о прохождении всех комбинаций состояний. Общие шапки и подвалы включены в число шаблонов, но не считаются отдельными рабочими экранами.

**Как читать:** «Есть аналог» означает, что соответствующее действие найдено, но не обещает попиксельное или клиническое совпадение. Колонка проверки отдельно показывает, что проверено тестом, а что только по исходникам. «Нет» для архивного общего модуля не означает, что этот модуль использовался врачом.

**Охват установки.** В исходном меню три пункта: администрирование, пользовательский справочник, работа с видами исследований; JSP-интерфейс УЗИ имеет собственное меню. Регистратура, расписание, касса, полная амбулаторная карта и часть отчётности найдены в общем архиве, но не подтверждены как работавшие модули этого кабинета. Таблиц расписания/регистрации/оплаты в перенесённой базе нет, справочники кабинетов и ЛПУ пусты. Их нельзя ни молча обещать, ни автоматически исключить из будущего объёма.

**Метод и ограничения.** Старый сервер и всё оборудование в этой сверке не запускались. Выполнены статическое сопоставление, текущие 22 Rust-теста и 17 Vitest-тестов, проверка открытия новых экранов на вымышленных данных и повторная проверка цикла заготовки. Браузерные проверки с имитацией IPC проверяют UI, но не заменяют проверку настоящего exe с SQLite. Старые отчёты native-acceptance и сравнения текста используются только как историческое свидетельство. Рабочая база не изменялась.

## Исправить в первую очередь

- **S02 — Скрытые виды исследований.** При импорте потерян флаг скрытия вида. Старые скрытые виды id 478 и 1063 теперь предлагаются в списке, включая неподдерживаемый beremen2.
- **S04 — Заполнить структурированные поля рабочих форм.** Подтверждены отсутствующие поля: sel_vena и r_chash_size в brooho_1; r_chash_size в pochki_1; вычисляемое matka_ob в ginekol_11. Существующие значения могут появляться как дополнительные, но в новой пустой форме полей нет.
- **S05 — Условные поля и ветви органов.** Новые активные поля выводятся из печатного шаблона, а не из полного старого JS. Полнота всех сочетаний условий не проверена. Есть переключатель «Показать все поля».
- **S11 — Продолжить незавершённые исследования.** Черновики видны в общей хронологии, но нет отдельного списка/фильтра. После согласованного удаления 5 070 пустых заготовок в исходном наборе остаётся 41 запись status=0.
- **S12 — Удалить отдельный протокол.** В новой системе нет команды и действия удаления/скрытия исследования. Скрытие всей карточки пациента это не заменяет.
- **D04 — Создавать и изменять вложенные разделы справочника.** Новая система управляет только текстовыми листьями. Старые узлы могли становиться родителями; произвольно расширять и переименовывать дерево теперь нельзя.
- **D05 — Копировать / перемещать заготовки и ветви.** Нет выбора другого раздела/вида при редактировании, нет массового копирования и переноса.
- **D07 — Редактор базового справочника book: названия, значения, скрытие, ключи.** Справочник стандартных вариантов и конфигурация зашиты в JSON. UI управления book и его связью с полями отсутствует.
- **D08 — Создать новый вид исследования.** «Новая заготовка» добавляет текст, а не новый вид исследования. В UI нет создания вида, его кода, пола, версии и структуры.
- **F03 — Открыть уже существовавшие объединения протоколов.** В исходной базе 5 контейнеров и 10 связей. Они сохранены как legacy_container/legacy_research, но не перенесены в study_bundles/bundle_items и не доступны как старые комплекты через UI.

## Существенные цифры и выводы

- В 16 реально встречавшихся версиях сохранённых исследований исторически сравнивался итоговый текст на 1 189 записях без расхождений после нормализации пробелов. Это не проверка ввода всех полей, всех ветвей и всех сценариев.
- В рабочих формах найдены четыре отсутствующих элемента: `sel_vena` и `r_chash_size` в `brooho_1`, `r_chash_size` в `pochki_1`, вычисляемое `matka_ob` в `ginekol_11`. Поля подтверждены в исходных JSP, не только поиском по словам. Архивные значения могут показываться как дополнительные; в новой пустой форме заполнить их тем же способом нельзя.
- Из 187 версий в каталоге 174 поддерживаются печатным компилятором. Среди остальных есть 11 исходных печатных шаблонов с неподдерживаемыми конструкциями и две формы без самостоятельного печатного файла. Полный перечень приведён ниже.
- В исходной базе 5 объединений и 10 связей протоколов. Они сохранены в `legacy_*`, но не доступны как комплекты в новом интерфейсе.
- Из 15 импортированных видов два были скрыты (`478`, `1063`), а новая таблица видов не хранит этот признак. `1063 / BEREMEN2` дополнительно не имеет исходной формы в доступном архиве.
- Старый пользовательский справочник поддерживал не только CRUD текстов: вложенность, порядок, копирование и перенос. Новые CRUD текстов не закрывают эти сценарии.
- После согласованной очистки 5 070 пустых заготовок остаётся 41 исходное незавершённое исследование. Они не потеряны, но отдельного фильтра для их продолжения нет.
- Протоколов с заявленными старыми снимками/видео — 0. Поддержка новых вложений проверялась на синтетических файлах; перенос не доказывает интеграцию с аппаратом.

## Порядок закрытия пробелов

1. Восстановить поля и пройти все ветви рабочих форм; проверить тексты и расчёты на обезличенных примерах.
2. Восстановить доступ к старым объединениям и добавить безопасное удаление исследования/комплекта, список черновиков.
3. Закрыть сценарии справочника: разделы, вложенность, перемещение/копирование, порядок. Отдельно — базовый справочник вариантов и управление видами.
4. Сохранить скрытие видов и согласовать ограничения по полу/версиям.
5. Согласовать необходимый объём статистики, ролей, общих административных и клинических модулей.
6. Пройти приёмку с врачом: один чек-лист на каждый используемый вид, печать на целевом принтере, реальные файлы с аппарата.

Исправления в программе в рамках этой сверки не вносились: это зафиксированный список работ. Для каждой строки ниже указан критерий приёмки, чтобы следующая проверка не сводилась к «экран открывается».

## Матрица сценариев

| ID | Область / сценарий | Статус / приоритет | Где было | Где сейчас | Различие и проверка |
| --- | --- | --- | --- | --- | --- |
| A01 | Доступ: **Вход под врачом / администратором**<br>Рабочий УЗИ | Есть аналог / — | [jsp/identify.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/identify.jsp:1>)<br>[WEB-INF/classes/my_pack/commands/DoIdentifyCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/DoIdentifyCommand.class:1>) | [src/components/LoginScreen.vue:1](<F:/med-stuff/uzi-db/src/components/LoginScreen.vue:1>)<br>[src-tauri/src/security.rs:69](<F:/med-stuff/uzi-db/src-tauri/src/security.rs:69>) | Новая система создаёт свои учётные записи, старые пароли не переносились.<br>**Проверка:** Текущие Rust-тесты + UI входа.<br>**Приёмка:** Успешный и неверный пароль; перезапуск; роль после входа. |
| A02 | Доступ: **Выход, смена врача, блокировка**<br>Рабочий УЗИ | Изменено / — | [jsp/identify.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/identify.jsp:1>)<br>[WEB-INF/classes/my_pack/handlers/IdentifyHandler.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/handlers/IdentifyHandler.class:1>) | [src/stores/auth.ts:10](<F:/med-stuff/uzi-db/src/stores/auth.ts:10>)<br>[src/App.vue:11](<F:/med-stuff/uzi-db/src/App.vue:11>) | Вместо идентификации сеанса по IP — локальная учётная запись. Добавлены выход и блокировка бездействия.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Выйти, войти другим врачом; блокировка сохраняет введённый текст. |
| A03 | Доступ: **Группы пользователей и разрешения по модулям**<br>Рабочий УЗИ | Частично / P2 | [php/administration.php:11](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:11>)<br>[php/administration.php:210](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:210>) | [src/views/Users.vue:10](<F:/med-stuff/uzi-db/src/views/Users.vue:10>)<br>[src-tauri/src/security.rs:22](<F:/med-stuff/uzi-db/src-tauri/src/security.rs:22>) | Старые группы и матрица разрешений заменены фиксированными ролями admin/doctor/viewer. Создавать группы и назначать права на отдельные модули нельзя.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Согласовать нужные роли; проверить матрицу на каждом действии. |
| A04 | Доступ: **Добавить, изменить, отключить пользователя**<br>Рабочий УЗИ | Есть аналог / — | [php/administration.php:140](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:140>)<br>[php/administration.php:185](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:185>) | [src/views/Users.vue:1](<F:/med-stuff/uzi-db/src/views/Users.vue:1>)<br>[src-tauri/src/security.rs:81](<F:/med-stuff/uzi-db/src-tauri/src/security.rs:81>) | Вместо физического удаления есть отключение; пароль и роль меняются.<br>**Проверка:** Текущие Rust-тесты + UI страницы.<br>**Приёмка:** Создать врача, изменить имя/пароль, отключить; последний администратор защищён. |
| A05 | Доступ: **Изменить имя врача в протоколах / скрыть врача**<br>Рабочий УЗИ | Частично / P2 | [php/administration.php:185](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:185>)<br>[php/administration.php:165](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:165>) | [src/views/Users.vue:14](<F:/med-stuff/uzi-db/src/views/Users.vue:14>)<br>[src-tauri/src/main.rs:51](<F:/med-stuff/uzi-db/src-tauri/src/main.rs:51>) | Учётная запись и справочник doctors разделены. Добавление врача есть; изменения doctors.name/hidden через UI нет. Правка имени учётной записи не переименовывает врача в протоколах.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Добавить врача, переименовать его в справочнике и проверить старые/новые протоколы. |
| P01 | Пациенты: **Картотека, список и переход в карточку**<br>Рабочий УЗИ | Есть аналог / — | [jsp/view_all_pacient.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/view_all_pacient.jsp:1>)<br>[php/html/tools/show_pacient_list.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/tools/show_pacient_list.html:1>) | [src/views/PatientIndex.vue:1](<F:/med-stuff/uzi-db/src/views/PatientIndex.vue:1>)<br>[src/views/PatientDetail.vue:1](<F:/med-stuff/uzi-db/src/views/PatientDetail.vue:1>) | Есть страницы, сортировки, размеры таблицы, история.<br>**Проверка:** Текущие Rust-тесты + UI страниц.<br>**Приёмка:** Найти пациента на другой странице; открыть историю и вернуться. |
| P02 | Пациенты: **Поиск по ФИО и номеру пациента**<br>Рабочий УЗИ | Есть аналог / — | [jsp/search/search_main.jsp:7](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/search/search_main.jsp:7>)<br>[WEB-INF/classes/my_pack/commands/SearchCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/SearchCommand.class:1>) | [src/views/PatientIndex.vue:1](<F:/med-stuff/uzi-db/src/views/PatientIndex.vue:1>)<br>[src-tauri/src/repository.rs:92](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:92>) | Новый поиск по подстроке/точному ID. Тождественность старого фонетического алгоритма не доказана.<br>**Проверка:** Текущие Rust-тесты + UI.<br>**Приёмка:** Фрагмент ФИО, ё/е, номер, отсутствие результата, специальные символы. |
| P03 | Пациенты: **Добавление пациента с ФИО, полом, адресом, датой рождения**<br>Рабочий УЗИ | Есть аналог / — | [jsp/add_pacient.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/add_pacient.jsp:1>) | [src/components/PatientForm.vue:1](<F:/med-stuff/uzi-db/src/components/PatientForm.vue:1>)<br>[src-tauri/src/repository.rs:125](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:125>) | Все поля основной JSP-карточки перенесены; неизвестную дату можно оставить пустой.<br>**Проверка:** Текущие Rust-тесты; исторический native-acceptance.<br>**Приёмка:** Добавить карточку, переоткрыть, изменить адрес и неизвестную дату. |
| P04 | Пациенты: **Редактирование карточки**<br>Рабочий УЗИ | Есть аналог / — | [jsp/edit_pacient.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/edit_pacient.jsp:1>) | [src/components/PatientForm.vue:1](<F:/med-stuff/uzi-db/src/components/PatientForm.vue:1>)<br>[src-tauri/src/repository.rs:125](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:125>) | Сохраняется предыдущая версия и проверяется revision.<br>**Проверка:** Текущие Rust-тесты.<br>**Приёмка:** Две копии формы: вторая не должна затирать первую. |
| P05 | Пациенты: **Удаление / скрытие пациента**<br>Рабочий УЗИ | Изменено / — | [WEB-INF/classes/my_pack/commands/DeletePacientCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/DeletePacientCommand.class:1>)<br>[php/index.php:1100](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/index.php:1100>) | [src/views/PatientDetail.vue:1](<F:/med-stuff/uzi-db/src/views/PatientDetail.vue:1>)<br>[src/components/ArchiveMaintenance.vue:1](<F:/med-stuff/uzi-db/src/components/ArchiveMaintenance.vue:1>)<br>[src-tauri/src/records.rs:19](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:19>) | В новой системе администратор скрывает карточку и может вернуть её без потери исследований.<br>**Проверка:** Текущие Rust-тесты; исторический native-acceptance.<br>**Приёмка:** Скрыть и восстановить; все исследования остаются. |
| P06 | Пациенты: **Расширенные паспортные, страховые, социальные поля**<br>Общая медицинская система; использование не подтверждено | Нет / P3 | [php/html/tools/show_add_edit_pacient.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/tools/show_add_edit_pacient.html:1>)<br>[php/registration.php:1731](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/registration.php:1731>) | [src/types.ts:1](<F:/med-stuff/uzi-db/src/types.ts:1>)<br>[src/components/PatientForm.vue:1](<F:/med-stuff/uzi-db/src/components/PatientForm.vue:1>) | В новой карточке нет документов, СНИЛС, страхования, места работы и социальных сведений. В исходной базе эти дополнительные поля семантически пусты. JSP-карточка УЗИ их также не содержит.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Определить, нужен ли общий регистратурный вариант карточки. |
| S01 | Исследования: **Выбрать вид исследования и врача**<br>Рабочий УЗИ | Есть аналог / — | [jsp/prepare_protocol.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/prepare_protocol.jsp:1>)<br>[jsp/select_research.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/select_research.jsp:1>) | [src/views/StudyEditor.vue:38](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:38>) | Вид и врач выбираются в новой форме; 15 записей видов импортированы.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Создать каждый доступный вид; проверить форму и печать. |
| S02 | Исследования: **Скрытые виды исследований**<br>Рабочий УЗИ | Нет / P1 | [WEB-INF/classes/my_pack/handlers/BookHandler.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/handlers/BookHandler.class:1>) | [src-tauri/schema.sql:4](<F:/med-stuff/uzi-db/src-tauri/schema.sql:4>)<br>[src/views/StudyEditor.vue:38](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:38>)<br>[tools/migrate.py:71](<F:/med-stuff/uzi-db/tools/migrate.py:71>) | При импорте потерян флаг скрытия вида. Старые скрытые виды id 478 и 1063 теперь предлагаются в списке, включая неподдерживаемый beremen2.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** В новых исследованиях скрытые виды не предлагаются; старые записи продолжают открываться. |
| S03 | Исследования: **Ограничение вида исследования по полу пациента**<br>Рабочий УЗИ | Частично / P2 | [jsp/add_pacient.jsp:16](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/add_pacient.jsp:16>)<br>[php/research.php:53](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/research.php:53>) | [src/views/StudyEditor.vue:38](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:38>) | Настройки BASE.SEX в новой форме не используются: список видов общий. Требуется сверить поведение выбора с врачом.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Пациенты обоих полов: согласованные предупреждения/фильтрация. |
| S04 | Исследования: **Заполнить структурированные поля рабочих форм**<br>Рабочий УЗИ | Частично / P1 | [jsp/protocol_form/brooho_1.jsp:282](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/brooho_1.jsp:282>)<br>[jsp/protocol_form/pochki_1.jsp:37](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/pochki_1.jsp:37>)<br>[jsp/protocol_form/ginekol_11.jsp:55](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/ginekol_11.jsp:55>) | [src/catalog.json:1](<F:/med-stuff/uzi-db/src/catalog.json:1>)<br>[src/components/StructuredFields.vue:1](<F:/med-stuff/uzi-db/src/components/StructuredFields.vue:1>) | Подтверждены отсутствующие поля: sel_vena и r_chash_size в brooho_1; r_chash_size в pochki_1; вычисляемое matka_ob в ginekol_11. Существующие значения могут появляться как дополнительные, но в новой пустой форме полей нет.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Сверить каждое поле каждого рабочего вида, включая скрытые ветви, не только итоговый текст. |
| S05 | Исследования: **Условные поля и ветви органов**<br>Рабочий УЗИ | Частично / P1 | [jsp/protocol_form/brooho_1.jsp:95](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/brooho_1.jsp:95>)<br>[jsp/protocol_form/shit_1.jsp:89](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/shit_1.jsp:89>) | [src/legacy.ts:20](<F:/med-stuff/uzi-db/src/legacy.ts:20>)<br>[src/views/StudyEditor.vue:43](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:43>) | Новые активные поля выводятся из печатного шаблона, а не из полного старого JS. Полнота всех сочетаний условий не проверена. Есть переключатель «Показать все поля».<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Для каждого селекта/чекбокса проверить раскрытие соответствующих полей и сброс/сохранение значений. |
| S06 | Исследования: **Расчёты щитовидной железы, ЭхоКГ, объёмов**<br>Рабочий УЗИ | Есть аналог / — | [jsp/protocol_form/shit_1.jsp:119](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/shit_1.jsp:119>)<br>[jsp/protocol_form/eho_kg_2.jsp:81](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/eho_kg_2.jsp:81>)<br>[jsp/protocol_form/ginekol_11.jsp:333](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/ginekol_11.jsp:333>)<br>[jsp/protocol_form/brooho_1.jsp:483](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/brooho_1.jsp:483>) | [src/calculations.ts:1](<F:/med-stuff/uzi-db/src/calculations.ts:1>)<br>[src/calculations.test.ts:1](<F:/med-stuff/uzi-db/src/calculations.test.ts:1>) | Четыре семейства формул перенесены. Сравнение с исходным JS есть; это не клиническая валидация. Поле matka_ob отсутствует в основном каталоге (S04).<br>**Проверка:** Текущие Vitest-тесты: 120 синтетических наборов + проверки жизненного цикла.<br>**Приёмка:** Проверить полные/неполные размеры, запятую, единицы, изменение размеров. |
| S07 | Исследования: **Расчёты остальных архивных форм**<br>Не настроенные в кабинете архивные формы | Частично / P2 | [jsp/protocol_form/kardio_9.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/kardio_9.jsp:1>)<br>[jsp/protocol_form/schit_4.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/schit_4.jsp:1>)<br>[jsp/protocol_form/skrin_w_6.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/skrin_w_6.jsp:1>) | [src/calculations.ts:2](<F:/med-stuff/uzi-db/src/calculations.ts:2>) | В архиве больше JS-расчётов: скрининги, расширенная кардиология, другие версии. Новая функция поддерживает четыре семейства. Эти виды не настроены в текущем кабинете, но общий паритет всех исходников отсутствует.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** При подключении каждого такого вида переносить и отдельно сверять его формулы. |
| S08 | Исследования: **Заключение, комментарий и свободное описание**<br>Рабочий УЗИ | Есть аналог / — | [jsp/protocol_form/footer.jsp:4](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/footer.jsp:4>)<br>[jsp/protocol_form/footer.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/footer.jsp:1>) | [src/views/StudyEditor.vue:20](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:20>) | Есть заключение и дополнение; добавлено свободное описание. Обязательная привязка диагноза к узлу старого справочника снята.<br>**Проверка:** Текущие Rust-тесты + UI вставки.<br>**Приёмка:** Сохранить многострочный текст и проверить печать. |
| S09 | Исследования: **Просмотр перед окончательным сохранением**<br>Рабочий УЗИ | Изменено / P2 | [jsp/protocol_form/footer.jsp:13](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/footer.jsp:13>)<br>[jsp/protocol_view/footer.jsp:19](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/footer.jsp:19>) | [src/views/StudyEditor.vue:91](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:91>) | Вместо отдельного перехода на JSP просмотра — предпросмотр структурированной части и печать сохранённой записи. Полный документ до сохранения не выделен отдельным действием.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Врач проверяет весь документ перед выдачей, включая заключение и дополнения. |
| S10 | Исследования: **Сохранить, завершить и повторно открыть**<br>Рабочий УЗИ | Есть аналог / — | [WEB-INF/classes/my_pack/commands/SaveProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/SaveProtocolCommand.class:1>)<br>[WEB-INF/classes/my_pack/commands/SaveAndPrintProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/SaveAndPrintProtocolCommand.class:1>) | [src-tauri/src/repository.rs:143](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:143>)<br>[src/views/StudyEditor.vue:64](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:64>) | Черновик/final; защита от устаревшей версии. «Сохранить и напечатать» разделено на два действия.<br>**Проверка:** Текущие Rust-тесты; исторический native-acceptance.<br>**Приёмка:** Сохранить, перезапустить, открыть и распечатать. |
| S11 | Исследования: **Продолжить незавершённые исследования**<br>Рабочий УЗИ | Частично / P1 | [jsp/not_saved_research.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/not_saved_research.jsp:1>) | [src/views/StudyIndex.vue:1](<F:/med-stuff/uzi-db/src/views/StudyIndex.vue:1>)<br>[src/format.ts:19](<F:/med-stuff/uzi-db/src/format.ts:19>) | Черновики видны в общей хронологии, но нет отдельного списка/фильтра. После согласованного удаления 5 070 пустых заготовок в исходном наборе остаётся 41 запись status=0.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Получить список всех незавершённых, в том числе без знания ФИО/номера. |
| S12 | Исследования: **Удалить отдельный протокол**<br>Рабочий УЗИ | Нет / P1 | [WEB-INF/classes/my_pack/commands/DeleteProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/DeleteProtocolCommand.class:1>)<br>[jsp/not_saved_research.jsp:16](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/not_saved_research.jsp:16>) | [src-tauri/src/main.rs:1](<F:/med-stuff/uzi-db/src-tauri/src/main.rs:1>)<br>[src/views/StudyEditor.vue:1](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:1>) | В новой системе нет команды и действия удаления/скрытия исследования. Скрытие всей карточки пациента это не заменяет.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Удалить ошибочное исследование без удаления других; восстановление и журнал. |
| S13 | Исследования: **Найти протокол по номеру**<br>Рабочий УЗИ | Есть аналог / — | [jsp/search/search_main.jsp:8](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/search/search_main.jsp:8>) | [src/views/StudyIndex.vue:1](<F:/med-stuff/uzi-db/src/views/StudyIndex.vue:1>)<br>[src-tauri/src/repository.rs:111](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:111>) | ФИО/номер протокола перенесены на страницу исследований.<br>**Проверка:** Текущие Rust-тесты + UI страницы.<br>**Приёмка:** Один и тот же номер в картотеке и исследованиях не должен путаться. |
| S14 | Исследования: **Редактировать старый протокол и неизвестные параметры**<br>Рабочий УЗИ | Есть аналог / — | [WEB-INF/classes/my_pack/commands/PrepareEditProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/PrepareEditProtocolCommand.class:1>) | [src/views/StudyEditor.vue:37](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:37>)<br>[src-tauri/src/repository.rs:52](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:52>) | Сохраняется исходная версия, исходные таблицы и история правок; неподдерживаемые значения выводятся отдельно.<br>**Проверка:** Текущие Rust-тесты.<br>**Приёмка:** Открыть редкую версию; сохранить без потери неизвестных полей. |
| S15 | Исследования: **Все 187 исторических форм как полноценные редакторы**<br>Рабочий УЗИ | Частично / P2 | [jsp/protocol_form/ginekol_5.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/ginekol_5.jsp:1>)<br>[jsp/protocol_view/second_1.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/second_1.jsp:1>) | [src/catalog.json:1](<F:/med-stuff/uzi-db/src/catalog.json:1>)<br>[src/legacy-templates.json:1](<F:/med-stuff/uzi-db/src/legacy-templates.json:1>)<br>[src/legacy.ts:1](<F:/med-stuff/uzi-db/src/legacy.ts:1>) | Каталог содержит 187 версий, печатный компилятор — 174. Полная экранная/условная эквивалентность не доказана; 16 использованных версий проверялись только по тексту на выборке.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** См. полный реестр форм, затем пройти ветви и действия нужных версий. |
| S16 | Исследования: **Создать на основе предыдущего исследования**<br>Дополнение новой программы | Добавлено / — | [jsp/after_save_protocol.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/after_save_protocol.jsp:1>) | [src/views/StudyEditor.vue:56](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:56>) | В новой системе есть явное копирование записи на того же пациента; это дополнение, не доказательство паритета.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Копия сохраняется новым ID; исходная запись не меняется. |
| D01 | Справочники: **Просмотр пользовательских заготовок, поиск и фильтр**<br>Рабочий УЗИ | Есть аналог / — | [php/books.php:4](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:4>) | [src/components/TemplateLibrary.vue:1](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:1>)<br>[src-tauri/src/records.rs:108](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:108>) | Источник book_users сохранён: 1 105 узлов, включая разделы и скрытые записи.<br>**Проверка:** Текущие Rust-тесты + текущие UI-сценарии.<br>**Приёмка:** Найти по тексту/пути, фильтровать видом, показать скрытые. |
| D02 | Справочники: **Добавить текстовую заготовку в существующий раздел**<br>Рабочий УЗИ | Есть аналог / — | [php/books.php:97](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:97>) | [src/components/TemplateLibrary.vue:26](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:26>)<br>[src-tauri/src/records.rs:128](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:128>) | Добавление реализовано в текущей сборке; исходные таблицы не перезаписываются.<br>**Проверка:** Текущие Rust-тесты + текущий полный UI-цикл.<br>**Приёмка:** Добавить, перезапустить, найти, вставить, отредактировать, удалить, вернуть. |
| D03 | Справочники: **Изменить, удалить и восстановить текстовую заготовку**<br>Рабочий УЗИ | Есть аналог / — | [php/books.php:141](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:141>)<br>[php/books.php:76](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:76>) | [src/components/TemplateLibrary.vue:16](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:16>)<br>[src-tauri/src/records.rs:151](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:151>) | Есть конфликт версий и восстановление. Исследования содержат вставленную копию текста и автоматически не меняются.<br>**Проверка:** Текущие Rust-тесты + текущий UI-цикл.<br>**Приёмка:** Изменение, отмена удаления, подтверждение, повторный вход, восстановление. |
| D04 | Справочники: **Создавать и изменять вложенные разделы справочника**<br>Рабочий УЗИ | Нет / P1 | [php/books.php:122](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:122>)<br>[php/html/research_user/edit_main_book_record.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/research_user/edit_main_book_record.html:1>) | [src-tauri/src/records.rs:158](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:158>)<br>[src/components/TemplateLibrary.vue:23](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:23>) | Новая система управляет только текстовыми листьями. Старые узлы могли становиться родителями; произвольно расширять и переименовывать дерево теперь нельзя.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Создать подраздел внутри «Заключительные признаки», добавить дочерние тексты и переименовать раздел. |
| D05 | Справочники: **Копировать / перемещать заготовки и ветви**<br>Рабочий УЗИ | Нет / P1 | [php/research_user.php:70](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/research_user.php:70>)<br>[php/research.php:167](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/research.php:167>) | [src/components/TemplateLibrary.vue:1](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:1>) | Нет выбора другого раздела/вида при редактировании, нет массового копирования и переноса.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Перенос одной заготовки и копирование ветви между видами без потери потомков. |
| D06 | Справочники: **Менять порядок заготовок**<br>Рабочий УЗИ | Нет / P2 | [php/books.php:278](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:278>) | [src-tauri/src/records.rs:112](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:112>)<br>[src/components/TemplateLibrary.vue:1](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:1>) | Старый порядок читается, но менять его нельзя. Новые записи выводятся перед исходными.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Поставить часто используемую заготовку первой и проверить порядок после перезапуска. |
| D07 | Справочники: **Редактор базового справочника book: названия, значения, скрытие, ключи**<br>Рабочий УЗИ | Нет / P1 | [jsp/book/add_book.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/book/add_book.jsp:1>)<br>[jsp/book/edit_book.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/book/edit_book.jsp:1>)<br>[php/html/research/edit_main_book_record.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/research/edit_main_book_record.html:1>) | [src/catalog.json:1](<F:/med-stuff/uzi-db/src/catalog.json:1>)<br>[src/legacy-dictionary.json:1](<F:/med-stuff/uzi-db/src/legacy-dictionary.json:1>) | Справочник стандартных вариантов и конфигурация зашиты в JSON. UI управления book и его связью с полями отсутствует.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Изменить вариант селекта, добавить новый, скрыть старый без нарушения архива. |
| D08 | Справочники: **Создать новый вид исследования**<br>Рабочий УЗИ | Нет / P1 | [php/research.php:22](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/research.php:22>)<br>[php/html/research/prepare_create_research.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/research/prepare_create_research.html:1>) | [src-tauri/schema.sql:4](<F:/med-stuff/uzi-db/src-tauri/schema.sql:4>)<br>[src/views/StudyEditor.vue:38](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:38>) | «Новая заготовка» добавляет текст, а не новый вид исследования. В UI нет создания вида, его кода, пола, версии и структуры.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Создать отдельный вид и проверить форму, заготовки, печать, статистику. |
| D09 | Справочники: **Выбрать версию формы и конфигурацию параметров**<br>Рабочий УЗИ | Нет / P2 | [php/research.php:83](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/research.php:83>)<br>[php/html/research/edit_main_book_record.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/html/research/edit_main_book_record.html:1>) | [src/legacy-versions.json:1](<F:/med-stuff/uzi-db/src/legacy-versions.json:1>)<br>[src/catalog.json:1](<F:/med-stuff/uzi-db/src/catalog.json:1>) | Текущие версии и наборы полей задаются в коде. Администратор не может менять их в приложении.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Изменить версию для новых исследований; старые продолжают использовать исходную. |
| D10 | Справочники: **Обновить пользовательский справочник из базового**<br>Рабочий УЗИ | Нет / P2 | [php/books.php:177](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:177>)<br>[php/index.php:811](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/index.php:811>) | [src/components/TemplateLibrary.vue:12](<F:/med-stuff/uzi-db/src/components/TemplateLibrary.vue:12>) | Кнопка «Обновить» сейчас только перечитывает список. Старый update_book_users создавал недостающие служебные ветви из базового справочника.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** После нового вида/поля новые ветви появляются без удаления пользовательских текстов. |
| D11 | Справочники: **Подстановка в заключение, дополнения и параметры**<br>Рабочий УЗИ | Есть аналог / — | [jsp/protocol_form/header.jsp:39](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form/header.jsp:39>)<br>[reference.html:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/reference.html:1>)<br>[reference.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/reference.jsp:1>)<br>[php/books.php:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/books.php:1>) | [src/views/StudyEditor.vue:21](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:21>)<br>[src/userTemplates.ts:7](<F:/med-stuff/uzi-db/src/userTemplates.ts:7>) | Есть общий выбор поля вставки и добавление к тексту. Старый выбор из конкретного поля и Enter заменён явной кнопкой.<br>**Проверка:** Текущие UI-сценарии вставки.<br>**Приёмка:** Вставка не заменяет существующий текст; вид/раздел не путаются. |
| F01 | Печать и медиа: **Одиночный протокол и повторная печать**<br>Рабочий УЗИ | Есть аналог / — | [jsp/protocol_view/footer.jsp:22](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/footer.jsp:22>)<br>[jsp/after_save_protocol.jsp:8](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/after_save_protocol.jsp:8>) | [src/components/ProtocolDocument.vue:1](<F:/med-stuff/uzi-db/src/components/ProtocolDocument.vue:1>)<br>[src/views/StudyEditor.vue:72](<F:/med-stuff/uzi-db/src/views/StudyEditor.vue:72>) | Печать A4 через WebView/Windows, PDF через системный принтер. Физический принтер не проверялся в этой сверке.<br>**Проверка:** Исторический native-acceptance + код; принтер не проверен.<br>**Приёмка:** A4/PDF, длинный текст, переносы, подпись; затем физический принтер. |
| F02 | Печать и медиа: **Объединить несколько исследований в комплект**<br>Рабочий УЗИ | Есть аналог / — | [WEB-INF/classes/my_pack/commands/FusionProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/FusionProtocolCommand.class:1>)<br>[jsp/protocol_view/protocol.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/protocol.jsp:1>) | [src/views/PatientDetail.vue:18](<F:/med-stuff/uzi-db/src/views/PatientDetail.vue:18>)<br>[src-tauri/src/records.rs:39](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:39>) | Новая модель сохраняет комплект из 2–20 завершённых исследований одного пациента и печатает их страницами. Старый общий макет заменён.<br>**Проверка:** Текущие Rust-тесты; исторический native-acceptance.<br>**Приёмка:** Разный пациент/черновик/дубликат запрещены; порядок документов сохраняется. |
| F03 | Печать и медиа: **Открыть уже существовавшие объединения протоколов**<br>Рабочий УЗИ | Нет / P1 | [WEB-INF/classes/my_pack/commands/prepareViewFusionProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/prepareViewFusionProtocolCommand.class:1>) | [tools/migrate.py:1](<F:/med-stuff/uzi-db/tools/migrate.py:1>)<br>[src-tauri/src/records.rs:48](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:48>) | В исходной базе 5 контейнеров и 10 связей. Они сохранены как legacy_container/legacy_research, но не перенесены в study_bundles/bundle_items и не доступны как старые комплекты через UI.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Все 5 старых объединений доступны с исходным составом/порядком; одиночные исследования не меняются. |
| F04 | Печать и медиа: **Удалить объединённый протокол / комплект**<br>Рабочий УЗИ | Нет / P2 | [WEB-INF/classes/my_pack/commands/DeleteFusionProtocolCommand.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/commands/DeleteFusionProtocolCommand.class:1>) | [src/views/BundleView.vue:1](<F:/med-stuff/uzi-db/src/views/BundleView.vue:1>)<br>[src-tauri/src/main.rs:1](<F:/med-stuff/uzi-db/src-tauri/src/main.rs:1>) | Создать комплект можно; удалить или изменить состав уже созданного через UI нельзя.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Удаление комплекта не удаляет входящие исследования. |
| F05 | Печать и медиа: **Изображения: просмотр, включение в печать, удаление**<br>Рабочий УЗИ | Есть аналог / — | [jsp/protocol_view/footer.jsp:25](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/footer.jsp:25>)<br>[jsp/protocol_view/protocol.jsp:105](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/protocol.jsp:105>) | [src/components/Attachments.vue:1](<F:/med-stuff/uzi-db/src/components/Attachments.vue:1>)<br>[src-tauri/src/records.rs:55](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:55>) | Новые изображения хранятся в базе, есть экспорт и мягкое удаление. В исходном наборе нет протоколов с объявленными снимками. Старый захват с оборудования не подтверждён исходниками.<br>**Проверка:** Текущие Rust-тесты; исторические native-тесты на синтетических файлах.<br>**Приёмка:** Добавить PNG/JPEG, экспортировать, напечатать выбранное, убрать. |
| F06 | Печать и медиа: **Видеоклипы AVI и другие видео**<br>Рабочий УЗИ | Частично / P2 | [jsp/protocol_view/protocol.jsp:60](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/protocol.jsp:60>) | [src/components/Attachments.vue:1](<F:/med-stuff/uzi-db/src/components/Attachments.vue:1>)<br>[src-tauri/src/records.rs:8](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:8>) | Есть хранение/экспорт и поддержка WebView. AVI может требовать внешний проигрыватель. Старых заявленных клипов — 0.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Проверить реальные кодеки и видео с аппарата; сохранность файла важнее встраиваемого воспроизведения. |
| F07 | Печать и медиа: **Точный старый бланк, шапка и компоновка объединённого документа**<br>Рабочий УЗИ | Изменено / P2 | [jsp/protocol_view/header.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/header.jsp:1>)<br>[jsp/protocol_view/header19092010.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/header19092010.jsp:1>)<br>[jsp/protocol_view/protocol.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/protocol.jsp:1>) | [src/components/ProtocolDocument.vue:1](<F:/med-stuff/uzi-db/src/components/ProtocolDocument.vue:1>)<br>[src/views/BundleView.vue:1](<F:/med-stuff/uzi-db/src/views/BundleView.vue:1>) | Текст проверялся на выборке, но бланк и компоновка адаптированы. Это не полное визуальное соответствие.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Сравнить образцы всех рабочих видов с врачом; физический принтер и многостраничность. |
| R01 | Отчёты: **Количество исследований по видам за период**<br>Модуль в архиве; ссылка в меню отсутствует | Частично / P2 | [php/statistic.php:128](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/statistic.php:128>)<br>[php/modules/statistic/statistic.php:158](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/modules/statistic/statistic.php:158>) | [src/views/Statistics.vue:1](<F:/med-stuff/uzi-db/src/views/Statistics.vue:1>)<br>[src-tauri/src/records.rs:26](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:26>) | Есть агрегаты по видам и CSV. Нет старого выбора поддерева видов, детализации пациентами и отдельного печатного отчёта.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Совпадение итогов по одинаковому периоду/статусам; детальная расшифровка. |
| R02 | Отчёты: **Выработка по врачам**<br>Модуль в архиве; ссылка в меню отсутствует | Частично / P2 | [php/statistic.php:33](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/statistic.php:33>) | [src/views/Statistics.vue:8](<F:/med-stuff/uzi-db/src/views/Statistics.vue:8>)<br>[src-tauri/src/records.rs:31](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:31>) | Есть количество по врачам, но нет выборки конкретного набора врачей и списка пациентов как в старом отчёте.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Один врач, несколько врачей, итоги и пациенты. |
| R03 | Отчёты: **Отчёт по заключительным признакам / ветвям диагнозов**<br>Модуль в архиве; ссылка в меню отсутствует | Нет / P2 | [php/statistic.php:172](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/statistic.php:172>)<br>[php/modules/statistic/statistic.php:233](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/modules/statistic/statistic.php:233>) | [src/views/Statistics.vue:1](<F:/med-stuff/uzi-db/src/views/Statistics.vue:1>)<br>[src-tauri/src/repository.rs:12](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:12>) | Новый протокол сохраняет conclusion как текст, но не decision_id. Старый отчёт по дереву признаков нельзя точно воспроизвести только поиском по строке.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Сохранить связь с признаком отдельно от текста; проверить отчёт по группе. |
| R04 | Отчёты: **Отчёт по направляющим ЛПУ / врачам**<br>Модуль в архиве; исходные справочники пусты | Нет / P3 | [php/statistic.php:239](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/statistic.php:239>) | [src/views/Statistics.vue:1](<F:/med-stuff/uzi-db/src/views/Statistics.vue:1>) | Нет справочника и ввода направления. В исходных таблицах ЛПУ и направляющих врачей нет строк, ссылки протоколов нулевые.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Подтвердить необходимость направления и соответствующей отчётности. |
| R05 | Отчёты: **Кассовый Z-отчёт и регистратурная отчётность**<br>Архивный общий модуль; не подтверждён | Нет / P3 | [php/modules/statistic/statistic.php:446](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/modules/statistic/statistic.php:446>)<br>[php/modules/statistic/statistic.php:887](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/modules/statistic/statistic.php:887>) | [src/views/Statistics.vue:1](<F:/med-stuff/uzi-db/src/views/Statistics.vue:1>) | Код есть в общей системе; таблиц регистрации/оплаты в перенесённом наборе нет. Не подтверждено, что модуль работал в этом кабинете.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Не включать в обязательный объём УЗИ без подтверждения использования. |
| X01 | Общая система: **Кабинеты и направляющие учреждения**<br>Административные экраны; пустые справочники | Нет / P3 | [php/administration.php:396](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:396>)<br>[php/administration.php:279](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/administration.php:279>) | [src/views/Users.vue:1](<F:/med-stuff/uzi-db/src/views/Users.vue:1>) | В новой программе нет этих редакторов. Исходные cabinets/lpu/lpu_doctor пусты; меню администратора их содержит.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Зафиксировать, нужны ли они в локальном кабинете. |
| X02 | Общая система: **Расписание и запись на приём**<br>Не подключено в меню; зависимости неполны | Нет / P3 | [php/index.php:35](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/index.php:35>)<br>[php/registration.php:4](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/registration.php:4>) | [src/main.ts:1](<F:/med-stuff/uzi-db/src/main.ts:1>) | Есть маршруты/код общей системы, но таблиц schedule/registration в исходной базе нет; часть требуемых файлов не найдена.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Установить, использовалась ли отдельная инсталляция регистратуры. |
| X03 | Общая система: **Оплаты, прайс, документы, очередь**<br>Не подключено в меню; зависимости неполны | Нет / P3 | [php/registration.php:1614](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/registration.php:1614>)<br>[php/registration.php:1183](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/registration.php:1183>)<br>[php/registration.php:1881](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/registration.php:1881>) | [src/main.ts:1](<F:/med-stuff/uzi-db/src/main.ts:1>) | В новой программе отсутствуют. В исходном кабинете price/price_name пусты, бухгалтерских/регистрационных таблиц нет.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Подтвердить необходимость отдельно от задачи переноса УЗИ. |
| X04 | Общая система: **Амбулаторная карта: прививки, стационар, диспансеризация, контроль посещений**<br>Не подключено в меню; зависимости неполны | Нет / P3 | [php/karta_pacient.php:162](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/karta_pacient.php:162>)<br>[php/karta_pacient.php:266](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/karta_pacient.php:266>)<br>[php/karta_pacient.php:833](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/karta_pacient.php:833>) | [src/views/PatientDetail.vue:1](<F:/med-stuff/uzi-db/src/views/PatientDetail.vue:1>) | Есть история УЗИ, но не общая амбулаторная карта. Часть старых экранов содержит статические заготовки; нужных таблиц нет.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Не считать эти страницы действовавшей функцией без исходной рабочей установки. |
| X05 | Общая система: **Сетевой доступ с нескольких компьютеров**<br>Архитектурное различие | Изменено / P2 | [WEB-INF/classes/MainServlet.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/MainServlet.class:1>)<br>[WEB-INF/classes/my_pack/handlers/IdentifyHandler.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/handlers/IdentifyHandler.class:1>) | [src-tauri/src/instance.rs:1](<F:/med-stuff/uzi-db/src-tauri/src/instance.rs:1>)<br>[PRODUCT.md:1](<F:/med-stuff/uzi-db/PRODUCT.md:1>) | Старая система клиент-серверная, новая — локальная с одним экземпляром на базу. Это архитектурная граница, а не проверенная сетевая замена.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Если нужен общий доступ — отдельное решение; общий файл SQLite по сети не использовать. |
| B01 | Данные: **Сохранность исходных таблиц, ID и связей**<br>Рабочий УЗИ | Есть аналог / — | [WEB-INF/classes/my_pack/handlers/ProtocolHandler.class:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/WEB-INF/classes/my_pack/handlers/ProtocolHandler.class:1>) | [tools/migrate.py:1](<F:/med-stuff/uzi-db/tools/migrate.py:1>)<br>[docs/migration-report.json:1](<F:/med-stuff/uzi-db/docs/migration-report.json:1>) | 20 исходных таблиц сохранены как legacy_*. Предыдущая сверка значений по SHA-256 есть; это не означает, что каждая связь доступна через UI (см. F03).<br>**Проверка:** Историческая миграционная сверка + текущие агрегаты только для чтения.<br>**Приёмка:** Сверка количества/хешей; выборочный просмотр без изменения рабочей базы. |
| B02 | Данные: **Пустые исходные заготовки без пациента**<br>Рабочий УЗИ | Согласованное изменение / — | [jsp/not_saved_research.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/not_saved_research.jsp:1>) | [src-tauri/src/maintenance.rs:20](<F:/med-stuff/uzi-db/src-tauri/src/maintenance.rs:20>)<br>[docs/empty-orphan-cleanup.json:1](<F:/med-stuff/uzi-db/docs/empty-orphan-cleanup.json:1>) | 5 070 пустых заготовок удалены по ранее принятому решению с резервной копией. Их отсутствие не является случайной потерей функции.<br>**Проверка:** Текущие Rust-тесты.<br>**Приёмка:** Заполненные и связанные записи не удаляются. |
| B03 | Данные: **Резервные копии и восстановление**<br>Дополнение новой программы | Добавлено / — | [php/replace_db.php:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/php/replace_db.php:1>) | [src/components/BackupManager.vue:1](<F:/med-stuff/uzi-db/src/components/BackupManager.vue:1>)<br>[src-tauri/src/maintenance.rs:1](<F:/med-stuff/uzi-db/src-tauri/src/maintenance.rs:1>) | Ежедневные и ручные копии, проверка и страховочная копия перед восстановлением. replace_db.php — не аналог полноценной системы бэкапов.<br>**Проверка:** Текущие Rust-тесты; исторический native-acceptance.<br>**Приёмка:** Новая копия открывается отдельно; восстановление и ошибочные файлы. |
| B04 | Данные: **История изменений и конфликт сохранения**<br>Дополнение новой программы | Добавлено / — | — | [src-tauri/src/repository.rs:9](<F:/med-stuff/uzi-db/src-tauri/src/repository.rs:9>)<br>[src-tauri/src/records.rs:163](<F:/med-stuff/uzi-db/src-tauri/src/records.rs:163>) | Журнал и предыдущие значения есть, но нет отдельного UI возврата любой предыдущей версии записи.<br>**Проверка:** Текущие Rust-тесты + UI конфликта.<br>**Приёмка:** Конфликт не теряет введённый текст; исходные значения сохранены. |
| B05 | Данные: **Доставка обновления программы**<br>Дополнение новой программы | Добавлено / — | — | [src/components/AppUpdate.vue:1](<F:/med-stuff/uzi-db/src/components/AppUpdate.vue:1>)<br>[src-tauri/src/updater.rs:1](<F:/med-stuff/uzi-db/src-tauri/src/updater.rs:1>) | В новой программе есть проверка и установка обновления exe. Это новая функция, не часть паритета старого справочника.<br>**Проверка:** Текущие Rust-тесты updater; реальное обновление не запускалось.<br>**Приёмка:** Подпись/хеш и откат при неудаче; реальное обновление отдельно не запускалось. |
| V01 | Границы проверки: **Скрытый beremen2 без исходной формы**<br>Исходная форма отсутствует | Требует проверки / P2 | [jsp/select_research.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/select_research.jsp:1>) | [src/legacy-versions.json:1](<F:/med-stuff/uzi-db/src/legacy-versions.json:1>)<br>[src/legacy.ts:1](<F:/med-stuff/uzi-db/src/legacy.ts:1>) | В базе есть скрытый вид 1063 / BEREMEN2, но соответствующей формы нет ни в архиве, ни в новом каталоге. Это не подтверждённый пропуск копирования файла; сначала убрать из новых назначений и выяснить назначение.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Проверить исходную рабочую папку врача, если этот вид нужен. |
| V02 | Границы проверки: **Физический принтер, аппарат УЗИ, Windows 10 и реальные кодеки**<br>Рабочий УЗИ | Требует проверки / P2 | [jsp/protocol_view/protocol.jsp:1](<C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_view/protocol.jsp:1>) | [docs/WINDOWS10-ACCEPTANCE.md:1](<F:/med-stuff/uzi-db/docs/WINDOWS10-ACCEPTANCE.md:1>) | В этой сверке не подключались принтер/аппарат, не запускались все старые серверные сценарии и все комбинации 187 форм.<br>**Проверка:** Сверено по исходникам.<br>**Приёмка:** Приёмка с врачом на целевом компьютере и обезличенных примерах. |
| Z01 | Служебные части: **Общие шапки, подвал, ошибки, паспортная вставка**<br>Общие части экранов | Служебное / — | — | — | Общие фрагменты не считаются отдельным пользовательским сценарием. Их функции сопоставляются с родительскими экранами.<br>**Проверка:** Инвентаризация файлов.<br>**Приёмка:** Проверить состав родительского экрана. |
| Z02 | Служебные части: **Тестовые/пробные JSP и базовые классы команд**<br>Технические артефакты архива | Требует проверки / — | — | — | Наличие файла или класса само по себе не доказывает рабочий сценарий в установленном кабинете.<br>**Проверка:** Инвентаризация файлов.<br>**Приёмка:** Не включать в обязательную функциональность без подтверждения назначения. |

## Виды исследований текущего кабинета

| ID | Название | Новая версия | Скрыт в старой | Поля / печать |
| --- | --- | --- | --- | --- |
| 10 | УЗИ исследование | universal_1 | нет | 0 / есть |
| 18 | УЗИ щитовидной железы | shit_1 | нет | 32 / есть |
| 80 | УЗИ брюшной полости | brooho_1 | нет | 147 / есть |
| 190 | Эхокардиография | eho_kg_2 | нет | 36 / есть |
| 248 | УЗИ гинекологическое | ginekol_11 | нет | 67 / есть |
| 323 | УЗИ коленных суставов | koleno_1 | нет | 80 / есть |
| 393 | УЗИ почек | pochki_1 | нет | 37 / есть |
| 451 | УЗИ молочных желез | moloch_1 | нет | 19 / есть |
| 478 | УЗИ при беременности | beremen_1 | да | 79 / есть |
| 523 | УЗИ во II и III триместрах беременности | trimestr_1 | нет | 26 / есть |
| 678 | УЗИ поясничного отдела позвоночника | pos_pojas_1 | нет | 81 / есть |
| 976 | УЗИ шейного отдела позвоночника | poz_sheja_1 | нет | 89 / есть |
| 1063 | УЗИ при беременности | beremen2_1 | да | 0 / нет |
| 1064 | УЗИ при беременности | beremen1_1 | нет | 79 / есть |
| 1152 | УЗИ в 10-14 недель беременностии | beremen14_1 | нет | 47 / есть |

## Реестр всех версий форм

Наличие каталога или скомпилированного шаблона не подтверждает интерактивную эквивалентность. «Пропуски» — сравнение прямых вызовов полей; для рабочих форм S04 проверены строки JSP. Для остальных это кандидаты на ручную проверку. `passport_1` — общая вставка. Число записей относится к исходному набору до очистки.

| Версия | Поля в каталоге | Печать | Записей / исторических образцов | Пропуски прямых полей | JS-функций в оригинале |
| --- | --- | --- | --- | --- | --- |
| akush_spec_1 | 10 | есть | 0 / 0 | — | 0 |
| aller_1 | 10 | есть | 0 / 0 | — | 0 |
| berem14_1 | 45 | есть | 0 / 0 | — | 1 |
| berem_1 | 28 | есть | 0 / 0 | — | 0 |
| berem_2 | 31 | есть | 0 / 0 | — | 0 |
| berem_3 | 31 | есть | 0 / 0 | — | 0 |
| berem_4 | 37 | есть | 0 / 0 | — | 0 |
| beremen14_1 | 47 | есть | 413 / 100 | — | 0 |
| beremen1_1 | 79 | есть | 799 / 100 | — | 0 |
| beremen_1 | 79 | есть | 71 / 71 | — | 0 |
| biopsia_1 | 1 | есть | 0 / 0 | — | 0 |
| biopsia_2 | 1 | есть | 0 / 0 | — | 0 |
| brooho_1 | 147 | есть | 19083 / 100 | r_chash_size, sel_vena | 11 |
| brooho_2 | 158 | есть | 0 / 0 | — | 2 |
| brooho_3 | 160 | есть | 0 / 0 | — | 4 |
| citpap_1 | 3 | есть | 0 / 0 | — | 0 |
| dupleks_1 | 27 | есть | 0 / 0 | — | 0 |
| dupleks_2 | 27 | есть | 0 / 0 | — | 0 |
| dupleks_ekstra_1 | 8 | есть | 0 / 0 | — | 0 |
| dupleks_golovi_1 | 0 | есть | 0 / 0 | — | 0 |
| dupleks_magven_1 | 0 | есть | 0 / 0 | — | 0 |
| dupleks_nij_1 | 2 | есть | 0 / 0 | — | 0 |
| dupleks_venniz_1 | 0 | есть | 0 / 0 | — | 0 |
| dupleks_verhart_1 | 0 | есть | 0 / 0 | — | 0 |
| duplex_abaort_1 | 0 | есть | 0 / 0 | — | 0 |
| duplexpart_1 | 0 | есть | 0 / 0 | — | 0 |
| echo_1 | 13 | есть | 0 / 0 | — | 0 |
| echo_2 | 13 | есть | 0 / 0 | — | 0 |
| egds_1 | 4 | есть | 0 / 0 | — | 0 |
| egds_2 | 4 | есть | 0 / 0 | — | 0 |
| egds_3 | 4 | есть | 0 / 0 | — | 0 |
| eho_kg_1 | 36 | есть | 159 / 100 | — | 6 |
| eho_kg_2 | 36 | есть | 7355 / 100 | — | 6 |
| ekgram_1 | 1 | есть | 0 / 0 | — | 0 |
| farma_1 | 43 | есть | 0 / 0 | — | 0 |
| farma_2 | 43 | есть | 0 / 0 | — | 0 |
| fgds_1 | 1 | есть | 0 / 0 | — | 0 |
| first_1 | 17 | есть | 0 / 0 | — | 1 |
| first_2 | 15 | есть | 0 / 0 | — | 1 |
| first_3 | 15 | есть | 0 / 0 | — | 1 |
| first_4 | 24 | есть | 0 / 0 | — | 1 |
| ginekol_1 | 65 | есть | 500 / 100 | — | 8 |
| ginekol_11 | 67 | есть | 15503 / 100 | matka_ob | 9 |
| ginekol_2 | 79 | есть | 0 / 0 | — | 1 |
| ginekol_3 | 81 | есть | 0 / 0 | — | 7 |
| ginekol_4 | 83 | есть | 0 / 0 | — | 7 |
| ginekol_5 | 56 | нет | 0 / 0 | — | 8 |
| golen_1 | 24 | есть | 0 / 0 | — | 0 |
| golen_2 | 24 | есть | 0 / 0 | — | 0 |
| holter_1 | 32 | есть | 0 / 0 | — | 0 |
| jeludok_1 | 13 | есть | 0 / 0 | — | 0 |
| jeludok_2 | 13 | есть | 0 / 0 | — | 0 |
| kardio_1 | 75 | есть | 0 / 0 | — | 17 |
| kardio_2 | 75 | есть | 0 / 0 | — | 17 |
| kardio_3 | 77 | есть | 0 / 0 | — | 19 |
| kardio_4 | 63 | есть | 0 / 0 | — | 19 |
| kardio_5 | 61 | есть | 0 / 0 | — | 19 |
| kardio_6 | 61 | есть | 0 / 0 | — | 19 |
| kardio_7 | 65 | есть | 0 / 0 | — | 19 |
| kardio_8 | 66 | есть | 0 / 0 | — | 20 |
| kardio_9 | 67 | есть | 0 / 0 | — | 21 |
| koleno2_1 | 69 | есть | 0 / 0 | — | 2 |
| koleno2_2 | 69 | есть | 0 / 0 | — | 2 |
| koleno2_3 | 83 | есть | 0 / 0 | — | 10 |
| koleno_1 | 80 | есть | 15 / 15 | — | 2 |
| koleno_2 | 58 | есть | 0 / 0 | — | 0 |
| kolono_1 | 7 | есть | 0 / 0 | — | 0 |
| kolono_2 | 7 | есть | 0 / 0 | — | 0 |
| kolposkop_1 | 2 | есть | 0 / 0 | — | 0 |
| kons_derm_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_detnevrol_1 | 9 | есть | 0 / 0 | — | 0 |
| kons_endo_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_endo_2 | 8 | есть | 0 / 0 | — | 0 |
| kons_expert_1 | 7 | есть | 0 / 0 | — | 0 |
| kons_fizio_1 | 5 | есть | 0 / 0 | — | 0 |
| kons_gast_1 | 9 | есть | 0 / 0 | — | 0 |
| kons_gastgep_1 | 9 | есть | 0 / 0 | — | 0 |
| kons_gastgep_12 | 9 | есть | 0 / 0 | — | 0 |
| kons_gemat_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_ginek_1 | 10 | есть | 0 / 0 | — | 0 |
| kons_ginek_2 | 10 | есть | 0 / 0 | — | 0 |
| kons_hirend_1 | 7 | есть | 0 / 0 | — | 0 |
| kons_hirsosud_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_imm_1 | 8 | есть | 0 / 0 | — | 0 |
| kons_kard_1 | 5 | есть | 0 / 0 | — | 0 |
| kons_kard_2 | 7 | есть | 0 / 0 | — | 0 |
| kons_kard_3 | 8 | есть | 0 / 0 | — | 0 |
| kons_kolo_1 | 11 | есть | 0 / 0 | — | 0 |
| kons_nevr_1 | 8 | есть | 0 / 0 | — | 0 |
| kons_oftal_1 | 4 | есть | 0 / 0 | — | 0 |
| kons_onkmam_1 | 9 | есть | 0 / 0 | — | 0 |
| kons_otor_1 | 9 | есть | 0 / 0 | — | 0 |
| kons_ozon_1 | 8 | есть | 0 / 0 | — | 0 |
| kons_pedi_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_psi_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_psihia_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_psiter_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_pulm_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_reflex_1 | 5 | есть | 0 / 0 | — | 0 |
| kons_revmat_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_terap_1 | 7 | есть | 0 / 0 | — | 0 |
| kons_terapevt_1 | 7 | есть | 0 / 0 | — | 0 |
| kons_terinf_1 | 6 | есть | 0 / 0 | — | 0 |
| kons_tr_ort_1 | 7 | есть | 0 / 0 | — | 0 |
| kons_yrol_1 | 9 | есть | 0 / 0 | — | 0 |
| lab_otdel_1 | 30 | есть | 0 / 0 | — | 0 |
| lokot_1 | 24 | есть | 0 / 0 | — | 0 |
| lokot_2 | 24 | есть | 0 / 0 | — | 0 |
| lych_1 | 24 | есть | 0 / 0 | — | 0 |
| mazctchis_1 | 28 | есть | 0 / 0 | — | 0 |
| mazctchis_2 | 44 | есть | 0 / 0 | eputelii | 1 |
| mochepol_1 | 150 | нет | 0 / 0 | — | 7 |
| mochepol_2 | 150 | нет | 0 / 0 | — | 7 |
| mochev_1 | 11 | есть | 0 / 0 | — | 0 |
| mochev_2 | 11 | есть | 0 / 0 | — | 0 |
| moloch_1 | 19 | есть | 7640 / 100 | — | 0 |
| moloch_2 | 11 | есть | 0 / 0 | — | 1 |
| moshonka_1 | 32 | есть | 0 / 0 | — | 0 |
| moshonka_2 | 32 | есть | 0 / 0 | — | 0 |
| neroson_1 | 18 | есть | 0 / 0 | — | 0 |
| neroson_2 | 18 | есть | 0 / 0 | — | 0 |
| operdv_1 | 3 | есть | 0 / 0 | — | 0 |
| osm_ginek_1 | 20 | есть | 0 / 0 | — | 0 |
| osm_hir_1 | 6 | есть | 0 / 0 | — | 0 |
| osm_nevrol_1 | 6 | есть | 0 / 0 | — | 0 |
| osm_okul_1 | 6 | есть | 0 / 0 | — | 0 |
| osm_otorin_1 | 6 | есть | 0 / 0 | — | 0 |
| osm_terap_1 | 9 | есть | 0 / 0 | — | 0 |
| osm_urol_1 | 7 | есть | 0 / 0 | — | 0 |
| passport_1 | 0 | нет | 0 / 0 | — | 1 |
| pechen_1 | 20 | есть | 0 / 0 | — | 0 |
| pechen_2 | 20 | есть | 0 / 0 | — | 0 |
| penil_1 | 35 | есть | 0 / 0 | faza_t | 0 |
| penil_2 | 31 | есть | 0 / 0 | faza_t | 0 |
| perinatol_1 | 13 | есть | 0 / 0 | — | 0 |
| perinatol_2 | 13 | есть | 0 / 0 | — | 0 |
| perinatol_3 | 13 | есть | 0 / 0 | — | 0 |
| plecho_1 | 11 | есть | 0 / 0 | — | 0 |
| plecho_2 | 22 | есть | 0 / 0 | — | 0 |
| plecho_3 | 22 | есть | 0 / 0 | — | 0 |
| pochki_1 | 37 | есть | 2804 / 100 | r_chash_size | 2 |
| pochki_2 | 119 | есть | 0 / 0 | l_dugov_rezis_how | 0 |
| pochki_3 | 121 | есть | 0 / 0 | l_dugov_rezis_how | 2 |
| pos_pojas_1 | 81 | есть | 1 / 1 | — | 1 |
| poz_sheja_1 | 89 | есть | 1 / 1 | — | 2 |
| punc_chitgel_1 | 36 | есть | 0 / 0 | — | 7 |
| punc_gidrocele_1 | 32 | есть | 0 / 0 | — | 0 |
| punc_lechpoch_1 | 121 | есть | 0 / 0 | l_dugov_rezis_how | 2 |
| punc_molgrud_1 | 11 | есть | 0 / 0 | — | 1 |
| punc_peceni_1 | 22 | есть | 0 / 0 | — | 0 |
| punc_podgel_1 | 10 | есть | 0 / 0 | — | 0 |
| punc_predstat_1 | 57 | есть | 0 / 0 | — | 4 |
| rentgen_1 | 7 | есть | 0 / 0 | — | 0 |
| schit_1 | 14 | есть | 0 / 0 | — | 3 |
| schit_2 | 14 | есть | 0 / 0 | — | 3 |
| schit_3 | 30 | есть | 0 / 0 | — | 7 |
| schit_4 | 36 | есть | 0 / 0 | — | 7 |
| seans_family_1 | 5 | есть | 0 / 0 | — | 0 |
| seans_ind_1 | 5 | есть | 0 / 0 | — | 0 |
| second_1 | 120 | нет | 0 / 0 | — | 1 |
| second_2 | 125 | нет | 0 / 0 | — | 2 |
| second_3 | 125 | нет | 0 / 0 | — | 2 |
| second_4 | 149 | нет | 0 / 0 | third_placenta_how | 3 |
| shit_1 | 32 | есть | 8012 / 100 | — | 5 |
| skrin_m_1 | 119 | есть | 0 / 0 | — | 10 |
| skrin_m_2 | 193 | есть | 0 / 0 | — | 12 |
| skrin_m_3 | 196 | есть | 0 / 0 | — | 12 |
| skrin_m_4 | 199 | есть | 0 / 0 | — | 12 |
| skrin_w_1 | 86 | есть | 0 / 0 | — | 8 |
| skrin_w_2 | 160 | есть | 0 / 0 | — | 10 |
| skrin_w_3 | 201 | есть | 0 / 0 | — | 10 |
| skrin_w_4 | 241 | есть | 0 / 0 | — | 16 |
| skrin_w_5 | 245 | есть | 0 / 0 | — | 16 |
| skrin_w_6 | 249 | есть | 0 / 0 | — | 16 |
| smad_1 | 49 | есть | 0 / 0 | — | 0 |
| stress_eho_1 | 3 | есть | 0 / 0 | — | 0 |
| taz2_1 | 17 | есть | 0 / 0 | — | 0 |
| taz2_2 | 17 | есть | 0 / 0 | — | 0 |
| tazobed_1 | 46 | есть | 0 / 0 | — | 0 |
| tazobed_2 | 46 | есть | 0 / 0 | — | 0 |
| third_1 | 120 | нет | 0 / 0 | — | 1 |
| third_2 | 125 | нет | 0 / 0 | — | 2 |
| third_3 | 125 | нет | 0 / 0 | — | 2 |
| third_4 | 125 | нет | 0 / 0 | — | 2 |
| third_5 | 149 | нет | 0 / 0 | third_placenta_how | 3 |
| trimestr_1 | 26 | есть | 1 / 1 | — | 0 |
| universal_1 | 0 | есть | 4592 / 100 | — | 0 |

## Каждый исходный экран/шаблон

Полный индекс, включая общие фрагменты и архивные формы. Привязка к сценарию обозначает область проверки, а не успешный динамический проход каждого файла.

| Файл | Сценарий | Статус области | Контекст |
| --- | --- | --- | --- |
| jsp/add_pacient.jsp | P03 | Есть аналог | Рабочий УЗИ |
| jsp/after_save_protocol.jsp | S10 | Есть аналог | Рабочий УЗИ |
| jsp/book/add_book.jsp | D07 | Нет | Рабочий УЗИ |
| jsp/book/edit_book.jsp | D07 | Нет | Рабочий УЗИ |
| jsp/book/view_book.jsp | D07 | Нет | Рабочий УЗИ |
| jsp/choice_research.jsp | S01 | Есть аналог | Рабочий УЗИ |
| jsp/edit_pacient.jsp | P04 | Есть аналог | Рабочий УЗИ |
| jsp/error.jsp | Z01 | Служебное | Общие части экранов |
| jsp/error_new.jsp | Z01 | Служебное | Общие части экранов |
| jsp/find_pacient.jsp | P02 | Есть аналог | Рабочий УЗИ |
| jsp/fio_choice.jsp | P02 | Есть аналог | Рабочий УЗИ |
| jsp/footer.jsp | Z01 | Служебное | Общие части экранов |
| jsp/header.jsp | Z01 | Служебное | Общие части экранов |
| jsp/identify.jsp | A01 | Есть аналог | Рабочий УЗИ |
| jsp/line.jsp | X03 | Нет | Не подключено в меню; зависимости неполны |
| jsp/menu.jsp | P01 | Есть аналог | Рабочий УЗИ |
| jsp/not_saved_research.jsp | S11 | Частично | Рабочий УЗИ |
| jsp/prepare_protocol.jsp | S01 | Есть аналог | Рабочий УЗИ |
| jsp/proba.jsp | D11 | Есть аналог | Рабочий УЗИ |
| jsp/protocol.jsp | Z02 | Требует проверки | Технические артефакты архива |
| jsp/protocol_form/akush_spec_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/aller_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/berem14_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/berem_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/berem_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/berem_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/berem_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/beremen14_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/beremen1_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/beremen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/biopsia_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/biopsia_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/brooho_1.jsp | S04 | Частично | Рабочий УЗИ |
| jsp/protocol_form/brooho_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/brooho_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/citpap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_ekstra_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_golovi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_magven_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_nij_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_venniz_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/dupleks_verhart_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/duplex_abaort_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/duplexpart_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/echo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/echo_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/egds_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/egds_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/egds_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/eho_kg_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/eho_kg_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ekgram_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/farma_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/farma_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/fgds_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/first_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/first_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/first_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/first_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/footer.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_form/ginekol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ginekol_11.jsp | S04 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ginekol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ginekol_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ginekol_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/ginekol_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/golen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/golen_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/header.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_form/holter_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/jeludok_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/jeludok_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_6.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_7.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_8.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kardio_9.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/koleno2_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/koleno2_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/koleno2_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/koleno_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/koleno_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kolono_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kolono_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kolposkop_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_derm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_detnevrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_endo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_endo_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_expert_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_fizio_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_gast_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_gastgep_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_gastgep_12.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_gemat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_ginek_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_ginek_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_hirend_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_hirsosud_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_imm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_kard_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_kard_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_kard_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_kolo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_nevr_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_oftal_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_onkmam_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_otor_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_ozon_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_pedi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_psi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_psihia_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_psiter_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_pulm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_reflex_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_revmat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_terap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_terapevt_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_terinf_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_tr_ort_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/kons_yrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/lab_otdel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/lokot_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/lokot_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/lych_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mazctchis_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mazctchis_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mochepol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mochepol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mochev_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/mochev_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/moloch_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/moloch_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/moshonka_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/moshonka_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/neroson_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/neroson_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/operdv_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_ginek_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_hir_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_nevrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_okul_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_otorin_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_terap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/osm_urol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/passport_1.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_form/pechen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/pechen_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/penil_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/penil_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/perinatol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/perinatol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/perinatol_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/plecho_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/plecho_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/plecho_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/pochki_1.jsp | S04 | Частично | Рабочий УЗИ |
| jsp/protocol_form/pochki_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/pochki_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/pos_pojas_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/poz_sheja_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_chitgel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_gidrocele_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_lechpoch_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_molgrud_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_peceni_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_podgel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/punc_predstat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/rentgen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/schit_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/schit_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/schit_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/schit_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/seans_family_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/seans_ind_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/second_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/second_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/second_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/second_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/shit_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_m_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_m_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_m_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_m_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/skrin_w_6.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/smad_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/stress_eho_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/taz2_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/taz2_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/tazobed_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/tazobed_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/third_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/third_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/third_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/third_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/third_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/trimestr_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_form/universal_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/akush_spec_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/aller_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/berem14_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/berem_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/berem_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/berem_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/berem_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/beremen14_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/beremen1_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/beremen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/biopsia_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/biopsia_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/brooho_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/brooho_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/brooho_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/citpap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_ekstra_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_golovi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_magven_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_nij_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_venniz_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/dupleks_verhart_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/duplex_abaort_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/duplexpart_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/echo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/echo_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/egds_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/egds_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/egds_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/eho_kg_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/eho_kg_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/ekgram_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/farma_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/farma_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/fgds_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/first_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/first_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/first_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/first_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/footer.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_view/footer19092010.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_view/ginekol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/ginekol_11.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/ginekol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/ginekol_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/ginekol_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/golen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/golen_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/header Николаеву.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_view/header.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_view/header19092010.jsp | Z01 | Служебное | Общие части экранов |
| jsp/protocol_view/holter_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/jeludok_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/jeludok_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_6.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_7.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_8.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kardio_9.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/koleno2_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/koleno2_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/koleno2_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/koleno_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/koleno_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kolono_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kolono_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kolposkop_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_derm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_detnevrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_endo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_endo_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_expert_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_fizio_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_gast_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_gastgep_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_gastgep_12.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_gemat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_ginek_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_ginek_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_hirend_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_hirsosud_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_imm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_kard_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_kard_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_kard_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_kolo_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_nevr_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_oftal_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_onkmam_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_otor_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_ozon_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_pedi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_psi_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_psihia_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_psiter_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_pulm_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_reflex_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_revmat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_terap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_terapevt_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_terinf_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_tr_ort_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/kons_yrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/lab_otdel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/lokot_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/lokot_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/lych_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mazctchis_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mazctchis_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mochepol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mochepol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mochev_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/mochev_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/moloch_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/moloch_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/moshonka_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/moshonka_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/neroson_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/neroson_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/operdv_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_ginek_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_hir_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_nevrol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_okul_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_otorin_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_terap_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/osm_urol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pechen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pechen_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/penil_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/penil_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/perinatol_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/perinatol_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/perinatol_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/plecho_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/plecho_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/plecho_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pochki_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pochki_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pochki_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/pos_pojas_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/poz_sheja_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/protocol.jsp | F02 | Есть аналог | Рабочий УЗИ |
| jsp/protocol_view/protocol19092010.jsp | F02 | Есть аналог | Рабочий УЗИ |
| jsp/protocol_view/punc_chitgel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_gidrocele_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_lechpoch_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_molgrud_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_peceni_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_podgel_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/punc_predstat_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/rentgen_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/schit_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/schit_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/schit_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/schit_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/seans_family_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/seans_ind_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/second_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/second_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/second_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/second_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/shit_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_m_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_m_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_m_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_m_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/skrin_w_6.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/smad_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/stress_eho_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/taz2_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/taz2_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/tazobed_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/tazobed_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/third_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/third_2.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/third_3.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/third_4.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/third_5.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/trimestr_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/protocol_view/universal_1.jsp | S15 | Частично | Рабочий УЗИ |
| jsp/search/pacient_find.jsp | P02 | Есть аналог | Рабочий УЗИ |
| jsp/search/results_fio_search.jsp | P02 | Есть аналог | Рабочий УЗИ |
| jsp/search/results_protocol_search.jsp | S13 | Есть аналог | Рабочий УЗИ |
| jsp/search/search_main.jsp | P02 | Есть аналог | Рабочий УЗИ |
| jsp/select_research.jsp | S01 | Есть аналог | Рабочий УЗИ |
| jsp/view_all_pacient.jsp | P01 | Есть аналог | Рабочий УЗИ |
| jsp/view_all_protocol.jsp | S13 | Есть аналог | Рабочий УЗИ |
| jsp/view_proba.jsp | Z02 | Требует проверки | Технические артефакты архива |
| jsp/view_protocol.jsp | F01 | Есть аналог | Рабочий УЗИ |
| php/html/administration/main_administration.html | A03 | Частично | Рабочий УЗИ |
| php/html/administration/show_add_cabinet.html | X01 | Нет | Административные экраны; пустые справочники |
| php/html/administration/show_add_edit_group.html | A03 | Частично | Рабочий УЗИ |
| php/html/administration/show_add_edit_user.html | A04 | Есть аналог | Рабочий УЗИ |
| php/html/administration/show_cabinets.html | X01 | Нет | Административные экраны; пустые справочники |
| php/html/administration/show_groups_users.html | A03 | Частично | Рабочий УЗИ |
| php/html/administration/show_lpu.html | X01 | Нет | Административные экраны; пустые справочники |
| php/html/administration/show_permits.html | A03 | Частично | Рабочий УЗИ |
| php/html/administration/show_users.html | A04 | Есть аналог | Рабочий УЗИ |
| php/html/administration/window_opener_reload.html | Z01 | Служебное | Общие части экранов |
| php/html/registration/pacient_registration.html | X02 | Нет | Не подключено в меню; зависимости неполны |
| php/html/research/edit_book.html | D07 | Нет | Рабочий УЗИ |
| php/html/research/edit_main_book_record.html | D07 | Нет | Рабочий УЗИ |
| php/html/research/prepare_create_research.html | D08 | Нет | Рабочий УЗИ |
| php/html/research/show_main_research.html | D08 | Нет | Рабочий УЗИ |
| php/html/research_user/edit_book_user.html | D05 | Нет | Рабочий УЗИ |
| php/html/research_user/edit_main_book_record.html | D04 | Нет | Рабочий УЗИ |
| php/html/research_user/show_main_research.html | D01 | Есть аналог | Рабочий УЗИ |
| php/html/statistic/main_statistic.html | R01 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/html/statistic/prepare_napr_lpu.html | R04 | Нет | Модуль в архиве; исходные справочники пусты |
| php/html/statistic/prepare_research_decision.html | R03 | Нет | Модуль в архиве; ссылка в меню отсутствует |
| php/html/statistic/prepare_vyrabotka.html | R02 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/html/statistic/view_decision.html | R03 | Нет | Модуль в архиве; ссылка в меню отсутствует |
| php/html/statistic/view_napr_lpu.html | R04 | Нет | Модуль в архиве; исходные справочники пусты |
| php/html/statistic/view_research.html | R01 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/html/statistic/view_vyrabotka.html | R02 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/html/tools/select_research.html | S01 | Есть аналог | Рабочий УЗИ |
| php/html/tools/show_add_ambulator.html | X02 | Нет | Не подключено в меню; зависимости неполны |
| php/html/tools/show_add_edit_pacient.html | P06 | Нет | Общая медицинская система; использование не подтверждено |
| php/html/tools/show_add_prihod.html | X03 | Нет | Не подключено в меню; зависимости неполны |
| php/html/tools/show_pacient_list.html | P01 | Есть аналог | Рабочий УЗИ |
| php/modules/statistic/html/footer.html | Z01 | Служебное | Общие части экранов |
| php/modules/statistic/html/header.html | Z01 | Служебное | Общие части экранов |
| php/modules/statistic/html/main_statistic.html | R01 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/prepare_napr_lpu.html | R04 | Нет | Модуль в архиве; исходные справочники пусты |
| php/modules/statistic/html/prepare_reg_records.html | R05 | Нет | Архивный общий модуль; не подтверждён |
| php/modules/statistic/html/prepare_research_decision.html | R03 | Нет | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/prepare_vyrabotka.html | R02 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/show_prepare_statistic.html | R01 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/show_zett_otchet.html | R05 | Нет | Архивный общий модуль; не подтверждён |
| php/modules/statistic/html/view_decision.html | R03 | Нет | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/view_napr_lpu.html | R04 | Нет | Модуль в архиве; исходные справочники пусты |
| php/modules/statistic/html/view_reg_records.html | R05 | Нет | Архивный общий модуль; не подтверждён |
| php/modules/statistic/html/view_research.html | R01 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| php/modules/statistic/html/view_vyrabotka.html | R02 | Частично | Модуль в архиве; ссылка в меню отсутствует |
| reference.html | D11 | Есть аналог | Рабочий УЗИ |
| reference.jsp | D11 | Есть аналог | Рабочий УЗИ |

## Новые маршруты и диалоги

Открытие основных маршрутов проверено на вымышленных данных. Ниже — также полный список объявленных диалогов; не все их состояния прошли динамическую приёмку.

Маршруты: `/`, `/patients/:id`, `/studies`, `/studies/new/:patientId`, `/studies/:id`, `/database`, `/account`, `/templates`, `/statistics`, `/users`, `/orphans`, `/bundles/:id`.

| Файл:строка | Диалог | Состояние |
| --- | --- | --- |
| src/components/ArchiveMaintenance.vue:13 | Скрытые карточки | hiddenOpen |
| src/components/ArchiveMaintenance.vue:13 | Журнал действий | auditOpen |
| src/components/Attachments.vue:18 | Убрать вложение из исследования? | Boolean(removing) |
| src/components/BackupManager.vue:14 | Восстановить базу? | restoreOpen |
| src/components/PatientForm.vue:12 | patient?'Редактировать карточку':'Новый пациент' | open |
| src/components/TemplateLibrary.vue:47 | Новая заготовка | createOpen |
| src/components/TemplateLibrary.vue:48 | Изменить заготовку | Boolean(editing) |
| src/components/TemplateLibrary.vue:49 | Удалить заготовку? | Boolean(deleting) |
| src/views/PatientDetail.vue:24 | Объединить исследования для печати | bundleOpen |
| src/views/PatientDetail.vue:24 | Скрыть карточку из общего списка? | hideOpen |
| src/views/StudyEditor.vue:94 | Справочник шаблонов | showLibrary |
| src/views/StudyEditor.vue:95 | Сменить вид исследования? | confirmTemplate |
| src/views/StudyEditor.vue:96 | Остались несохранённые изменения | confirmLeave |
| src/views/Users.vue:17 | form.id?'Изменить учётную запись':'Новый пользователь' | show |
| src/views/Users.vue:17 | Добавить врача | doctorShow |

## Каждая PHP-ветка действия

Ветка диспетчера подтверждает наличие маршрута в коде; не гарантирует наличие всех зависимостей или фактическое использование.

| Диспетчер:строка | Действие | Сценарий | Статус области |
| --- | --- | --- | --- |
| php/index.php:30 | main_menu | P01 | Есть аналог |
| php/index.php:35 | main_schedule | X02 | Нет |
| php/index.php:40 | show_add_schedule | X02 | Нет |
| php/index.php:47 | add_schedule | X02 | Нет |
| php/index.php:57 | delete_schedule | X02 | Нет |
| php/index.php:63 | edit_schedule | X02 | Нет |
| php/index.php:69 | save_edit_schedule | X02 | Нет |
| php/index.php:78 | main_registratura | X02 | Нет |
| php/index.php:89 | prepare_registration | X02 | Нет |
| php/index.php:104 | get_price | X03 | Нет |
| php/index.php:110 | select_research | S01 | Есть аналог |
| php/index.php:129 | search_pacient | P02 | Есть аналог |
| php/index.php:148 | save_registration | X02 | Нет |
| php/index.php:167 | do_add_prihod_rashod | X03 | Нет |
| php/index.php:173 | prepare_replace | X02 | Нет |
| php/index.php:180 | delete_record | X02 | Нет |
| php/index.php:187 | show_pacient_list | P01 | Есть аналог |
| php/index.php:203 | show_add_pacient | P03 | Есть аналог |
| php/index.php:221 | do_add_pacient | P03 | Есть аналог |
| php/index.php:238 | show_add_ambulance | X02 | Нет |
| php/index.php:258 | show_edit_pacient | P04 | Есть аналог |
| php/index.php:277 | save_edit_pacient | P04 | Есть аналог |
| php/index.php:354 | add_pacient | P03 | Есть аналог |
| php/index.php:433 | prepare_document | X03 | Нет |
| php/index.php:440 | choise_document | X03 | Нет |
| php/index.php:453 | show_soglasen_document | X03 | Нет |
| php/index.php:463 | show_otkaz_document | X03 | Нет |
| php/index.php:473 | show_operaciya_document | X03 | Нет |
| php/index.php:483 | prepare_pay | X03 | Нет |
| php/index.php:490 | set_payed | X03 | Нет |
| php/index.php:521 | print_karta | P06 | Нет |
| php/index.php:526 | show_print_karta | P06 | Нет |
| php/index.php:531 | main_administration | A03 | Частично |
| php/index.php:537 | edit_cabinets | X01 | Нет |
| php/index.php:543 | show_add_cabinets | X01 | Нет |
| php/index.php:549 | do_add_cabinet | X01 | Нет |
| php/index.php:554 | delete_cabinet | X01 | Нет |
| php/index.php:561 | edit_groups | A03 | Частично |
| php/index.php:567 | show_add_groups | A03 | Частично |
| php/index.php:573 | do_add_group | A03 | Частично |
| php/index.php:578 | delete_group | A03 | Частично |
| php/index.php:585 | show_edit_group_name | A03 | Частично |
| php/index.php:592 | save_edit_group_name | A03 | Частично |
| php/index.php:598 | edit_users | A04 | Есть аналог |
| php/index.php:604 | show_add_users | A04 | Есть аналог |
| php/index.php:610 | do_add_user | A04 | Есть аналог |
| php/index.php:617 | delete_user | A04 | Есть аналог |
| php/index.php:624 | show_edit_user_name | A04 | Есть аналог |
| php/index.php:631 | save_edit_user_name | A04 | Есть аналог |
| php/index.php:639 | edit_permits | A03 | Частично |
| php/index.php:645 | save_edit_permits | A03 | Частично |
| php/index.php:659 | show_lpu | X01 | Нет |
| php/index.php:667 | add_lpu | X01 | Нет |
| php/index.php:675 | save_edit_lpu | X01 | Нет |
| php/index.php:684 | save_edit_lpu_doctor | X01 | Нет |
| php/index.php:694 | add_lpu_doctor | X01 | Нет |
| php/index.php:703 | delete_lpu_doctor | X01 | Нет |
| php/index.php:711 | delete_lpu | X01 | Нет |
| php/index.php:719 | prepare_po_priemam | R05 | Нет |
| php/index.php:725 | preveiw_po_priemam | R05 | Нет |
| php/index.php:733 | prepare_po_napr | R05 | Нет |
| php/index.php:739 | preveiw_po_napr | R05 | Нет |
| php/index.php:745 | prepare_po_pacient | R05 | Нет |
| php/index.php:754 | preveiw_po_pacient | R05 | Нет |
| php/index.php:761 | prepare_po_doctor | R05 | Нет |
| php/index.php:767 | preveiw_po_doctor | R05 | Нет |
| php/index.php:775 | prepare_po_podrazdel | R05 | Нет |
| php/index.php:781 | preveiw_po_podrazdel | R05 | Нет |
| php/index.php:787 | prepare_po_podrazdel_payed | R05 | Нет |
| php/index.php:793 | preveiw_po_podrazdel_payed | R05 | Нет |
| php/index.php:799 | prepare_line | X03 | Нет |
| php/index.php:806 | print_line | X03 | Нет |
| php/index.php:811 | update_book_users | D10 | Нет |
| php/index.php:819 | prepare_edit_decision | D01 | Есть аналог |
| php/index.php:827 | show_add_decision | D02 | Есть аналог |
| php/index.php:835 | do_add_decision | D02 | Есть аналог |
| php/index.php:844 | edit_research_decision | D03 | Есть аналог |
| php/index.php:853 | do_save_edit_decision | D03 | Есть аналог |
| php/index.php:863 | delete_research_decision | D03 | Есть аналог |
| php/index.php:873 | set_position | D06 | Нет |
| php/index.php:885 | prepare_karta_pacient | X04 | Нет |
| php/index.php:891 | karta_search_pacient | X04 | Нет |
| php/index.php:898 | karta_user_card | X04 | Нет |
| php/index.php:905 | karta_first_request | X04 | Нет |
| php/index.php:911 | karta_zakl_list | X04 | Нет |
| php/index.php:916 | karta_priviv_list | X04 | Нет |
| php/index.php:922 | karta_control_posesch | X04 | Нет |
| php/index.php:931 | do_add_control | X04 | Нет |
| php/index.php:940 | do_save_edit_control | X04 | Нет |
| php/index.php:950 | delete_control_pos | X04 | Нет |
| php/index.php:957 | karta_stac_list | X04 | Нет |
| php/index.php:963 | karta_invaz_list | X04 | Нет |
| php/index.php:969 | karta_disp_list | X04 | Нет |
| php/index.php:975 | karta_rentgen_list | X04 | Нет |
| php/index.php:981 | karta_issled_list | X04 | Нет |
| php/index.php:988 | main_dogovor | X03 | Нет |
| php/index.php:993 | prepare_search_pacient_dogovor | X03 | Нет |
| php/index.php:998 | search_pacient_dogovor | X03 | Нет |
| php/index.php:1005 | dogovor_pacient_info | X03 | Нет |
| php/index.php:1012 | show_create_contract | X03 | Нет |
| php/index.php:1020 | main_research | D08 | Нет |
| php/index.php:1028 | prepare_create_research | D08 | Нет |
| php/index.php:1036 | create_research | D08 | Нет |
| php/index.php:1050 | prepare_edit_book | D07 | Нет |
| php/index.php:1062 | prepare_copy_replace_data | D05 | Нет |
| php/index.php:1078 | insert_records_book | D05 | Нет |
| php/index.php:1085 | prepare_print_check | X03 | Нет |
| php/index.php:1093 | prepare_delete_pacient | P05 | Изменено |
| php/index.php:1100 | do_delete_pacient | P05 | Изменено |
| php/index.php:1110 | show_protocols_reg_pacient | X02 | Нет |
| php/index.php:1120 | edit_main_book_record | D07 | Нет |
| php/index.php:1128 | save_edit_book_record | D07 | Нет |
| php/index.php:1142 | replace_temp_price | X03 | Нет |
| php/index.php:1145 | show_koresh_document_new | X03 | Нет |
| php/index.php:1151 | prinyat_numeraciu | X03 | Нет |
| php/index.php:1160 | main_research_user | D01 | Есть аналог |
| php/index.php:1168 | prepare_edit_book_user | D04 | Нет |
| php/index.php:1180 | prepare_copy_replace_data_user | D05 | Нет |
| php/index.php:1196 | insert_records_book_user | D05 | Нет |
| php/modules/statistic/index.php:16 | main_menu | P01 | Есть аналог |
| php/modules/statistic/index.php:21 | prepare_otchet_vyrab | R02 | Частично |
| php/modules/statistic/index.php:27 | view_vyrabotka | R02 | Частично |
| php/modules/statistic/index.php:35 | prepare_research | R01 | Частично |
| php/modules/statistic/index.php:42 | view_research | R01 | Частично |
| php/modules/statistic/index.php:52 | prepare_decision | R03 | Нет |
| php/modules/statistic/index.php:59 | view_decision | R03 | Нет |
| php/modules/statistic/index.php:68 | prepare_z_otchet | R05 | Нет |
| php/modules/statistic/index.php:74 | show_zett_otchet | R05 | Нет |
| php/modules/statistic/index.php:83 | prepare_reg_records | R05 | Нет |
| php/modules/statistic/index.php:89 | view_reg_records | R05 | Нет |
| php/modules/statistic/index.php:96 | prepare_napr_lpu | R04 | Нет |
| php/modules/statistic/index.php:102 | view_napr_lpu | R04 | Нет |

## Каждый класс Java-команды

| Класс | Сценарий | Статус области |
| --- | --- | --- |
| AddBookCommand | D07 | Нет |
| AddPacientCommand | P03 | Есть аналог |
| Command | Z02 | Требует проверки |
| DeleteFusionProtocolCommand | F04 | Нет |
| DeleteImageCommand | F05 | Есть аналог |
| DeletePacientCommand | P05 | Изменено |
| DeleteProtocolCommand | S12 | Нет |
| DoIdentifyCommand | A01 | Есть аналог |
| EditBookCommand | D07 | Нет |
| FusionProtocolCommand | F02 | Есть аналог |
| NotSavedCommand | S11 | Частично |
| NullCommand | Z02 | Требует проверки |
| PrepareAddBookCommand | D07 | Нет |
| PrepareAddPacientCommand | P03 | Есть аналог |
| PrepareChoiceResearchCommand | S01 | Есть аналог |
| PrepareDoctorCommand | A02 | Изменено |
| PrepareEditBookCommand | D07 | Нет |
| PrepareEditPacientCommand | P04 | Есть аналог |
| PrepareEditProtocolCommand | S14 | Есть аналог |
| PrepareIdentifyCommand | A01 | Есть аналог |
| PrepareNotSavedCommand | S11 | Частично |
| PrepareResearchCommand | S01 | Есть аналог |
| PrepareSearchPacientCommand | P02 | Есть аналог |
| prepareViewFusionProtocolCommand | F03 | Нет |
| PrepareViewProtocolCommand | F01 | Есть аналог |
| SaveAndPrintProtocolCommand | S10 | Есть аналог |
| SaveEditPacientCommand | P04 | Есть аналог |
| SaveProtocolCommand | S10 | Есть аналог |
| SearchCommand | P02 | Есть аналог |
| SelectResearchCommand | S01 | Есть аналог |
| ViewAllPacientCommand | P01 | Есть аналог |
| ViewAllProtocolCommand | S13 | Есть аналог |
| ViewBookCommand | D07 | Нет |

## Доказательства и актуальность проверок

- `current-tests.json`: текущие запуски Vitest и Rust; отдельные тесты не означают весь функциональный паритет.
- `current-ui-check.json`: открытие экранов с имитацией IPC; `current-template-cycle.json`: создание/вставка/правка/удаление/восстановление заготовки в том же режиме.
- `coverage.json`: полнота классификации индексов и проверка неизменности исходников и исходной базы.
- `source-files.json`: перечень и SHA-256 файлов; `screens.json`, `actions.json`, `java-commands.json`, `forms.json`, `facts.json`, `scenarios.json`: полные машиночитаемые индексы.
- `../template-parity.json`: историческая выборка печатного текста. Она не проверяет редактор.
- `../forms-native-check.json` и часть прежних отчётов содержат старый признак `finalizationBlockedUntilRecalculation=true`. После согласованного снятия блокировки он устарел и не принимается как актуальная проверка поведения.
- `../native-acceptance.json`: исторические испытания настоящего exe на синтетических данных; не свежая приёмка всех последующих изменений.

Полное соответствие можно подтвердить только после закрытия пропусков и прохождения приёмочных сценариев. Текущий итог — **полного паритета нет**, список известных различий зафиксирован.
