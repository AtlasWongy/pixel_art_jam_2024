extends FishResource
class_name Swordfish

func fish_init(fish:Fish):
	print(fish.position)

func on_collision_with_body_param(body:Bubble,fish:Fish):
	print(body.position)
	#size of the bubble is 18x18 px
	print(fish.position)
	#size of the fish is 32x32 px
	if(abs(body.position.x-fish.position.x) > 20 or (fish.position.y-body.position.y)> 20):
		print("woah!")
	else:
		pass
		#the bubble should be destroyed here bcos this would be a front collision
