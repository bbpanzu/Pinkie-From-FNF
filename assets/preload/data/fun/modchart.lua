singTime = 0
singL = 6
function createPost(song)

	setVar('camBoomSpeed',1)

	setVar('beattype','polka')

	newCharacterHUD(200,1000,'pinkie_rap',false,false)

end
function stepHit(beat)

	
	setVar('defaultCamZoom',0.9)
	if getVar('beattype') == 'polka' then
		if beat % 4 < 2 then
			setVar('defaultCamZoom',1)
		end
	end

	singTime = singTime - 1;
	if singTime == 0 then
		pinkie_rap.playAnim(pinkie_rap,'idle')
	end

end


function beatHit(beat)

if singTime <= 0 then pinkie_rap.playAnim(pinkie_rap,'idle') end
if getVar('beattype') == 'porche' then
	day = getVar('healthBar.y') - (getVar('iconP1.height') / 2);
	angle = 10

	if beat % 2 == 0 then
		angle = -10
	end
	setVar('iconP1.y',getVar('healthBar.y') - (getVar('iconP1.height') / 2))

	setVar('iconP2.y',getVar('healthBar.y') - (getVar('iconP1.height') / 2))

	setVar('iconP1.angle',angle)

	setVar('iconP2.angle',-angle)

end

if getVar('beattype') == 'polka' then
	yy = getVar('healthBar.y')-10 - (getVar('iconP1.height') / 2);
	yy2 = getVar('healthBar.y')+10 - (getVar('iconP1.height') / 2);

	if beat % 2 == 0 then
		yy2 = getVar('healthBar.y')-10 - (getVar('iconP1.height') / 2);
		yy = getVar('healthBar.y')+10 - (getVar('iconP1.height') / 2);
	end
	setVar('iconP1.y',yy)

	setVar('iconP2.y',yy2)

	setVar('iconP1.angle',0)

	setVar('iconP2.angle',0)

end




if beat == 16*4 then


	setVar('beattype','porche')

end

if beat == 188 then


	dad.playAnim(dad,'duck')

end
if beat == 160 or beat == 223 or beat == 336 then


setVar('beattype','polka')

end
if beat == 192 or beat == 230 or beat == 320 then


setVar('beattype','trap')

end
if beat == 256 or beat == 230 or beat == 352 then


setVar('beattype','porche')

end
if beat == 384 then


setVar('beattype','none')

end
if beat == 188 then
	dad.playAnim(dad,'duck')

end
if beat == 189 then
playSound('pinkie_jump',0.6)
pinkie_rap.diabledDance = true
	setCamPos(400,300)
	dad.playAnim(dad,'fall')
	setVar('dad.velocity.x',5)
	dad.tween(dad,{['y']=1000},0.6,'sineIn')

end
if beat == 191 then

	setVar('dad.velocity.x',0)
pinkie_rap.tween(pinkie_rap,{['y']=100},0.3,'circOut')
	dad.playAnim(dad,'fall')

end
if beat == 253 then

pinkie_rap.tween(pinkie_rap,{['y']=1000},0.3,'circIn')

end
if beat == 254 then

	setVar('dad.y',-2000)
dad.tween(dad,{['y']=-96},crochet/1000,'linear')

end
if beat == 255 then

	setCamPos(9999,9999,true)
dad.playAnim(dad,'duck',true)

end
if beat == 256 then
dad.diabledDance = false
dad.playAnim(dad,'danceLeft',true)

end



end

function dadNoteHit(d,s,pos,sus,t)
	anim = {'LEFT','DOWN','UP','RIGHT'}
singTime =5
pinkie_rap.disabledDance = true
pinkie_rap.playAnim(pinkie_rap,'sing' .. anim[d+1],true)

end