extends Button


func set_data(item):
	self.text = "[Obtain] " + str(item["source_name"])
