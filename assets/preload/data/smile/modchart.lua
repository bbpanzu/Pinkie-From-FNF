function createPost(song)

	setVar('camBoomSpeed',1)


end

function beatHit(beat)


	angle = 10

	if beat % 2 == 0 then
		angle = -10
	end
	setVar('iconP1.angle',angle)

	setVar('iconP2.angle',-angle)


	if beat == 300 then
		gf.visible = false
		newSprite(-364.05,-596,true,'spotlights')
		spotlights.loadGraphic(spotlights,'spotlights')

	end
	if beat == 361 then

		
		gf.visible = true
		spotlights.visible = false

	end



	if beat == 32 or beat == 144 or beat == 207 then

		setVar('defaultCamZoom',1.1)
		setCamPos(9999,9999)

	end
	if beat == 79 or beat == 190 then

		setVar('defaultCamZoom',0.9)
		setCamPos(700,300)

	end

end