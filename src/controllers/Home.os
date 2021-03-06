#Использовать telegrambot
#Использовать json

перем Бот;
перем Лог;

Функция Index() Экспорт
      
      Лог = НастройкиПриложения.Лог;
      Лог.Отладка("Путь запроса - %1", ЗапросHttp.Путь);
      
      Бот = НастройкиПриложения.Бот;
      
      Если НЕ ЗапросHttp.Путь = "/bot" + Бот.ТокенАвторизации Тогда
            Ответ = Новый РезультатДействияСодержимое();
            Ответ.КодСостояния = 200;
            Ответ.ТипСодержимого = "application/json;charset=UTF-8";
            Ответ.Содержимое = "{Hi, i`m telegram-bot}";
            Возврат Ответ;
      КонецЕсли;      
      
      Данные = ЗапросHttp.ПолучитьТелоКакПоток();
      ОбъектЗапрос = ОбщегоНазначения.ПолучитьОбъектТелаЗапроса(Данные);
      
      Лог.Отладка("Объект запроса - %1", ОбъектЗапрос);
      
      Если ОбъектЗапрос["message"] <> Неопределено Тогда
            
            Лог.Отладка("Текст сообщения - %1", ОбъектЗапрос["message"]["text"]);
            Результат = ОбработатьОбычноеСообщение(ОбъектЗапрос);      
            
      КонецЕсли; 
      
      Если ОбъектЗапрос["callback_query"] <> Неопределено Тогда
            
            Лог.Отладка("Текст коллбека - %1", ОбъектЗапрос["callback_query"]["message"]["text"]);
            Результат = ОбработатьКоллбекСообщение(ОбъектЗапрос);      
            
      КонецЕсли; 
      
      Ответ = Новый РезультатДействияСодержимое();
      Ответ.КодСостояния = 200;
      Ответ.ТипСодержимого = "application/json;charset=UTF-8";
      Ответ.Содержимое = Результат["ok"];
      
      Возврат Ответ;
      
КонецФункции

Функция ОбработатьОбычноеСообщение(ОбъектЗапрос)
      
      ТекстСообщения = ОбъектЗапрос["message"]["text"];
      ПолучательИД = ОбъектЗапрос["message"]["chat"]["id"];
      СообщениеИД = ОбъектЗапрос["message"]["message_id"];
      КонтактныеДанные = ОбъектЗапрос["message"]["contact"];
      ДанныеГеолокации = ОбъектЗапрос["message"]["location"];
      
      Если ТекстСообщения = "/start" ИЛИ ТекстСообщения = "/help" Тогда
            
            ТекстСообщения = "Привет, в низу меню для навигации";       
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ГлавноеМеню());
            Возврат Бот.Отправить(Сообщение); 
            
      КонецЕсли;      
      
      Если ТекстСообщения = "Главное меню" Тогда
            
            ТекстСообщения = "В низу меню для навигации";  
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ГлавноеМеню());
            Возврат Бот.Отправить(Сообщение); 
            
      КонецЕсли;         
      
      Если ТекстСообщения = "Клавиатуры" тогда
            
            ТекстСообщения = "Здесь показываются примеры расположения кнопок в клавиатуре";
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.МенюКлавиатуры());
            Возврат Бот.Отправить(Сообщение); 
            
      КонецЕсли;
      
      Если ТекстСообщения = "Три-одна-одна кнопки в ряд" тогда
            
            ТекстСообщения = "Это пример расположения кнопок Три-одна-одна в ряд";
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.МенюТриОдинОдин());
            Возврат Бот.Отправить(Сообщение); 
            
      конецЕсли; 
      
      Если ТекстСообщения = "Пять кнопок по вертикали" тогда
            
            ТекстСообщения = "Это пример расположения кнопок пяти кнопок по вертикали";
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.МенюПятьКнопокПоВертикали());
            Возврат Бот.Отправить(Сообщение); 
            
      конецЕсли;
      
      Если ТекстСообщения = "Кнопка" тогда
            
            ТекстСообщения = "Ты нажал на кнопку с надписью **Кнопка**";
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            Возврат Бот.Отправить(Сообщение); 
            
      конецЕсли;
      
      Если ТекстСообщения = "Инлайн" тогда
            
            // доставим нужную клавиатуру
            ТекстСообщения = "Демонстрация инлайн клавиатуры";  
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            Сообщение.Вставить("reply_markup", Команды.МенюИнлайн());
            Результат = Бот.Отправить(Сообщение);  
            
            ТекстСообщения = "Ниже этой надписи расположены инлайн кнопки";  
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ИнлайнКнопки());
            
            Возврат Бот.Отправить(Сообщение); 
            
      конецЕсли; 
      
      Если КонтактныеДанные <> Неопределено Тогда
            
            Телефон = КонтактныеДанные["phone_number"];
            Лог.Отладка("Телефон из контактных данных - %1", Телефон);
            
            Шаблон = "Ваши телефон определен как:
                     |%1";  
            ТекстСообщения = СтрШаблон(Шаблон, Телефон);         
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            Возврат Бот.Отправить(Сообщение);  
            
      КонецЕсли;
      
      Если ДанныеГеолокации <> Неопределено Тогда
            
            Широта = ДанныеГеолокации["latitude"];
            Долгота = ДанныеГеолокации["longitude"];
            
            Лог.Отладка("Широта - %1, Долгота -%2", Широта, Долгота);
            
            Шаблон = "Ваши координаты определены как:
                     |долгота %1 широта %2";  
            ТекстСообщения = СтрШаблон(Шаблон, Долгота, Широта);         
            Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
            Возврат Бот.Отправить(Сообщение);  
            
      КонецЕсли;      
      
      // если ничего из того что заложено в логике
      // возвращаем главное меню
      ТекстСообщения = "Давайте попробуем сначала, в низу меню для навигации";  
      Сообщение = ТелеграмАПИ.НовоеСообщение(ПолучательИД, ТекстСообщения);
      ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ГлавноеМеню());
      
      Возврат Бот.Отправить(Сообщение);
      
