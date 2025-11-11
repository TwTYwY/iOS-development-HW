# HW2

### • Question: What issues prevent us from using storyboards in real projects?
Плохая производительность, тяжело будет использовать эти же объекты в других проектах, трудно создавать сложные интерфейсы, сложность отладки

### • Question: What does the code on lines 25 and 29 do?
29 – добавляет title в view

### • Question: What is a safe area layout guide?
Это область, которая гарантированно доступна для размещения контента

### • Question: What is [weak self] on line 23 and why it is important?
Это capture list, который создает слабую ссылку на self. Если не создать слабую ссылку, создастся сильная ссылка и объект продолжит занимать память даже когда станет не нужен

### • Question: What does clipsToBounds mean?
Оно определяет, будет ли отображаться контент, выходящий за пределы view или нет

### • Question: What is the valueChanged type? What is Void and what is Double?
Это closure(замыкание). Void – пустой кортеж. Double – число с плавающей точкой
