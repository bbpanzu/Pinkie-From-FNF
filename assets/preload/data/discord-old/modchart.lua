function createPost()

newCharacter(-261.55,-1199.25,'discord-end',false,false)
discord_end.visible = false


end


function stepHit(step)

	if step == 305 then
	dad.playAnim(dad,'new_scene')--changeCharacter(dad,'discord-atlas_newscene')
	end


	if step == 494 then
	dad.visible = false
	discord-atlas_gofast.visible = true
	trace(getVar('dad.curCharacter'))
	end




	if step == 337 then
	setVar('ponyvilleBG.visible',false)
	end



end