КонецФункции      

Функция ОбработатьКоллбекСообщение(ОбъектЗапрос)
      
      ТекстСообщения    = ОбъектЗапрос["callback_query"]["message"]["text"];
      ПолучательИД      = ОбъектЗапрос["callback_query"]["message"]["chat"]["id"];
      СообщениеИД       = ОбъектЗапрос["callback_query"]["message"]["message_id"];
      ДанныеКоллбека    = ОбъектЗапрос["callback_query"]["data"];
      
      Лог.Отладка("Данные коллбека - %1", ДанныеКоллбека);
      
      Сообщение = ТелеграмАПИ.НовыйКоллбекОтвет(ПолучательИД, СообщениеИД);
      
      Если СтрНачинаетсяС(ДанныеКоллбека, "Картинка=") Тогда
            
            СтрокаКартинкаИД = Сред(ДанныеКоллбека, 10);
            
            СтруктураОписанияКартинки = новый Структура("Описание, СсылкаНаИзображение");
            
            Если СтрокаКартинкаИД = "1" Тогда
                  СтруктураОписанияКартинки.Описание = "текст с описанием картинки №1 в демо";
                  СтруктураОписанияКартинки.СсылкаНаИзображение = "https://w-dog.ru/wallpapers/2/7/479565441611455.jpg";
            Иначе
                  СтруктураОписанияКартинки.Описание = "текст с описанием картинки №2 в демо";
                  СтруктураОписанияКартинки.СсылкаНаИзображение = "https://mining-cryptocurrency.ru/wp-content/uploads/Telegram.jpg";
            КонецЕсли;
            
            Шаблон = "**Наименование: картинка №%1**
                     |Описание: %2
                     |%3";
            ОписаниеКартинки = СтрШаблон(Шаблон, СтрокаКартинкаИД, СтруктураОписанияКартинки.Описание, СтруктураОписанияКартинки.СсылкаНаИзображение);
            
            ТелеграмАПИ.РедактироватьТекст(Сообщение, ОписаниеКартинки);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ИнлайнКартинка());    
            
      ИначеЕсли СтрНачинаетсяС(ДанныеКоллбека, "Оповещение") Тогда
            
            Уведомление = ТелеграмАПИ.НовыйКоллбекОтветНаЗапрос(ОбъектЗапрос["callback_query"]["id"], "Ты нажал кнопку оповещение");
            Бот.ОправитьОтветНаКоллбекЗапрос(Уведомление);
            
      ИначеЕсли ДанныеКоллбека = "" ИЛИ СтрНачинаетсяС(ДанныеКоллбека, "Инлайн") Тогда
            
            ТекстСообщения = "Ниже этой надписи расположены инлайн кнопки";  
            ТелеграмАПИ.РедактироватьТекст(Сообщение, ТекстСообщения);
            ТелеграмАПИ.УстановитьФорматСообщения(Сообщение, Бот.ФорматСообщений);
            ТелеграмАПИ.ДобавитьКлавиатуру(Сообщение, Команды.ИнлайнКнопки());
            
      КонецЕсли;
      
      Возврат Бот.ОтредактироватьСообщение(Сообщение);
      
КонецФункции 
