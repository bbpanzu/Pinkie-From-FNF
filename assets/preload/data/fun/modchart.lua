function createPost(song)

	setVar('camBoomSpeed',1)

	setVar('beattype','polka')

	newCharacter(20,1000,'pinkie_rap',false,false)
	pinkie_rap.setCamera(pinkie_rap,'game')

end
function stepHit(beat)

	
	setVar('defaultCamZoom',0.9)
	if getVar('beattype') == 'polka' then
		if beat % 4 < 2 then
			setVar('defaultCamZoom',1)
		end
	end




end


function beatHit(beat)

pinkie_rap.playAnim(pinkie_rap,'idle')
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
if beat == 189 then

	setCamPos(200,300)
	dad.playAnim(dad,'fall')
	setVar('dad.velocity.x',50)
	setVar('dad.acceleration.y',5000)

end
if beat == 191 then

pinkie_rap.tween(pinkie_rap,{[y]=100},0.3,'circOut')
	dad.playAnim(dad,'fall')
	setVar('dad.velocity.x',0)
	setVar('dad.acceleration.y',0)

end


end