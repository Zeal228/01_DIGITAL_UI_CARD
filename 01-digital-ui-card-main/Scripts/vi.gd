extends Control 

# Добавьте что надо 
@export var hearts_container: HBoxContainer 
@export var Lv_label: Label 
@export var time_label: Label 
@export var Name_label: Label 
@export var Hp_label: Label 
@export var Hov_label: Label
@export var Bag_label: Label
@export var Wg_label: Label

# Укажите ссылку на текстуру сердца 
var heart_icon = preload('res://assets/heart.png') 

# Функция что будет запускаться при запуске сцены 
func _ready() -> void: 
	# Вывод информации на карточку 
	update_info() 
	# Подсчет и вывод сердец 
	update_hearts(int(Global.hp)) 
	# Время 
	update_time()
func update_info(): 
	# Расчет уровня (может быть любой) 
	if int(Global.hp) > 9 && int(Global.hov) > 5: 
		Lv_label.text = '5' 
	else: 
		Lv_label.text = '1' 
	 
	# Добавление информаци в Label (Добавьте недостающие)  
	Name_label.text = str(Global.name_user)
	Hp_label.text = str(Global.hp)
	Hov_label.text = str(Global.hov)
	Bag_label.text = str(Global.bag)
	Wg_label.text = str(Global.wg)

func update_hearts(hp_value: int):
	# Отчищаем контейнер - на всякий случай
	for child in hearts_container.get_children():
		child.queue_free()
	# Считаем количество сердец
	var count = floor(hp_value / 2)
	# Создание текстур в виде сердца
	
	for i in range(count):
		var rect = TextureRect.new()
		rect.texture = heart_icon
		rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		rect.custom_minimum_size = Vector2(32, 32)
		hearts_container.add_child(rect)

func update_time():
	var t = Time.get_time_dict_from_system()
	time_label.text = '%02d:%02d' % [t.minute, t.second]

# Сигнал от Timer
func _on_timer_timeout():
	update_time()
