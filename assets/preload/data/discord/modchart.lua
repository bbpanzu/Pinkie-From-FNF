function createPost()
newCharacter(-261.55,-1199.25,'discord_end',false,false)
newCharacter(-261.55,-1199.25,'discord_die',false,false)
discord_end.alpha = 0.001
discord_die.alpha = 0.001

end


function stepHit(step)
	funni = 117
	if step == 1134 or step == 1135 then
	setCamPos(0,-400)
	dad.playAnim(dad,'hey')
	dad.visible = false;
	end

	if step == 1148 or step == 1149 then
	leftPlrNote.xOffset = funni*3
	rightPlrNote.xOffset = funni*-3
	funni = 112
	end
	if step == 1150 or step == 1151 then
	leftPlrNote.xOffset = funni*3
	rightPlrNote.xOffset = funni*-3
	end
	if step == 1150 or step == 1151 then
	leftPlrNote.xOffset = funni*3
	rightPlrNote.xOffset = funni*-3
	end
	if step == 1404 or step == 1405 then
	leftPlrNote.xOffset = 0
	rightPlrNote.xOffset = 0
	end
	if step == 1152 or step == 1153 then
	setCamPos(9999,9999,true)
	end



end

function beatHit(beat)
curbeat = beat
if curbeat == 541 then
dad.changeCharacter(dad,'discord_end')
dad.playAnim(dad,'stop')
dad.disabledDance = true
end

if curbeat == 574 then
dad.playAnim(dad,'poo')
end
if curbeat == 288 then
dad.visible = true
end
if curbeat == 580 then
flashCam('game',0.6)
gameCam.shake(gameCam,0.02,4,true)
dad.changeCharacter(dad,'discord_die')
dad.disabledDance = true
dad.playAnim(dad,'idle')
end
if curbeat == 594 then
flashCam('game',0.1)
dad.playAnim(dad,'end')
end
if curbeat == 600 then
fadeCam('game',1,'000000')
end
end


function dadTurn()

setVar('defaultCamZoom',0.5)

end
function bfTurn()

setVar('defaultCamZoom',0.8)


end